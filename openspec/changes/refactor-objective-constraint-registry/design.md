## Context
Refactor the inline registry into a testable, pluggable component.

## Goals
- Make objective/constraint functions discoverable and injectable.
- Support adding new objectives without changing optimizer internals.

## Decisions
- Use an R6 class `ObjectiveRegistry` exposing `register_objective(name, fn)` and `get_objective(name)`.

## Migration
- Replace inlined registry initialization in `PortfolioOptimizer` with `ObjectiveRegistry$new()`.
