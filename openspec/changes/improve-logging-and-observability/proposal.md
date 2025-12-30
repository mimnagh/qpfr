# Change: Improve logging, metrics and optimizer observability

## Why
Current logging is minimal (noop logger used in tests). Instrumentation for convergence status, objective values, and data-loading metrics will aid debugging and production monitoring.

## What Changes
- Standardize logging calls via a small logger interface (start, log_param, log_metric, end) and ensure MLFlowProxy is used when available.
- Log optimizer convergence status, objective values per iteration where available, and data-loading row counts.
- Add tests that verify logger calls or use a test-noop logger that records calls.

## Impact
- Files: `R/MLFlowProxy.R`, `R/backtest_runner.R`, `R/PortfolioOptimizer.R`.
- Tests: logger interaction tests.
