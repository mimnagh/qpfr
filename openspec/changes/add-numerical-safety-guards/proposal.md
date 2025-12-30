# Change: Add numerical safety guards in objectives and metrics

## Why
Objectives and evaluation metrics (Sharpe-like markowitz objective, IR calculation) can divide by zero or produce NA when variance is zero. This results in unstable training and crashes during backtests.

## What Changes
- Add explicit guards against zero/near-zero standard deviation in `markowitz` objective and backtest IR calculation.
- Define fallbacks (e.g., return large penalty, return 0, or use epsilon) and make behaviour configurable.
- Add tests for zero-variance targets and degenerate cases.

## Impact
- Affected files: `R/PortfolioOptimizer.R`, `R/backtest_runner.R`.
- Tests: new edge-case unit tests.
