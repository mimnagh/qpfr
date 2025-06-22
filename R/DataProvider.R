# R/DataProvider.R

# Load required libraries
library(R6)         # For R6 object-oriented system
library(data.table) # Efficient data handling
library(yaml)       # To read configuration files
library(mlr3)       # ML task definition

# DataProvider loads input data and YAML config for the optimizer
DataProvider = R6Class("DataProvider",
  public = list(

    # Constructor: specify CSV and YAML file paths
    initialize = function(input_csv = here::here("data/sector_factor_timeseries.csv"),
                          config_file = here::here("data/optimizer_config.yaml")) {
      private$input_csv <- input_csv
      private$config_file <- config_file
    },

    # Loads the dataset and configuration, returns ML task and config
    load = function() {
      # Read input CSV with factor exposures and target column
      dt = data.table::fread(private$input_csv)

      # Separate target and features
      y = dt[["target_column"]]                                   # Response variable
      X = dt[, !"target_column", with = FALSE]                    # Features only

      # Create a regression task using mlr3
      task = mlr3::TaskRegr$new("portfolio_task",
                                backend = cbind(X, target = y),
                                target = "target")

      # Load optimization configuration from YAML
      config = yaml::read_yaml(private$config_file)

      # Attach feature names to config to align with bounds
      config$optimizer$feature_names <- colnames(X)

      # Return all necessary components for pipeline
      list(task = task, config = config, X = X, y = y)
    }
  ),

  private = list(
    input_csv = NULL,
    config_file = NULL
  )
)
