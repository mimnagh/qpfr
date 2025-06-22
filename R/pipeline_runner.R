
# Load required libraries and source R modules
library(arrow)  # for writing results

# Load R6 classes for scoring, logging, data handling, and optimization
source(here::here("R/AlphaScorer.R"))
source(here::here("R/IRScorer.R"))  # Assuming IRScorer is in the same directory
source(here::here("R/MLFlowProxy.R"))
source(here::here("R/DataProvider.R"))
source(here::here("R/OptimizerGraphLearner.R"))

# Main function to execute the full pipeline
run_pipeline <- function(input_csv = here::here("data/sector_factor_timeseries.csv"),
                         config_file = here::here("data/optimizer_config.yaml"),
                         output_file = here::here("output/optimization_results.parquet")) {

  # Step 1: Load task and config using DataProvider
  data_provider <- DataProvider$new(input_csv, config_file)
  inputs <- data_provider$load()
  task <- inputs$task
  config <- inputs$config
  X <- inputs$X
  y <- inputs$y

  # Step 2: Set up and start MLflow logging session
  logger <- MLFlowProxyNoop$new()
  logger$start()

  # Step 3: Build optimization graph and train it on task
  graph_learner <- build_optimizer_graph(config$optimizer)
  graph_learner$train(task)
  prediction <- graph_learner$predict(task)

  # Step 4: Log configuration parameters to MLflow
  logger$log_param("features", paste(colnames(X), collapse = ","))
  logger$log_param("lower_bound", paste(purrr::map_dbl(config$optimizer$bounds, 1), collapse = ","))
  logger$log_param("upper_bound", paste(purrr::map_dbl(config$optimizer$bounds, 2), collapse = ","))

  # Step 5: Evaluate results using custom scorers
  alpha_score <- AlphaScorer$new()$score(prediction)
  ir_score <- IRScorer$new()$score(prediction)
  logger$log_metric("alpha", alpha_score)
  logger$log_metric("ir", ir_score)

  # Step 6: Write output predictions to parquet and log as artifact
  result_dt <- data.table::data.table(predicted_return = prediction$response, actual_return = y)
  arrow::write_parquet(result_dt, output_file)
  logger$log_artifact(output_file)
  logger$log_artifact("output/weights.parquet")

  # Step 7: End MLflow run
  logger$end()

  # Return result data.table
  return(result_dt)
}
