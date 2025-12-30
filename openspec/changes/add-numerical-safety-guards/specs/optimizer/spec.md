## ADDED Requirements

### Requirement: Numerical guards for objectives and metrics
Objective functions and evaluation metrics SHALL guard against division by zero or near-zero variance by using a configurable epsilon and defined fallback behavior (e.g., return 0 or large penalty) when variance is below epsilon.

#### Scenario: Zero variance target
- **WHEN** the target series has zero variance
- **THEN** objective and IR computations SHALL not produce Inf/NaN and SHALL follow configured fallback behavior documented in config
