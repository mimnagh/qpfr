## 1. Implementation
- [ ] Change `.train()` to set `self$model` to a named numeric vector `c(w1=..., w2=...)`.
- [ ] Update `.predict()` to use numeric vector and validate length/order against `task$feature_names`.
- [ ] Update pipeline/backtest/evaluator artifact writing and reading to serialize/deserialize the vector shape consistently (Parquet or RDS).
- [ ] Add unit tests covering weight shapes, prediction lengths, and serialization/deserialization (including evaluator consuming saved weights).

## 1. Implementation
- [ ] Change `.train()` to set `self$model` to a named numeric vector and add a small `assert_named_numeric_vector()` helper.
- [ ] Update `.predict()` to:
	- accept named numeric vector weights (convert if older data.frame shape detected),
	- map weights to `task$feature_names` by name, and
	- error with a helpful message if names mismatch or length differs.
- [ ] Replace any Parquet-based: `data.frame(t(res$par))` write/read with an explicit vector serialization (use `saveRDS()` for internal artifacts; provide a JSON example for cross-language interoperability in `data/optimizer_config.example.yaml`).
- [ ] Add unit tests:
	- training produces named numeric vector with correct names and sum-to-1 property (when required),
	- `predict()` returns vector of correct length and numeric type,
	- round-trip save/load (RDS and JSON) preserves names and numeric values,
	- evaluator consumes saved weight artifacts and produces identical predictions as freshly trained model.

## 2. Migration
- [ ] Add a small migration helper `migrate_model_shape(model)` to coerce older data.frame shapes to the new named numeric vector and log a deprecation warning.

## 3. Review
- [ ] PR review; run `devtools::test()` and ensure backward compatibility via migration helper.

## 2. Review
- [ ] PR review and run unit tests.
