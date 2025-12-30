## ADDED Requirements

### Requirement: Optimizer config schema validation
The system SHALL validate the `optimizer` configuration on load and SHALL provide clear, actionable errors for malformed or missing fields (`bounds`, `order`, `target_column`, `init_w`).

#### Scenario: Malformed bounds entry
- **WHEN** `config$optimizer$bounds` is not a map of feature -> [lower, upper]
- **THEN** the loader SHALL raise a validation error describing the expected structure and point to an example config
