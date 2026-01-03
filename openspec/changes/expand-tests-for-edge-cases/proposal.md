# Change: Expand test coverage for edge cases and integration

## Why
Current tests cover basic happy path only. Edge cases (invalid configs, zero variance, convergence failures) are untested and could regress silently.

## What Changes
- Add unit tests for `DataProvider` validation, NA handling, and schema errors.
- Add unit tests for `PortfolioOptimizer` handling of invalid bounds, zero-variance targets, non-converging optimizations.
- Add a small integration test for `run_backtest()` using fixtures in `data/`.
- Add tests for evaluator/weight loading to ensure config-aligned target/feature selection and serialization shape.

## Acceptance Criteria
- Tests MUST include deterministic fixtures with `seed` usage to assert reproducible backtest outputs.
- Tests MUST verify numerical-guard fallbacks (eps) produce numeric, non-NA IR and that warnings are emitted for degenerate cases.
- Tests MUST assert `DataProvider` validation errors for malformed configs and NA modes behave as specified.
- Tests MUST cover model storage contract: named numeric vector shape, migration helper behavior, and evaluator round-trip.

## Notes
- Add fixtures: `tests/fixtures/optimizer_config_malformed.yaml`, `tests/fixtures/na_rows.csv`, and a deterministic `two_asset_small.csv` used for integration tests.

## Impact
- Tests added under `tests/testthat/` and fixtures under `tests/fixtures/`.
