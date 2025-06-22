library(R6)            # R6 classes for OOP
library(mlr3)          # Machine learning framework
library(nloptr)        # Nonlinear optimization library
library(arrow)         # For saving output weights as parquet
library(purrr)         # Functional programming helpers
library(paradox)

# Define the PortfolioOptimizer class
PortfolioOptimizer = R6Class("PortfolioOptimizer",
  inherit = mlr3::LearnerRegr,
  public = list(
    registry = NULL,  # Registry for objective and constraint functions
    # Constructor: initialize optimizer with configuration
    initialize = function(config = list()) {
        registry = list(
            # Registry of available objective functions
            .objective_registry = list(
              mean_error = function(w, X, y) -mean(X %*% w - y)  # Negative mean error (maximize alpha)
            ),

            # Registry of equality constraints
            .constraint_registry = list(
              weights_sum_to_1 = function(w) sum(w) - 1  # Ensure portfolio weights sum to 1
            )                                    
          )

      param_set_template = ps(
        # User-defined bounds per feature
        bounds = p_uty(),
        # Ordered list of feature names
        feature_names = p_uty(),
        # Name of objective function from registry
        objective = p_fct(levels = names(registry$.objective_registry)),
        # Name of constraint function from registry
        constraint = p_fct(levels = names(registry$.constraint_registry)),
        # Initial weights
        init_w = p_uty()
      )

      # Initialize learner metadata
      super$initialize(
        id = "regr.portfolio_optimizer",
        param_set = param_set_template,
        feature_types = c("numeric"),
        predict_types = c("response")
      )
      # Assign values from config
      self$param_set$values$bounds <- config$bounds
      self$param_set$values$feature_names <- names(config$bounds)
      self$param_set$values$objective <- config$objective
      self$param_set$values$constraint <- config$constraint
      self$param_set$values$init_w <- config$init_w

      # Store the registry for later use
      self$registry <- registry
    }
  ), # End of public methods
  private = list(
    # Prediction logic using trained weights
    .predict = function(task) {
      # Multiply input features by weights to compute predicted return
      X = as.matrix(task$data(cols = task$feature_names))
      response = as.vector(X %*% t(self$model))
      mlr3::PredictionRegr$new(task = task, response = response)
    },

    # Training logic for optimization
    .train = function(task) {
      # Extract feature matrix X and target vector y from the task
      X = as.matrix(task$data(cols = task$feature_names))
      y = task$truth()
      n = ncol(X)

      # Initialize weights equally across all features, unless provided in config
      if (!is.null(self$param_set$values$init_w)) {
        init_w = self$param_set$values$init_w
      } else {
        init_w = rep(1/n, n)
      }

      # Extract bounds for each feature from configuration
      bounds <- self$param_set$values$bounds
      features <- self$param_set$values$feature_names

      # Create lower and upper bound vectors in the same order as features
      lb <- purrr::map_dbl(features, ~ bounds[[.x]][1])
      ub <- purrr::map_dbl(features, ~ bounds[[.x]][2])
      # Retrieve selected objective and constraint functions from registry
      obj_fn <- self$registry$.objective_registry[[self$param_set$values$objective]]
      eq_fn <- self$registry$.constraint_registry[[self$param_set$values$constraint]]

      # Define wrapper functions for nloptr
      objective_fn = function(w) obj_fn(w, X, y)       # Objective to minimize
      eq_constraint = function(w) eq_fn(w)             # Equality constraint

      # Run the optimizer with constraints and bounds
      res <- nloptr::slsqp(
          x0 = init_w,
          fn = objective_fn,
          hin = NULL,
          heq = eq_constraint,
          lower = lb,
          upper = ub,
          control = list(
            xtol_rel = 1e-6,
            maxeval = 500
          )
        )

      # Store the optimized weights in the model field
      self$model = res$par
      # Save the weights to disk as a named row in a Parquet file
      weights_df <- data.frame(t(self$model))
      colnames(weights_df) <- task$feature_names
      arrow::write_parquet(weights_df, here::here("output/weights.parquet"))
    }
  ) # End of private methods

)
