# tests/testthat/test_portfolio_optimizer.R

test_that("PortfolioOptimizer trains and predicts", {
  X = data.frame(
    SectorA = c(0.1, 0.2, 0.15),
    SectorB = c(0.05, 0.07, 0.06),
    SectorC = c(0.03, 0.04, 0.02)
  )
  y = c(0.06, 0.08, 0.07)

  task = mlr3::TaskRegr$new("toy", backend = cbind(X, target = y), target = "target")
  config <- list(
    bounds = list(SectorA = c(0, 1), SectorB = c(0, 1), SectorC = c(0, 1)), # Bounds for each sector
    objective = "mean_error", # Objective function to minimize
    constraint = "weights_sum_to_1" # Constraint to ensure weights sum to 1
  )
  learner = PortfolioOptimizer$new(config)
  learner$train(task)
  prediction = learner$predict(task)

  expect_s3_class(prediction, "PredictionRegr")
  expect_equal(length(prediction$response), nrow(X))
})
