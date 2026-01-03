# Change: Implement Schema Validation for All YAML Configurations

## Why
The application loads multiple YAML configuration files (e.g., for the optimizer, data sources, custom objectives), but currently performs little to no validation. Malformed or missing values in any of these files can cause cryptic runtime errors downstream.

Implementing a robust, schema-based validation mechanism at load time is critical for ensuring system stability, providing clear error messages to users, and improving debuggability.

## What Changes
- Create a generic, reusable schema validation utility for YAML files (e.g., using a library like `jsonvalidate` or a custom R6 class).
- Define a clear schema for `optimizer_config.yaml` as the first use case.
- Integrate the validator into `DataProvider.R` to validate the optimizer config upon loading, providing clear, actionable error messages.
- The utility should be designed for extension, allowing new schemas for other config files (e.g., `custom_config.yaml`, `ta.yaml`) to be easily added in the future.

## Acceptance Criteria
- A generic `validate_config(config, schema)` function/method MUST be implemented.
- A schema for the optimizer config MUST be defined and used.
- `DataProvider::load()` MUST call the validator for the optimizer config and stop with an informative message if validation fails.
- The validator MUST check that `bounds` is a named list whose names match feature column names, that `order` is an array of column names present in the data, and that `target_column` exists in the dataset.
- Tests MUST include at least one malformed YAML fixture and assert the validator raises the expected messages.

## Impact
- Files: `R/DataProvider.R`, potentially a new `R/ConfigValidator.R`.
- Configs: `data/optimizer_config.yaml` (and its schema), with a clear path to validate `data/custom_config.yaml`, `data/custom_obj_config.yaml`, etc.
- Tests: New unit tests for the validation utility.
