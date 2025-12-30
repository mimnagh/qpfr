## 1. Implementation
- [ ] Add `mode` parameter to `run_backtest()` with `memory|stream|disk` options.
- [ ] Implement incremental aggregation for alpha and IR (running mean, running variance) to avoid storing all vectors.
- [ ] Optionally write per-fold predictions to parquet when `mode=disk`.
- [ ] Add tests and update docs.
