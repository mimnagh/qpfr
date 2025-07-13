# tests/testthat/test_ir_scorer.R

PredictionRegrFake = R6::R6Class(
  "PredictionRegrFake",
  inherit = mlr3::PredictionRegr,
  public = list(
    initialize = function(truth, response) {
      super$initialize(
        task = NULL,
        truth = truth,
        response = response,
        row_ids = seq_along(truth)
      )
    }
  )
)

test_that("IRScorer returns alpha / TE", {
  scorer = IRScorer$new()
  truth = c(0.1, 0.2, 0.15)
  response = c(0.15, 0.25, 0.20)
  alpha = response - truth
  expected_ir = mean(alpha) / sd(alpha)

  pred = PredictionRegrFake$new(truth = truth, response = response)
  score = scorer$score(pred)
  expect_equal(score, expected_ir)
})
