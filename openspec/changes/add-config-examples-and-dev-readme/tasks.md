## 1. Implementation
- [ ] Add `data/optimizer_config.example.yaml` with annotated fields (bounds, order, target_column, init_w, NA handling mode, epsilon/penalty defaults).
- [ ] Add `docs/DEV.md` with `renv::restore()`, running tests, style rules, and how to switch on MLflow logging.
- [ ] Reference `docs/DEV.md` from `README.adoc` and `openspec/project.md`.

## 1. Implementation
- [ ] Create `data/optimizer_config.example.yaml` containing full annotated example including `na_mode`, `eps`, `seed`, and serialization examples for weights (RDS/JSON snippet).
- [ ] Add `docs/DEV.md` covering:
	- `renv::restore()` and troubleshooting renv locks,
	- running tests (`devtools::test()`),
	- formatting (`styler::style_pkg()`), linting (`lintr::lint_package()`), and language server usage,
	- enabling MLflow locally and CI notes for restoring environment,
	- how to run deterministic backtest with `seed` and where to find fixtures.
- [ ] Link `docs/DEV.md` from `README.adoc` and `openspec/project.md` and add CI step examples for `renv::restore()` in `.github/workflows/ci.yml` comments.

## 2. Review
- [ ] Validate example YAML loads with `yaml::read_yaml()` and passes `validate_optimizer_config()` from `validate-optimizer-config-schema` change.
