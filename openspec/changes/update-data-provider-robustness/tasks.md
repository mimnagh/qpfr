## 1. Implementation
- [ ] Add input validation and NA reporting to `R/DataProvider.R`.
- [ ] Replace `na.omit(dt)` with configurable behavior: `error|report|impute|drop`.
- [ ] Use `dt[, ..feature_columns]` or `dt[, feature_columns, with = FALSE]` for selection.
- [ ] Add unit tests covering missing target, missing features, and NA-handling modes.

## 2. Review
- [ ] Request PR review and run `openspec validate` (if deltas added).

## 3. Release
- [ ] Merge and update docs describing config schema and NA behavior.
