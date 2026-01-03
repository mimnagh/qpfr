## 1. Implementation
- [ ] Implement a simple logger factory, `logger_factory()`, that returns an object conforming to the logger interface (`start`, `log_param`, `log_metric`, `end`). This factory should return an `MLFlowProxy` instance if the package is available, otherwise an `MLFlowProxyNoop` instance.
- [ ] Add a `logger` parameter to `run_backtest()` in `R/backtest_runner.R` and `run_pipeline()` in `R/pipeline_runner.R`, defaulting to `logger_factory()`.
- [ ] Pass the `logger` object down into `DataProvider`, `PortfolioOptimizer`, and other relevant components from the runners.
- [ ] In `PortfolioOptimizer$.train()`, capture the return value from `nloptr` and use the logger to record the objective value and convergence status (e.g., `logger$log_metric('optimizer_obj', ...)`).
- [ ] In `DataProvider$load()`, add calls to log the number of rows read (`n_rows`) and NA rows found (`n_na_rows`) via the logger.
- [ ] Create a `TestLogger` implementation that records calls made to it.
- [ ] Add unit tests that inject the `TestLogger` to assert that the correct logging calls are made for data loading, optimizer runs, and backtest metrics.

## 2. Review
- [ ] Conduct a PR review to ensure that no hard dependency on MLflow has been introduced in the core logic or tests, and confirm that logger injection is used throughout the tests.
