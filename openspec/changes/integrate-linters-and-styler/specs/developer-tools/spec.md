## ADDED Requirements

### Requirement: Project has lintr and styler guidance
The project SHALL include `.lintr` and `styler` configuration and SHALL provide a `make style` or script to run `styler::style_dir('R')`. CI SHALL run `lintr` as part of PR checks.

#### Scenario: CI rejects unstyled code (optional)
- **WHEN** a PR introduces code not conforming to the project's style rules and CI is configured to check style
- **THEN** CI SHALL fail the style check and provide actionable messages indicating how to run `make style` locally
