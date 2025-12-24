# Project Context

## Purpose
qpfr is an R-first quantitative portfolio research and optimization toolkit. It provides reproducible data ingestion, factor/alpha scoring, optimizer orchestration, backtesting, and evaluation pipelines to support research and production workflows for portfolio construction and evaluation.

Primary goals:
- Enable repeatable experiments and backtests across different optimization objectives and constraints.
- Provide modular components for scoring, optimization, and evaluation that can be recomposed in pipelines.
- Integrate ML workflows and experiment tracking for model-driven alpha and risk models.

## Tech Stack
- Language: R (tested against R 4.3 in renv). The repository is organized around R scripts in `R/` and Quarto notebooks in `notebooks/`.
- Dependency management: `renv` (project-local library + lockfile under `renv/`).
- Core libraries: `mlr3`, `mlr3pipelines`, `mlr3filters`, `mlr3measures`, `data.table`, `arrow`, `nloptr`, `testthat`, `mlflow`, `ggplot2`, `dplyr`, `tidyr`, `covr`.
- Dev tooling: `devtools`, `lintr`, `styler`, `languageserver` (editor integration), Quarto (`.qmd`) for notebooks.
- Notebooks & docs: Quarto/`.qmd` in `notebooks/` for examples and experiments.

## Project Conventions

### Code Style
- Prefer tidyverse-style semantics: `snake_case` for functions and variables, clear descriptive names for files and exported functions.
- Use `styler` and `lintr` locally (or via CI) to enforce formatting and basic lint rules.
- Keep single-file modules small and focused; one top-level responsibility per file in `R/` (e.g., `DataProvider.R`, `PortfolioOptimizer.R`). See `R/` for existing organization.
- Use `renv` to pin package versions; commit the lockfile and `renv/settings` as the canonical environment.

### Architecture Patterns
- Pipeline stages: data ingestion -> feature/factor engineering -> alpha scoring -> optimizer -> evaluator/backtest -> reporting. The repository follows this decomposition in `R/`:
	- Data providers and IO: [R/DataProvider.R](R/DataProvider.R#L1)
	- Scoring: [R/AlphaScorer.R](R/AlphaScorer.R#L1), [R/IRScorer.R](R/IRScorer.R#L1)
	- Optimization: [R/PortfolioOptimizer.R](R/PortfolioOptimizer.R#L1), [R/OptimizerGraphLearner.R](R/OptimizerGraphLearner.R#L1)
	- Backtesting and orchestration: [R/backtest_runner.R](R/backtest_runner.R#L1), [R/pipeline_runner.R](R/pipeline_runner.R#L1)
	- ML/experiment integration: [R/MLFlowProxy.R](R/MLFlowProxy.R#L1)

### Testing Strategy
- Unit tests with `testthat` live under `tests/testthat/`. Keep unit tests fast and focused (small fixtures in `data/` or generated in tests).
- Integration tests exercise the end-to-end pipeline on small sample datasets (use files in `data/` such as `two_asset.csv` and `sector_factor_timeseries.csv`).
- Run tests with `devtools::test()` or `R CMD check` for package-like checks. Use `covr` to measure coverage where useful.

### Git Workflow
- Branching: `main` (protected) is the canonical branch. Use feature branches prefixed with `feature/` and hotfix branches with `hotfix/`.
- Pull requests: open PRs for reviews, link issues, and include a short description of changes and tests added.
- Commits: adopt a lightweight conventional style (e.g., `feat:`, `fix:`, `docs:`) to make changelogs easier to generate.
- Releases: tag with semantic versioning when producing a release artifact or stable snapshot.

## Domain Context
- Domain: quantitative portfolio construction and evaluation — factors, alpha signals, information ratio (IR), factor exposures, risk and return trade-offs.
- Typical inputs: time-series of factor exposures and returns (see `data/sector_factor_timeseries.csv`), small example datasets in `data/` (e.g., `two_asset.csv`).
- Key terms: alpha scoring, backtest, optimizer constraints, information ratio (IR), factor neutralization.

## Important Constraints
- Reproducibility: fixes to random seeds and deterministic optimizer settings are required for experiment reproducibility.
- Environment: code expects a consistent R environment (use `renv` lockfile). Test and CI runners should restore the `renv` environment before running.
- Performance: some optimizers and backtests can be memory and CPU intensive for long histories; prefer sampled/incremental runs for CI.

## External Dependencies
- MLflow tracking server (integration helpers in `R/MLFlowProxy.R`) — optional but recommended for experiments.
- Data sources: CSV fixtures in `data/` and potential external storage (S3, object stores) when scaling.
- Optional services: a lightweight Postgres or object store for storing long-lived artifacts (models, datasets) in production workflows.

---

Next steps:
- Review and adjust any wording or conventions (naming, style) to match team preferences.
- If you'd like, I can update CI configuration to restore `renv` and run `devtools::test()` on PRs.
