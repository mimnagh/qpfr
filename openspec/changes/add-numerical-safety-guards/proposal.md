# Change: Add numerical safety guards in objectives and metrics

## Why
Objectives and evaluation metrics (Sharpe-like markowitz objective, IR calculation) can divide by zero or produce NA when variance is zero. This results in unstable training and crashes during backtests.

## What Changes
- Add explicit guards against zero/near-zero standard deviation in `markowitz` objective, `IRScorer`, and backtest/pipeline IR calculation.
- Define fallbacks (e.g., return large penalty, return 0, or use epsilon) and make behaviour configurable.
- Add tests for zero-variance targets and degenerate cases.

## Acceptance Criteria
- `markowitz` objective MUST use an epsilon check (e.g. `if (sigma < eps)`) rather than exact zero equality and expose `eps` via config.
- `IRScorer` and any ad-hoc IR computation in `run_backtest()` MUST return a defined numeric value (not NA/Inf) for degenerate inputs and log a warning when variance is near-zero.
- Unit tests MUST cover constant-target, constant-prediction, and very small-variance cases and assert deterministic fallback behavior.

## Impact
- Affected files: `R/PortfolioOptimizer.R`, `R/backtest_runner.R`.
- Tests: new edge-case unit tests.
