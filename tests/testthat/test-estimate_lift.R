context("Estimated Lift Distribution")

test_that("estimate_lift returns double vector the same length as the rows in posterior_samples input", {
  distribution_type <- "conversion_rate"
  input_df <- tibble::tibble(
    option_name = c("A", "B", "C"),
    sum_clicks = c(1000, 1000, 1000),
    sum_conversions = c(100, 120, 110)
  )
  posterior_samples <- sample_from_posterior(input_df, distribution_type, priors = list())
  count_unique_options <- length(unique(posterior_samples$option_name))
  posterior_samples_rows <- nrow(posterior_samples)/count_unique_options

  output <- estimate_lift(posterior_samples = posterior_samples,
                          distribution = distribution_type,
                          wrt_option = "A",
                          metric = "lift")
  expect_length(output, posterior_samples_rows)
  expect_true(is.double(output))
})


test_that("estimate_lift returns double vector the same length
          as the rows in posterior_samples input when lower is better", {
  distribution_type <- "cpa"
  input_df <- tibble::tibble(
    option_name = c("A", "B", "C"),
    sum_clicks = c(1000, 1000, 1000),
    sum_conversions = c(100, 120, 110),
    sum_cost = c(50, 100, 150),
  )
  posterior_samples <- sample_from_posterior(input_df, distribution_type, priors = list())
  count_unique_options <- length(unique(posterior_samples$option_name))
  posterior_samples_rows <- nrow(posterior_samples)/count_unique_options

  output <- estimate_lift(posterior_samples = posterior_samples,
                          distribution = distribution_type,
                          wrt_option = "A",
                          metric = "lift")
  expect_length(output, posterior_samples_rows)
  expect_true(is.double(output))
})


test_that("estimate_lift errors when invalid metric is passed", {
            distribution_type <- "cpa"
            input_df <- tibble::tibble(
              option_name = c("A", "B", "C"),
              sum_clicks = c(1000, 1000, 1000),
              sum_conversions = c(100, 120, 110),
              sum_cost = c(50, 100, 150),
            )
            posterior_samples <- sample_from_posterior(input_df, distribution_type, priors = list())
            count_unique_options <- length(unique(posterior_samples$option_name))
            posterior_samples_rows <- nrow(posterior_samples)/count_unique_options

            testthat::expect_error({
              estimate_lift(posterior_samples = posterior_samples,
                            distribution = distribution_type,
                            wrt_option = "A",
                            metric = "invalid")
            })
          })
