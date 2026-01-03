# Change: Fix `PortfolioOptimizer` model storage and prediction consistency

## Why
`PortfolioOptimizer` currently stores optimized weights as a one-row `data.frame` which makes numeric operations in `.predict()` brittle and inconsistent. Predict should expect a numeric weight vector with stable names and ordering.

## What Changes
- Store `self$model` as a named numeric vector of weights instead of a data.frame.
- Ensure `.predict()` converts stored weights to numeric vector and documents expected shape.
- Update artifact writing/reading (pipeline/backtest/evaluator) to serialize/deserialize the vector shape consistently.
- Add tests to assert predict/training contract and end-to-end prediction shape.

## Acceptance Criteria
- `self$model` MUST be a named numeric vector after `.train()` (e.g. `c(asset1 = 0.2, asset2 = 0.8)`).
- `.predict()` MUST validate that the weight vector length and names exactly match `task$feature_names` (order-insensitive check using names, and order-sensitive mapping to features).
- Serialization format for weights (RDS or JSON) MUST preserve names and numeric type; any existing Parquet write/read paths MUST be updated to round-trip the named numeric vector.
- Unit/integration tests MUST include: training -> save -> load -> predict equivalence, prediction length/ordering assertions, and evaluator compatibility when loading external weight artifacts.

## Notes
- This change pairs with `add-config-examples-and-dev-readme` (serialization examples) and `expand-tests-for-edge-cases` (tests for serialization and prediction shape).

## Impact
- Affected code: `R/PortfolioOptimizer.R`, any code reading `self$model`.
- Tests: update/extend optimizer tests.
