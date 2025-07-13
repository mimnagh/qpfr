# R/backtest_runner.R

run_backtest <- function(
  input_csv = here::here("data/sector_factor_timeseries.csv"),
  config_file = here::here("data/optimizer_config.yaml"),
  initial_window = 3,
  horizon = 1,
  folds = 2
) {
  data_provider <- DataProvider$new(input_csv, config_file)
  inputs <- data_provider$load()
  task <- inputs$task
  config <- inputs$config
  resampling <- mlr3::rsmp("fcst.cv")
  resampling$param_set$values <- list(
    window_size = initial_window,
    horizon = horizon,
    folds = folds,
    fixed_window = TRUE,
    step_size = 1
  )
  resampling$instantiate(task)

  all_predictions <- list()
  all_truths <- list()

  logger <- MLFlowProxyNoop$new()
  logger$start()
  logger$log_param("resampling", "rolling_window")

  for (i in seq_len(resampling$iters)) {
    train_idx <- resampling$train_set(i)
    test_idx <- resampling$test_set(i)

    task_train <- task$clone()$filter(train_idx)
    task_test <- task$clone()$filter(test_idx)

    learner <- PortfolioOptimizer$new(config$optimizer)
    learner$train(task_train)
    prediction <- learner$predict(task_test)

    all_predictions[[i]] <- prediction$response
    all_truths[[i]] <- task_test$truth()
  }

  pred_vec <- unlist(all_predictions)
  truth_vec <- unlist(all_truths)
  alpha <- mean(pred_vec - truth_vec)
  ir <- alpha / sd(pred_vec - truth_vec)

  logger$log_metric("backtest_alpha", alpha)
  logger$log_metric("backtest_ir", ir)
  logger$end()

  data.table::data.table(predicted_return = pred_vec, actual_return = truth_vec)
}
