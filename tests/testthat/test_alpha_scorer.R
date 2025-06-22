# tests/testthat/test_alpha_scorer.R


PredictionRegrFake = R6::R6Class("PredictionRegrFake",
  inherit = PredictionRegr,
  public = list(
    initialize = function(truth, response) {
      super$initialize(
        task = NULL,
        truth = truth,
        response = response,
        row_ids = seq_along(truth)
      )
    }
  ))

test_that("AlphaScorer returns mean difference", {
  scorer = AlphaScorer$new()
  pred = PredictionRegrFake$new(truth = c(0.1, 0.2), response = c(0.15, 0.25))
  score = scorer$score(pred)
  expect_equal(score, 0.05)
})
