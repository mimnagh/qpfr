## ADDED Requirements

### Requirement: Backtest supports streaming/aggregation modes
`run_backtest()` SHALL support a `mode` option with values `memory`, `stream`, or `disk`. In `stream` mode the runner SHALL compute running aggregates (mean, variance) without storing per-fold vectors in memory.

#### Scenario: Stream mode reduces peak memory
- **WHEN** `run_backtest(mode = 'stream')` is executed on a dataset larger than memory threshold
- **THEN** the runner SHALL not store per-fold predictions in-memory and SHALL complete using bounded memory (within documented limits)
