## ADDED Requirements

### Requirement: CI caches renv and runs on multiple OSes
The CI pipeline SHALL cache the `renv` package library keyed by lockfile hash and SHALL run checks on at least Ubuntu and macOS runners to validate cross-platform compatibility.

#### Scenario: Cache hit speeds up CI
- **WHEN** the `renv.lock` has not changed between runs
- **THEN** CI SHALL restore packages from cache and complete faster than a full restore
