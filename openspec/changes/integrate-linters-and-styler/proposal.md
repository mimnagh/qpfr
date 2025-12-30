# Change: Integrate `lintr` and `styler` into developer workflow

## Why
Consistent style and linting improves readability and reduces churn. CI runs `lintr` but local dev guidance and optional auto-formatting would help contributors.

## What Changes
- Add `lintr` and `styler` config files (`.lintr`, `style.R` or settings in README).
- Add a `make style` or R script to run `styler::style_dir('R')` optionally producing a patch.
- Add CI check to run `styler` in check-only mode (or fail if unstyled).

## Impact
- Files: new config files and updates to CI and README.
