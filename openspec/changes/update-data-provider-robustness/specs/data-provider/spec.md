## ADDED Requirements

### Requirement: DataProvider validates inputs and reports NA handling
The `DataProvider` SHALL validate input CSVs and `optimizer` config fields (`bounds`, `order`, `target_column`) on load. The `DataProvider` SHALL provide configurable NA-handling modes: `error`, `report`, `impute`, or `drop`.

#### Scenario: Missing target column
- **WHEN** `DataProvider::load()` is called with a config whose `target_column` is not present in the CSV
- **THEN** `DataProvider` SHALL raise a clear, actionable error describing the missing column and the path to the CSV
