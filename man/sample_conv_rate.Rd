% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample_conv_rate.R
\name{sample_conv_rate}
\alias{sample_conv_rate}
\title{Sample Conversion Rate}
\usage{
sample_conv_rate(input_df, priors, n_samples = 50000)
}
\arguments{
\item{input_df}{Dataframe containing option_name (str),
sum_conversions (dbl), and sum_clicks (dbl).}

\item{priors}{Optional list of priors alpha0 and beta0.
Default \eqn{Beta(1,1)} will be use otherwise.}

\item{n_samples}{Optional integer value. Defaults to 50,000 samples.}
}
\value{
input_df with 2 new nested columns `beta_params` and `samples`
}
\description{
Adds 2 new nested columns to the input_df: `beta_params` and `samples`
    `beta_params` in each row should be a tibble of length 2 (\eqn{\alpha}
        and \eqn{\beta} parameters)
    `samples` in each row should be a tibble of length `n_samples`
}
\details{
See update_rules vignette for a mathematical representation.
\deqn{conversion_i ~ Bernoulli(\phi)}
\deqn{\phi ~ Beta(\alpha, \beta)}
Conversion Rate is sampled from a Beta distribution with a Binomial likelihood
of an individual converting.
}
