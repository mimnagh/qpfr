## ADDED Requirements

### Requirement: Standardized logger interface and instrumentation
The system SHALL expose a logger interface with methods `start()`, `log_param(name, value)`, `log_metric(name, value)`, and `end()`. Optimizer and backtest components SHALL use this interface to emit convergence status, objective values, data-loading counts, and key metrics.

#### Scenario: Logger records optimizer convergence
- **WHEN** an optimizer run completes (successfully or not)
- **THEN** the logger SHALL receive a `log_metric('optimizer_converged', 1|0)` and a `log_metric('final_objective', value)` call
