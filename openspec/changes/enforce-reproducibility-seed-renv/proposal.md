# Change: Enforce reproducibility (seed control) and `renv` guidance

## Why
Reproducible backtests and experiments require explicit seed management and a documented environment restore process. While `renv` exists, CI and developer docs need explicit steps and optional seed parameterization.

## What Changes
- Add optional `seed` parameter to `run_backtest()` and relevant pipeline entrypoints.
- Document `renv::restore()` usage in a DEV README and in `openspec/project.md`.
- Thread the seed through `run_pipeline()`/graph learners so resampling and optimizers produce deterministic folds/weights.
- Add CI step to restore `renv` (already added) and document it.

## Acceptance Criteria
- `run_backtest(seed = <int>)` MUST set the global RNG state (via `set.seed(seed)`) and ensure resampling instantiation and optimizer runs produce deterministic outputs when seed is provided.
- All pipeline entrypoints (`run_pipeline`, training wrappers) MUST accept an optional `seed` and propagate it to mlr3 resampling and any optimizer RNG-sensitive calls.
- CI docs and `openspec/project.md` MUST include `renv::restore()` instructions and a short reproducibility checklist.

## Impact
- Files: `R/backtest_runner.R`, `README.adoc` or `docs/DEV.md`, `openspec/project.md`.
