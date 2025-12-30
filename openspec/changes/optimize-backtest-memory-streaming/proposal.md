# Change: Improve backtest memory usage by streaming/aggregating

## Why
Current backtests accumulate predictions and truths in lists and unlist at the end; for larger datasets this can be memory-intensive. Streaming aggregates or writing interim results reduces peak memory.

## What Changes
- Modify `run_backtest()` to aggregate metrics incrementally (sum, sumsq) and optionally write per-fold results to disk (parquet) instead of holding all in memory.
- Provide a `mode` option (`memory|stream|disk`) and document trade-offs.

## Impact
- Files: `R/backtest_runner.R` and docs.
- Tests: add small integration test for streaming mode.
