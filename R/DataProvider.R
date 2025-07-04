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
      # Load optimization configuration from YAML
      config <- yaml::read_yaml(private$config_file)

      # Read input CSV with factor exposures and target column
      dt = data.table::fread(private$input_csv)
      dt = na.omit(dt)  # Remove rows with NA values
      if(!is.null(config$optimizer$target_column)) {
        if(!config$optimizer$target_column %in% colnames(dt)) {
          stop(paste("Target column", config$optimizer$target_column, "not found in data."))
        }
        target_column = config$optimizer$target_column
      } else {
        target_column = "target_column"
      }
      # Separate target and features
      y <- dt[[target_column]]                                   # Response variable
      # Remove target column from features
      feature_columns <- names(config$optimizer$bounds)
      X <- dt[,feature_columns]           # Feature matrix
      # Create a regression task using mlr3
      task <- mlr3::TaskRegr$new("portfolio_task",
                                backend = dt[,c(feature_columns,target_column)],
                                target = target_column)

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
