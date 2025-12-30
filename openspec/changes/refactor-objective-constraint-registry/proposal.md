# Change: Refactor objective/constraint registry into dedicated module

## Why
The current registry is embedded inside `PortfolioOptimizer`, making it harder to test, extend, and reuse. Extracting it to its own module/class improves separation of concerns and enables pluggable objectives/constraints.

## What Changes
- Create `R/ObjectiveRegistry.R` (R6 class) that registers objective and constraint functions.
- Update `PortfolioOptimizer` to depend on the registry rather than owning registries inline.
- Provide documentation and patterns for adding new objectives/constraints.

## Impact
- Affected code: `R/PortfolioOptimizer.R`, new `R/ObjectiveRegistry.R`.
- Tests: unit tests for registry and updated optimizer tests.
