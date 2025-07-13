# tests/testthat/test_backtest_runner.R

testthat::test_that("backtest runs without error", {
  result <- run_backtest(
    input_csv = here::here("data/sector_factor_timeseries.csv"),
    config_file = here::here("data/optimizer_config.yaml"),
    initial_window = 3,
    horizon = 1
  )
  expect_s3_class(result, "data.table")
  expect_named(result, c("predicted_return", "actual_return"))
})
