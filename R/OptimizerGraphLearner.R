# R/OptimizerGraphLearner.R

library(mlr3)
library(mlr3pipelines)
library(mlr3filters)
source(here::here("R/PortfolioOptimizer.R"))

build_optimizer_graph <- function(config = list()) {
  print(config$bounds)
  optimizer <- PortfolioOptimizer$new(config)

  print(optimizer$.train)

  # Create pipeline with optional filtering and scaling
  filter_po = po("filter", filter = mlr3filters::FilterVariance$new(), param_vals = list(filter.frac = 1))
  scale_po = po("scale")
  learner_po = po("learner", learner = optimizer)

  # graph = filter_po %>>% scale_po %>>% learner_po
  GraphLearner$new(learner_po)
}
