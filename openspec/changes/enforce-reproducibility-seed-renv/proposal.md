# Change: Enforce reproducibility (seed control) and `renv` guidance

## Why
Reproducible backtests and experiments require explicit seed management and a documented environment restore process. While `renv` exists, CI and developer docs need explicit steps and optional seed parameterization.

## What Changes
- Add optional `seed` parameter to `run_backtest()` and relevant pipeline entrypoints.
- Document `renv::restore()` usage in a DEV README and in `openspec/project.md`.
- Add CI step to restore `renv` (already added) and document it.

## Impact
- Files: `R/backtest_runner.R`, `README.adoc` or `docs/DEV.md`, `openspec/project.md`.
