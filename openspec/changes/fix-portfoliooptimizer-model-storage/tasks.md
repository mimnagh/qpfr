## 1. Implementation
- [ ] Change `.train()` to set `self$model` to a named numeric vector `c(w1=..., w2=...)`.
- [ ] Update `.predict()` to use numeric vector and validate length/order against `task$feature_names`.
- [ ] Update any code that writes model artifacts (parquet) to serialize a simple numeric vector or named list.
- [ ] Add unit tests covering weight shapes, prediction lengths, and serialization/deserialization.

## 2. Review
- [ ] PR review and run unit tests.
