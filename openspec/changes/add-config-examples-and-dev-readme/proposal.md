# Change: Add config examples and developer README

## Why
Onboarding and correct config usage require clear examples for `data/optimizer_config.yaml` and developer setup steps (`renv::restore`, running tests, formatting).

## What Changes
- Add annotated example `data/optimizer_config.example.yaml` documenting `bounds`, `order`, `target_column`, `init_w`.
- Add `docs/DEV.md` or update `README.adoc` with restore and test instructions.

## Impact
- Files: new example YAML, updated README or new `docs/DEV.md`.
