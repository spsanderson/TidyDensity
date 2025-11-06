# Estimate Inverse Weibull Parameters

The function will return a list output by default, and if the parameter
`.auto_gen_empirical` is set to `TRUE` then the empirical data given to
the parameter `.x` will be run through the
[`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
function and combined with the estimated inverse Weibull data.

## Usage

``` r
util_invweibull_param_estimate(.x, .auto_gen_empirical = TRUE)
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

This function will attempt to estimate the inverse Weibull shape and
rate parameters given some vector of values.

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
[`util_paralogistic_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_param_estimate.md)`()`,
[`util_pareto1_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_param_estimate.md)`()`,
[`util_pareto_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_param_estimate.md)`()`,
[`util_poisson_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md)`()`,
[`util_t_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_t_param_estimate.md)`()`,
[`util_triangular_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_param_estimate.md)`()`,
[`util_uniform_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_param_estimate.md)`()`,
[`util_weibull_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_param_estimate.md)`()`,
[`util_zero_truncated_geometric_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_param_estimate.md)`()`,
[`util_zero_truncated_negative_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md)`()`,
[`util_zero_truncated_poisson_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_param_estimate.md)`()`

Other Inverse Weibull:
[`util_inverse_weibull_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_stats_tbl.md)`()`

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
library(ggplot2)

set.seed(123)
x <- tidy_inverse_weibull(100, .shape = 2, .scale = 1)[["y"]]
output <- util_invweibull_param_estimate(x)

output$parameter_tbl
#> # A tibble: 1 × 8
#>   dist_type       samp_size   min   max method shape scale  rate
#>   <chr>               <int> <dbl> <dbl> <chr>  <dbl> <dbl> <dbl>
#> 1 Inverse Weibull       100 0.372  14.7 MLE     2.11 0.967  1.03

output$combined_data_tbl %>%
  tidy_combined_autoplot()

```
