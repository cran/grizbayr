context("Sample CPA")

test_that("sample_cpa returns correct shape", {
  input_df <- tibble::tibble(
    option_name = c("A", "B", "C"),
    sum_clicks = c(1000, 1000, 1000),
    sum_conversions = c(100, 120, 110),
    sum_cost = c(10, 50, 30),
  )
  n_options <- length(unique(input_df$option_name))
  n_samples <- 150
  expected_col_names <- c(colnames(input_df),
                          "beta_params", "gamma_params", "samples")
  output <- sample_cpa(input_df, priors = list(), n_samples = n_samples)
  expect_true(is.data.frame(output))
  expect_true(all(c("option_name", "samples") %in% colnames(output)))
  expect_length(output$samples, n_options)
  purrr::walk(output$samples, ~ expect_length(.x, n_samples))
  expect_equal(colnames(output), expected_col_names)
})
