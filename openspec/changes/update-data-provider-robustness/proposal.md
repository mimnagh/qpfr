# Change: Improve DataProvider robustness for NA handling and column selection

## Why
Data ingestion currently drops rows with missing values (`NA`) silently via `na.omit`. This risks silent data loss and makes debugging data quality issues extremely difficult. Furthermore, the code uses fragile `data.table` column selection patterns that can fail unexpectedly.

## What Changes
- **Make NA handling explicit and configurable.** Introduce a `na_mode` parameter in `DataProvider$load()` with the following behaviors:
  - `drop` (current behavior, but with a warning)
  - `error` (fail fast if any NAs are present)
  - `report` (log NA counts and affected columns)
  - `impute` (allow for a pluggable imputation function)
- **Use safe `data.table` column selection** (e.g., `dt[, ..feature_columns]` or `dt[, feature_columns, with = FALSE]`) to prevent errors.
- **Validate column existence.** Ensure requested feature and target columns exist in the dataset *before* attempting to use them.
- **Integrate configuration validation.** Utilize the dedicated configuration validation utility (from the `validate-optimizer-config-schema` change) to check the config file, rather than implementing new validation logic here.

## Acceptance Criteria
- By default, `DataProvider::load()` MUST NOT silently drop NA rows. If NAs are present, it should error or warn, depending on the configured `na_mode`.
- The `na_mode` parameter MUST be implemented and tested for all behaviors.
- Column selection MUST use safe `data.table` semantics and raise a clear error if a requested column is absent.
- `DataProvider::load()` MUST call the external config validator.

## Impact
- Affected code: `R/DataProvider.R`, `R/pipeline_runner.R`, and `R/backtest_runner.R`.
- Tests: New unit tests for each `na_mode`, missing column scenarios, and integration with the config validator.
