## 1. Implementation
- [ ] Add epsilon guards in `markowitz`, `IRScorer`, and backtest/pipeline IR computations.
- [ ] Make epsilon and fallback behavior configurable via `config$optimizer`.
- [ ] Add unit tests for zero-variance and constant-target datasets.

## 1. Implementation
- [ ] Introduce a small positive `eps` default (e.g. `1e-8`) and propagate it to `PortfolioOptimizer` and `IRScorer` via config.
- [ ] Replace exact `sigma == 0` checks with `if (sigma < eps) { /* fallback */ }` and log which fallback was used.
- [ ] Ensure `run_backtest()` uses the same guarded IR computation (no direct `alpha / sd(...)` without check).

## 2. Tests
- [ ] Add unit tests for: constant `y` (zero variance), constant predictions (zero variance of residuals), and nearly-constant cases to assert the chosen fallback is used and deterministic.

## 3. Review
- [ ] Run tests and document `eps` configuration and recommended defaults in developer docs.

## 2. Review
- [ ] Run tests and include examples in docs showing guarded behavior.
