## 1. Implementation
- [ ] Research and select a suitable schema validation library (e.g., `jsonvalidate`, `checkmate`) or decide on a custom R6-based implementation for a generic `ConfigValidator`.
- [ ] Implement the generic validation utility (e.g., `R/ConfigValidator.R`) with a method like `validate(config, schema)`.
- [ ] Define the JSON schema for the optimizer configuration (`optimizer_config.yaml`).
- [ ] Integrate the validator into `DataProvider::load()`, calling it with the optimizer config and schema. Ensure it throws clear, actionable error messages on failure.
- [ ] Create a malformed config fixture at `tests/testthat/fixtures/optimizer_config_malformed.yaml`.
- [ ] Add unit tests for the validator that cover each type of error (e.g., missing fields, incorrect types, mismatched column names).

## 2. Documentation and Review
- [ ] Document the schema for `optimizer_config.yaml` and the process for adding new schemas.
- [ ] Conduct a PR review to ensure the validator is generic and the error messages are user-friendly.
