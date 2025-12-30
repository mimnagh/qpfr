## ADDED Requirements

### Requirement: Provide example optimizer config and dev README
The repository SHALL include an example `optimizer_config.example.yaml` demonstrating `bounds`, `order`, `target_column`, and `init_w` shapes, and SHALL include developer instructions (`renv::restore()`, running tests, style commands) in `docs/DEV.md` or `README`.

#### Scenario: Developer restores environment
- **WHEN** a new developer follows `docs/DEV.md` and runs `renv::restore()`
- **THEN** the developer SHALL be able to run `devtools::test()` successfully (modulo system dependencies)
