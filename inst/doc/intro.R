## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, warning=FALSE, message=FALSE---------------------------------
library(grizbayr)
library(dplyr)

## ------------------------------------------------------------------------
raw_data_long_format <- tibble::tribble(
   ~option_name, ~clicks, ~conversions,
            "A",       6,           3,
            "A",       1,           0,
            "B",       2,           1,
            "A",       2,           0,
            "A",       1,           0,
            "B",       5,           2,
            "A",       1,           0,
            "B",       1,           1,
            "B",       1,           0,
            "A",       3,           1,
            "B",       1,           0,
            "A",       1,           1
)

raw_data_long_format %>% 
  dplyr::group_by(option_name) %>% 
  dplyr::summarise(sum_clicks = sum(clicks), 
                   sum_conversions = sum(conversions))

## ------------------------------------------------------------------------
# Since this is a stochastic process with a random number generator,
# it is worth setting the seed to get consistent results.
set.seed(1776)

input_df <- tibble::tibble(
  option_name = c("A", "B", "C"),
  sum_clicks = c(1000, 1000, 1000),
  sum_conversions = c(100, 120, 110)
)
input_df

## ------------------------------------------------------------------------
estimate_all_values(input_df, distribution = "conversion_rate", wrt_option_lift = "A")

## ------------------------------------------------------------------------
estimate_win_prob(input_df, distribution = "conversion_rate")

## ------------------------------------------------------------------------
estimate_value_remaining(input_df, distribution = "conversion_rate")

## ------------------------------------------------------------------------
estimate_value_remaining(input_df, distribution = "conversion_rate", metric = "absolute")

## ------------------------------------------------------------------------
estimate_lift_vs_baseline(input_df, distribution = "conversion_rate", wrt_option = "A")

## ------------------------------------------------------------------------
estimate_lift_vs_baseline(input_df, distribution = "conversion_rate", wrt_option = "A", metric = "absolute")

## ------------------------------------------------------------------------
estimate_win_prob_vs_baseline(input_df, distribution = "conversion_rate", wrt_option = "A")

## ------------------------------------------------------------------------
sample_from_posterior(input_df, distribution = "conversion_rate")

## ------------------------------------------------------------------------
(input_df_rps <- tibble::tibble(
   option_name = c("A", "B", "C"),
   sum_sessions = c(1000, 1000, 1000),
   sum_conversions = c(100, 120, 110),
   sum_revenue = c(900, 1200, 1150)
))

estimate_all_values(input_df_rps, distribution = "rev_per_session", wrt_option_lift = "A")

## ------------------------------------------------------------------------
# You can also pass priors for just the Beta distribution and not the Gamma distribution.
new_priors <- list(alpha0 = 2, beta0 = 10, k0 = 3, theta0 = 10000)
estimate_all_values(input_df_rps, distribution = "rev_per_session", wrt_option_lift = "A", priors = new_priors)

## ------------------------------------------------------------------------
(input_df_all <- tibble::tibble(
   option_name = c("A", "B", "C"),
   sum_impressions = c(10000, 9000, 11000),
   sum_sessions = c(1000, 1000, 1000),
   sum_conversions = c(100, 120, 110),
   sum_revenue = c(900, 1200, 1150),
   sum_cost = c(10, 50, 30),
   sum_conversions_2 = c(10, 8, 20),
   sum_revenue_2 = c(10, 16, 15)
) %>% 
  dplyr::mutate(sum_clicks = sum_sessions)) # Clicks are the same as Sessions

distributions <- c("conversion_rate", "response_rate", "ctr", "rev_per_session", "multi_rev_per_session", "cpa", "total_cm", "cm_per_click", "cpc")

# Purrr map allows us to apply a function to each element of a list. (Similar to a for loop)
purrr::map(distributions,
           ~ estimate_all_values(input_df_all,
                                 distribution = .x,
                                 wrt_option_lift = "A",
                                 metric = "absolute")
)

