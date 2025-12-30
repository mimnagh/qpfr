# Change: Improve DataProvider robustness and validation

## Why
Data ingestion currently drops rows silently (`na.omit`) and uses fragile `data.table` column selection patterns. This makes debugging data issues and downstream failures harder and risks silent data loss.

## What Changes
- Add explicit validation and reporting for missing/NA rows instead of silently dropping them.
- Use safe `data.table` column selection (`..cols` or `with = FALSE`) and validate requested feature/target columns exist.
- Add schema validation for expected `config$optimizer` fields (bounds, order, target_column).
- Provide optional imputation hooks and informative error messages.

## Impact
- Affected code: `R/DataProvider.R` and any callers (backtest runner, pipeline runner).
- Tests: add unit tests for missing columns, NA rows, and invalid config shapes.
