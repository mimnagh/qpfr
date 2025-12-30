# Change: Expand test coverage for edge cases and integration

## Why
Current tests cover basic happy path only. Edge cases (invalid configs, zero variance, convergence failures) are untested and could regress silently.

## What Changes
- Add unit tests for `DataProvider` validation, NA handling, and schema errors.
- Add unit tests for `PortfolioOptimizer` handling of invalid bounds, zero-variance targets, non-converging optimizations.
- Add a small integration test for `run_backtest()` using fixtures in `data/`.

## Impact
- Tests added under `tests/testthat/` and fixtures under `tests/fixtures/`.
