## 1. Implementation
- [ ] Add `seed` argument to `run_backtest()` and ensure it sets RNG state (`set.seed(seed)`).
- [ ] Add `seed` argument to `run_pipeline()` and propagate to mlr3 resampling/graph learners before training.
- [ ] Document `renv::restore()` usage in `README.adoc` or `docs/DEV.md`.
- [ ] Add CI instruction comment referencing `renv` restore step in workflow.

## 1. Implementation
- [ ] Add `seed` argument to `run_backtest()` and call `set.seed(seed)` at the start when provided.
- [ ] Ensure resampling instantiation happens after the seed is set so `mlr3::rsmp("fcst.cv")$instantiate(task)` is deterministic.
- [ ] Add `seed` parameter to `run_pipeline()` and thread it into learners and any optimizer calls.
- [ ] Update tests to call `run_backtest(seed = 42)` twice and assert identical outputs for a deterministic fixture.
- [ ] Document `renv::restore()` usage and add a short `docs/DEV.md` checklist covering restore, seed, and common troubleshooting.

## 2. Review
- [ ] Validate deterministic test passes on CI when seed is provided.

## 2. Review
- [ ] Verify tests remain deterministic when seed provided (both backtest and pipeline entrypoints).
