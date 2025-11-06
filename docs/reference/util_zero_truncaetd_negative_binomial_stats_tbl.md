# Distribution Statistics for Zero-Truncated Negative Binomial

Computes distribution statistics for a zero-truncated negative binomial
distribution.

## Arguments

- .data:

  The data from a zero-truncated negative binomial distribution.

## Value

A tibble with distribution statistics.

## Details

This function computes statistics for a zero-truncated negative binomial
distribution.

## See also

Other Binomial:
[`tidy_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md)`()`,
[`tidy_negative_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md)`()`,
[`tidy_zero_truncated_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md)`()`,
[`tidy_zero_truncated_negative_binomial`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md)`()`,
[`util_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md)`()`,
[`util_binomial_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md)`()`,
[`util_negative_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md)`()`,
[`util_ztn_binomial_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_ztn_binomial_param_estimate.md)`()`

Other Negative Binomial:
[`util_negative_binomial_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_stats_tbl.md)`()`

Other Distribution Statistics:
[`util_bernoulli_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_stats_tbl.md)`()`,
[`util_beta_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_beta_stats_tbl.md)`()`,
[`util_binomial_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md)`()`,
[`util_burr_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_burr_stats_tbl.md)`()`,
[`util_cauchy_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_stats_tbl.md)`()`,
[`util_chisquare_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_stats_tbl.md)`()`,
[`util_exponential_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_stats_tbl.md)`()`,
[`util_f_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_f_stats_tbl.md)`()`,
[`util_gamma_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_stats_tbl.md)`()`,
[`util_geometric_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_stats_tbl.md)`()`,
[`util_hypergeometric_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_stats_tbl.md)`()`,
[`util_logistic_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_stats_tbl.md)`()`,
[`util_lognormal_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_stats_tbl.md)`()`,
[`util_negative_binomial_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_stats_tbl.md)`()`,
[`util_normal_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_normal_stats_tbl.md)`()`,
[`util_pareto_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_stats_tbl.md)`()`,
[`util_poisson_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_stats_tbl.md)`()`,
[`util_t_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_t_stats_tbl.md)`()`,
[`util_triangular_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_stats_tbl.md)`()`,
[`util_uniform_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_stats_tbl.md)`()`,
[`util_weibull_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_stats_tbl.md)`()`,
[`util_zero_truncated_poisson_stats_tbl`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_stats_tbl.md)`()`

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)

tidy_zero_truncated_negative_binomial(.size = 1, .prob = 0.1) |>
 util_zero_truncated_negative_binomial_stats_tbl() |>
 glimpse()
#> Rows: 1
#> Columns: 17
#> $ tidy_function     <chr> "tidy_zero_truncated_negative_binomial"
#> $ function_call     <chr> "Zero Truncated Negative Binomial c(1, 0.1)"
#> $ distribution      <chr> "Zero Truncated Negative Binomial"
#> $ distribution_type <chr> "discrete"
#> $ points            <dbl> 50
#> $ simulations       <dbl> 1
#> $ mean              <dbl> 0.1111111
#> $ mode_lower        <dbl> 0
#> $ range             <chr> "1 to Inf"
#> $ std_dv            <dbl> 0.3513642
#> $ coeff_var         <dbl> 1.111111
#> $ skewness          <dbl> 3.478505
#> $ kurtosis          <dbl> 14.1
#> $ computed_std_skew <dbl> 0.9984757
#> $ computed_std_kurt <dbl> 3.866868
#> $ ci_lo             <dbl> 1
#> $ ci_hi             <dbl> 27.1

```
