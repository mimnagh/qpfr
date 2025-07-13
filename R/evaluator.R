# R/evaluator.R

# Evaluate a saved portfolio optimizer model
# Computes predicted returns, alpha, and information ratio

evaluate_saved_model <- function(
  input_csv = here::here("data/sector_factor_timeseries.csv"),
  weights_path = here::here("output/weights.parquet")
) {
  # Load input feature data and true returns
  Xy <- data.table::fread(input_csv)
  X <- Xy[, !"target_column", with = FALSE] # Features only
  y <- Xy[["target_column"]] # Target values (returns)

  # Load optimized weights from a saved Parquet file
  weights <- arrow::read_parquet(weights_path)
  w_vec <- as.vector(as.matrix(weights)) # Convert to numeric vector

  # Generate predicted returns via matrix multiplication
  predicted <- as.vector(as.matrix(X) %*% w_vec)

  # Package results into a data.table for inspection
  result_dt <- data.table::data.table(
    predicted_return = predicted,
    actual_return = y
  )

  # Compute Alpha (mean prediction error)
  alpha <- mean(predicted - y)

  # Compute Information Ratio (alpha divided by std deviation of prediction error)
  ir <- alpha / sd(predicted - y)

  # Return result object with metrics
  list(
    result = result_dt,
    alpha = alpha,
    ir = ir
  )
}
