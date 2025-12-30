## ADDED Requirements

### Requirement: Reproducible runs via seed and environment restore
Pipeline entrypoints (including `run_backtest`) SHALL accept an optional `seed` parameter that, when provided, sets the RNG for deterministic execution. Developer docs SHALL contain `renv::restore()` instructions to recreate environments.

#### Scenario: Deterministic backtest with seed
- **WHEN** `run_backtest(seed = 42)` is run twice with identical inputs
- **THEN** the outputs SHALL be identical across runs
