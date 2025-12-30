## 1. Implementation
- [ ] Add `seed` argument to `run_backtest()` and ensure it sets RNG state (`set.seed(seed)`).
- [ ] Document `renv::restore()` usage in `README.adoc` or `docs/DEV.md`.
- [ ] Add CI instruction comment referencing `renv` restore step in workflow.

## 2. Review
- [ ] Verify tests remain deterministic when seed provided.
