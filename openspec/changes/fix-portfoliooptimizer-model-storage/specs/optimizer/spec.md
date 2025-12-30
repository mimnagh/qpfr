## ADDED Requirements

### Requirement: Optimizer stores model weights as named numeric vector
The optimizer SHALL store its learned weights as a named numeric vector (length = number of features) and SHALL expose a stable serialization format for persistence and restored evaluation.

#### Scenario: Train and predict contract
- **WHEN** the optimizer is trained on a task and then used to predict on a task with the same feature ordering
- **THEN** the `model` SHALL be a named numeric vector and predictions SHALL be produced without type/conversion errors
