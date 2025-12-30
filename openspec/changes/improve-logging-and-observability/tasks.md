## 1. Implementation
- [ ] Define a logger interface and update `MLFlowProxy` implementations to conform.
- [ ] Add logging hooks in `DataProvider::load()`, `.train()` and `run_backtest()` for counts, objective values, and convergence status.
- [ ] Add tests using a test logger to assert expected calls.
