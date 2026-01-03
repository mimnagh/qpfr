# Change: Add config examples and developer README

## Why
Onboarding and correct config usage require clear examples for `data/optimizer_config.yaml` and developer setup steps (`renv::restore`, running tests, formatting).

## What Changes
- Add annotated example `data/optimizer_config.example.yaml` documenting `bounds`, `order`, `target_column`, `init_w`.
- Include new config fields used elsewhere (e.g., NA handling mode, epsilon/penalty for numerical guards) with descriptions and defaults.
- Add `docs/DEV.md` or update `README.adoc` with restore and test instructions.

## Acceptance Criteria
- `data/optimizer_config.example.yaml` MUST exist and include annotated examples for `bounds`, `order`, `target_column`, `init_w`, `na_mode`, `eps`, and `seed` with sensible defaults.
- `docs/DEV.md` MUST document `renv::restore()`, running tests (`devtools::test()`), formatting (`styler::style_pkg()`), lintr usage, and CI quickstart (how CI restores `renv`).
- `README.adoc` or `openspec/project.md` MUST contain links to `docs/DEV.md` and the example config.

## Notes
- Add examples for artifact serialization (RDS/JSON) for model weights to support `fix-portfoliooptimizer-model-storage`.

## Impact
- Files: new example YAML, updated README or new `docs/DEV.md`.
