AlphaScorer = R6::R6Class(
  "AlphaScorer",
  public = list(
    score = function(prediction) {
      mean(prediction$response - prediction$truth)
    }
  )
)
