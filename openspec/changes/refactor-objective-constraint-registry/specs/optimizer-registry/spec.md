## ADDED Requirements

### Requirement: Objective/Constraint registry as injectable component
The system SHALL provide an `ObjectiveRegistry` capability that can register and return objective and constraint functions by name, and SHALL allow the optimizer to accept a registry instance rather than owning inline registries.

#### Scenario: Register and retrieve objective
- **WHEN** a new objective function is registered under a name
- **THEN** `get_objective(name)` SHALL return the registered callable and other modules SHALL be able to use it via the registry API
