## 1. Implementation
- [ ] In `DataProvider::load()`, replace the direct `na.omit(dt)` call with a configurable behavior based on a new `na_mode` parameter (`drop`, `error`, `report`, `impute`).
- [ ] Implement the logic for each `na_mode`. For `impute`, provide a simple hook for a user-supplied imputation function.
- [ ] In `DataProvider.R`, refactor all `data.table` column selections to use safe patterns (e.g., `dt[, ..feature_columns]` or `dt[, feature_columns, with = FALSE]`).
- [ ] Before selection, add a check to ensure all requested columns (`target_column`, `order` columns, feature columns) exist in the `data.table`, raising a clear error if not.
- [ ] Call the generic configuration validator (from the `validate-optimizer-config-schema` change) within `DataProvider::load()`.

## 2. Testing
- [ ] Create new data fixtures in `tests/testthat/fixtures/` that include NA values and missing columns to test the new behaviors.
- [ ] Add unit tests for `DataProvider.R` that verify the correct behavior for each `na_mode`.
- [ ] Add unit tests that confirm the system raises an error when a requested column is missing.

## 3. Documentation and Review
- [ ] Update `openspec/project.md` or other developer documentation to describe the new `na_mode` feature.
- [ ] Conduct a PR review to ensure the changes are robust and well-tested.
