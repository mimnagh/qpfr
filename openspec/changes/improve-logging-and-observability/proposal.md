# Change: Improve logging, metrics and optimizer observability

## Why
Current logging is minimal because a "no-op" logger (`MLFlowProxyNoop`) is hardcoded in key execution paths like `run_backtest` and `run_pipeline`. This prevents any real metrics from being captured.

Properly instrumenting the application for convergence status, objective values, and data-loading metrics is essential for debugging and production monitoring. This requires replacing the hardcoded no-op logger with a configurable logging mechanism.

## What Changes
- Standardize logging calls via a small logger interface (start, log_param, log_metric, end) and ensure `MLFlowProxy` is used when available.
- Log optimizer convergence status, objective values per iteration where available, and data-loading row counts.
- Replace default no-op usage in `run_pipeline` and `run_backtest` with a real logger factory (falling back to noop only when MLflow is unavailable) and expose logger injection for tests.
- Add tests that verify logger calls or use a test-noop logger that records calls.

## Acceptance Criteria
- A logger factory MUST be available and `run_backtest()`/`run_pipeline()` MUST accept a `logger` parameter (default: factory-provided logger). Tests MUST be able to inject a test logger.
- `PortfolioOptimizer` MUST expose hooks to report optimizer status (converged, exit code, objective value) and these MUST be logged at least once after training.
- Data loading MUST log the number of rows read and number of NA rows found when `na_mode != drop`.
- Tests MUST include at least one test that asserts the test logger received expected calls (e.g., `log_metric('optimizer_obj', ...)`, `log_param('resampling', 'rolling_window')`).

## Impact
- Files: `R/MLFlowProxy.R`, `R/backtest_runner.R`, `R/pipeline_runner.R`, `R/PortfolioOptimizer.R`.
- Tests: logger interaction tests.
