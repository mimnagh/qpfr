library(R6)
AlphaScorer = R6Class("AlphaScorer",
  public = list(
    score = function(prediction) {
      mean(prediction$response - prediction$truth)
    }
  )
)
