# Estimate Zero Truncated Negative Binomial Parameters

The function will return a list output by default, and if the parameter
`.auto_gen_empirical` is set to `TRUE` then the empirical data given to
the parameter `.x` will be run through the
[`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
function and combined with the estimated negative binomial data.

One method of estimating the parameters is done via:

- MLE via [`optim`](https://rdrr.io/r/stats/optim.html) function.

## Usage

``` r
util_ztn_binomial_param_estimate(.x, .auto_gen_empirical = TRUE)
```

## Arguments

- .x:

  The vector of data to be passed to the function.

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

This function will attempt to estimate the zero truncated negative
binomial size and prob parameters given some vector of values.

## See also

Other Parameter Estimation:
[`util_bernoulli_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_param_estimate.md)`()`,
[`util_beta_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_beta_param_estimate.md)`()`,
[`util_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md)`()`,
[`util_burr_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_burr_param_estimate.md)`()`,
[`util_cauchy_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_param_estimate.md)`()`,
[`util_chisquare_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_param_estimate.md)`()`,
[`util_exponential_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_param_estimate.md)`()`,
[`util_f_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_f_param_estimate.md)`()`,
[`util_gamma_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_param_estimate.md)`()`,
[`util_geometric_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_param_estimate.md)`()`,
[`util_hypergeometric_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_param_estimate.md)`()`,
[`util_logistic_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_param_estimate.md)`()`,
[`util_lognormal_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_param_estimate.md)`()`,
[`util_negative_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md)`()`,
[`util_normal_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_normal_param_estimate.md)`()`,
[`util_pareto_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_param_estimate.md)`()`,
[`util_poisson_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md)`()`,
[`util_triangular_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_param_estimate.md)`()`,
[`util_uniform_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_param_estimate.md)`()`,
[`util_weibull_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_param_estimate.md)`()`,
[`util_zero_truncated_poisson_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_param_estimate.md)`()`

Other Binomial:
[`tidy_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md)`()`,
[`tidy_negative_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md)`()`,
[`tidy_zero_truncated_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md)`()`,
[`tidy_zero_truncated_negative_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md)`()`,
[`util_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md)`()`,
[`util_binomial_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md)`()`,
[`util_negative_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md)`()`,
[`util_zero_truncaetd_negative_binomial_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncaetd_negative_binomial_stats_tbl.md)

Other Zero Truncated Negative Distribution:
[`tidy_zero_truncated_negative_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md)`()`

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
library(ggplot2)
library(actuar)

x <- as.integer(mtcars$mpg)
output <- util_ztn_binomial_param_estimate(x)

output$parameter_tbl
#> # A tibble: 1 × 8
#>   dist_type                       samp_size   min   max  mean method  size  prob
#>   <chr>                               <int> <dbl> <dbl> <dbl> <chr>  <dbl> <dbl>
#> 1 Zero-Truncated Negative Binomi…        32    10    33  19.7 MLE_O…  26.9 0.577

output$combined_data_tbl |>
  tidy_combined_autoplot()


set.seed(123)
t <- rztnbinom(100, 10, .1)
util_ztn_binomial_param_estimate(t)$parameter_tbl
#> # A tibble: 1 × 8
#>   dist_type                       samp_size   min   max  mean method  size  prob
#>   <chr>                               <int> <dbl> <dbl> <dbl> <chr>  <dbl> <dbl>
#> 1 Zero-Truncated Negative Binomi…       100    22   183  89.6 MLE_O…  10.7 0.107
```
