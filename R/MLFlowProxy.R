library(mlflow)
library(R6)

MLFlowProxyBase = R6Class("MLFlowProxyBase",
  public = list(
    run = NULL,
    start = function() {},
    log_param = function(key, value) {},
    log_metric = function(key, value) {},
    log_artifact = function(path) {},
    end = function() {}
  )
)
MLFlowProxyNoop = R6Class("MLFlowProxyNoop",
  inherit = MLFlowProxyBase,
  public = list(
    # No need to redefine methods unless you want to override base behavior
  )
)

# Load MLflow and R6 for experiment tracking and object-oriented structure

# Define a proxy class to wrap mlflow logging commands
MLFlowProxy = R6Class("MLFlowProxy",
  public = list(
    run = NULL,  # Internal run object

    # Start a new MLflow run and record its ID
    start = function() {
      self$run = mlflow::mlflow_start_run()
      writeLines(self$run$run_uuid, "output/latest_run_id.txt")
    },

    # Log a parameter (e.g., config value)
    log_param = function(key, value) {
      mlflow::mlflow_log_param(key, as.character(value))
    },

    # Log a performance metric (e.g., alpha or IR)
    log_metric = function(key, value) {
      mlflow::mlflow_log_metric(key, value)
    },

    # Log an artifact file (e.g., model weights, predictions)
    log_artifact = function(path) {
      mlflow::mlflow_log_artifact(path)
    },

    # Close the MLflow run
    end = function() {
      mlflow::mlflow_end_run()
    }
  )
)

