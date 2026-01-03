## 1. Test Implementation
- [ ] **Data Provider Tests:** In a new `test_dataprovider_validation.R`, add unit tests that:
    - Verify the `na_mode` behaviors (`drop`, `error`, `report`, `impute`).
    - Assert that `validate_optimizer_config()` (or its equivalent) raises the correct errors for malformed configs.
- [ ] **Optimizer Edge Cases:** In a new `test_optimizer_edge_cases.R`, add unit tests that:
    - Check the behavior of numerical guards (e.g., epsilon values for zero variance).
    - Verify that the optimizer's convergence status is correctly reported, especially on failure.
- [ ] **Model Storage:** In a new `test_model_storage.R`, add tests for:
    - The save/load round-trip of model weights (named numeric vectors).
    - The prediction equivalence of a loaded model.
- [ ] **Integration Test:** In a new `test_backtest_integration.R`, add a test that:
    - Runs `run_backtest()` with a fixed seed (`seed = 42`).
    - Uses a small, deterministic dataset (e.g., `two_asset_small.csv`).
    - Asserts that the outputs (alpha, IR, predictions) are deterministic and match expected values.

## 2. Test Fixtures
- [ ] Add the following fixtures under `tests/testthat/fixtures/`:
    - `optimizer_config_malformed.yaml`
    - `na_rows.csv` (a dataset with NA values)
    - `two_asset_small.csv` (a small, deterministic dataset for the integration test)

## 3. CI and Review
- [ ] Ensure the CI pipeline is configured to run all the new tests.
- [ ] Verify that `renv::restore()` is called in the CI script before the tests are executed.
- [ ] Run `devtools::test()` locally to confirm all tests pass and are not flaky.
