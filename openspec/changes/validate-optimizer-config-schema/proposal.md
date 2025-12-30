# Change: Add schema validation for optimizer config

## Why
The code assumes `config$optimizer` contains `bounds`, `order`, and `target_column` with specific shapes. Missing or malformed values cause runtime errors.

## What Changes
- Implement schema validation (simple R checks or use `validate`/`jsonlite` schema) for the optimizer config at load time.
- Provide clear error messages and suggested fixes.
- Add unit tests for invalid/malformed config files.

## Impact
- Files: `R/DataProvider.R`, `data/optimizer_config.yaml` (example), tests.
