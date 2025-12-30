## ADDED Requirements

### Requirement: Test coverage for edge cases
The project SHALL include unit and integration tests that cover invalid configs, NA-handling modes, zero-variance targets, optimizer non-convergence, and a small end-to-end backtest on a fixture dataset.

#### Scenario: Integration backtest fixture
- **WHEN** `run_backtest()` is executed on the small fixture dataset with a fixed seed
- **THEN** the test SHALL complete deterministically and assert expected summary metrics (alpha/IR) within tolerances
