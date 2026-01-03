# Change: Refactor objective/constraint registry and consolidate scoring logic

## Why
The current objective and constraint registry is embedded inside `PortfolioOptimizer`, making it hard to test, extend, and reuse.

Furthermore, scoring logic (e.g., Alpha, Information Ratio) is duplicated across multiple files, including `R/backtest_runner.R` and `R/evaluator.R`. This code duplication leads to inconsistency, increases maintenance overhead, and makes the system prone to bugs, as updates must be manually synchronized across different locations.

Extracting all metric calculations into a dedicated, reusable module improves separation of concerns, eliminates redundancy, and enables pluggable objectives/constraints.

## What Changes
- Create `R/ObjectiveRegistry.R` (R6 class) that registers objective, constraint, and scorer functions (e.g., `AlphaScorer`, `IRScorer`).
- Update `PortfolioOptimizer` to depend on the registry.
- **Refactor `R/backtest_runner.R`** to remove its internal scoring logic and use the centralized registry instead.
- **Refactor `R/evaluator.R`** to also remove its duplicated scoring logic and use the registry.
- Provide clear documentation and patterns for adding new objectives, constraints, and scorers.

## Impact
- Affected code: `R/PortfolioOptimizer.R`, `R/backtest_runner.R`, `R/evaluator.R`.
- New files: `R/ObjectiveRegistry.R`.
- Tests: New unit tests for the registry and updated tests for the optimizer, backtest runner, and evaluator.
