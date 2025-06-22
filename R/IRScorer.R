library(R6)
IRScorer = R6Class("IRScorer",
  public = list(
    score = function(prediction) {
      alpha = mean(prediction$response - prediction$truth)
      alpha / sd(prediction$response - prediction$truth)
    }
  )
)
