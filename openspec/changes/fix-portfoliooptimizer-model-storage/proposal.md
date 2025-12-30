# Change: Fix `PortfolioOptimizer` model storage and prediction consistency

## Why
`PortfolioOptimizer` currently stores optimized weights as a one-row `data.frame` which makes numeric operations in `.predict()` brittle and inconsistent. Predict should expect a numeric weight vector with stable names and ordering.

## What Changes
- Store `self$model` as a named numeric vector of weights instead of a data.frame.
- Ensure `.predict()` converts stored weights to numeric vector and documents expected shape.
- Add tests to assert predict/training contract and end-to-end prediction shape.

## Impact
- Affected code: `R/PortfolioOptimizer.R`, any code reading `self$model`.
- Tests: update/extend optimizer tests.
