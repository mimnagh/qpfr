## 1. Implementation
- [ ] Add unit tests for `DataProvider` invalid configs and NA handling modes.
- [ ] Add unit tests for optimizer edge cases (bounds missing, zero variance, non-convergence handling).
- [ ] Add an integration test for `run_backtest()` using `two_asset.csv` with deterministic seeds.
- [ ] Add fixtures under `tests/fixtures/` (malformed config, small datasets).

## 2. Review
- [ ] Run `devtools::test()` and ensure CI picks up new tests.
