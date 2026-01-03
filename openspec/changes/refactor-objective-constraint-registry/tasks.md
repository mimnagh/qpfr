## 1. Implementation
- [ ] Add `R/ObjectiveRegistry.R` implementing registration and lookup of objectives and constraints.
- [ ] Integrate existing scorers (`AlphaScorer`, `IRScorer`) into the new registry.
- [ ] Update `PortfolioOptimizer` to accept a registry instance (DI).
- [ ] Refactor `R/backtest_runner.R` to remove duplicated scoring logic and use the registry.
- [ ] Refactor `R/evaluator.R` to remove duplicated scoring logic and use the registry.
- [ ] Add unit tests for registry behavior.
- [ ] Update integration tests for the optimizer, backtest runner, and evaluator to use a mock registry where appropriate.

## 2. Design
- [ ] Create `design.md` describing public API, plugin patterns, and migration steps for all affected modules.
