# Estimate Zero Truncated Poisson Parameters

This function will attempt to estimate the Zero Truncated Poisson lambda
parameter given some vector of values `.x`. The function will return a
tibble output, and if the parameter `.auto_gen_empirical` is set to
`TRUE` then the empirical data given to the parameter `.x` will be run
through the
[`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
function and combined with the estimated Zero Truncated Poisson data.

## Usage

``` r
util_zero_truncated_poisson_param_estimate(.x, .auto_gen_empirical = TRUE)
```

## Arguments

- .x:

  The vector of data to be passed to the function. Must be non-negative
  integers.

- .auto_gen_empirical:

  This is a boolean value of TRUE/FALSE with default set to TRUE. This
  will automatically create the
  [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
  output for the `.x` parameter and use the
  [`tidy_combine_distributions()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combine_distributions.md).
  The user can then plot out the data using `$combined_data_tbl` from
  the function output.

## Value

A tibble/list

## Details

This function estimates the parameter lambda of a Zero-Truncated Poisson
distribution based on a vector of non-negative integer values `.x`. The
Zero-Truncated Poisson distribution is a discrete probability
distribution that models the number of events occurring in a fixed
interval of time, given that at least one event has occurred.

The estimation is performed by minimizing the negative log-likelihood of
the observed data `.x` under the Zero-Truncated Poisson model. The
negative log-likelihood function used for optimization is defined as:

\$\$-\sum\_{i=1}^{n} \log(P(X_i = x_i \mid X_i \> 0, \lambda))\$\$

where \\ X_i \\ are the observed values in `.x` and `lambda` is the
parameter of the Zero-Truncated Poisson distribution.

The optimization process uses the `optim` function to find the value of
`lambda` that minimizes this negative log-likelihood. The chosen
optimization method is Brent's method (`method = "Brent"`) within a
specified interval `[0, max(.x)]`.

If `.auto_gen_empirical` is set to `TRUE`, the function will generate
empirical data statistics using
[`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
for the input data `.x` and then combine this empirical data with the
estimated Zero-Truncated Poisson distribution using
[`tidy_combine_distributions()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combine_distributions.md).
This combined data can be accessed via the `$combined_data_tbl` element
of the function output.

The function returns a tibble containing the estimated parameter
`lambda` along with other summary statistics of the input data (sample
size, minimum, maximum).

## See also

Other Parameter Estimation:
[`util_bernoulli_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_param_estimate.md),
[`util_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_param_estimate.md),
[`util_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md),
[`util_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_param_estimate.md),
[`util_cauchy_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_param_estimate.md),
[`util_chisquare_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_param_estimate.md),
[`util_exponential_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_param_estimate.md),
[`util_f_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_f_param_estimate.md),
[`util_gamma_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_param_estimate.md),
[`util_generalized_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_beta_param_estimate.md),
[`util_generalized_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_pareto_param_estimate.md),
[`util_geometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_param_estimate.md),
[`util_hypergeometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_param_estimate.md),
[`util_inverse_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_burr_param_estimate.md),
[`util_inverse_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_pareto_param_estimate.md),
[`util_inverse_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_param_estimate.md),
[`util_logistic_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_param_estimate.md),
[`util_lognormal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_param_estimate.md),
[`util_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md),
[`util_normal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_param_estimate.md),
[`util_paralogistic_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_param_estimate.md),
[`util_pareto1_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_param_estimate.md),
[`util_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_param_estimate.md),
[`util_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md),
[`util_t_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_t_param_estimate.md),
[`util_triangular_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_param_estimate.md),
[`util_uniform_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_param_estimate.md),
[`util_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_param_estimate.md),
[`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md),
[`util_zero_truncated_geometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_param_estimate.md),
[`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md)

Other Poisson:
[`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md),
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md),
[`util_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md),
[`util_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_stats_tbl.md),
[`util_zero_truncated_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
library(ggplot2)

tc <- tidy_zero_truncated_poisson() |> pull(y)
output <- util_zero_truncated_poisson_param_estimate(tc)

output$parameter_tbl
#> # A tibble: 1 × 5
#>   dist_type              samp_size   min   max lambda
#>   <chr>                      <int> <dbl> <dbl>  <dbl>
#> 1 Zero Truncated Poisson        50     1     4   1.03

output$combined_data_tbl |>
  tidy_combined_autoplot()

```
