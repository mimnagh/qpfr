# R/OptimizerGraphLearner.R
build_optimizer_graph <- function(config = list()) {
  optimizer <- PortfolioOptimizer$new(config)
  learner_po = po("learner", learner = optimizer)

  GraphLearner$new(learner_po)
}
