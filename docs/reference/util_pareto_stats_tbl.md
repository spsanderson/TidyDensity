# Distribution Statistics

Returns distribution statistics in a tibble.

## Usage

``` r
util_pareto_stats_tbl(.data)
```

## Arguments

- .data:

  The data being passed from a `tidy_` distribution function.

## Value

A tibble

## Details

This function will take in a tibble and returns the statistics of the
given type of `tidy_` distribution. It is required that data be passed
from a `tidy_` distribution function.

## See also

Other Pareto:
[`tidy_generalized_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_generalized_pareto.md),
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md),
[`tidy_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto.md),
[`tidy_pareto1()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto1.md),
[`util_pareto1_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_aic.md),
[`util_pareto1_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_param_estimate.md),
[`util_pareto1_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_stats_tbl.md),
[`util_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_param_estimate.md)

Other Distribution Statistics:
[`util_bernoulli_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_stats_tbl.md),
[`util_beta_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_stats_tbl.md),
[`util_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md),
[`util_burr_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_stats_tbl.md),
[`util_cauchy_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_stats_tbl.md),
[`util_chisquare_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_stats_tbl.md),
[`util_exponential_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_stats_tbl.md),
[`util_f_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_f_stats_tbl.md),
[`util_gamma_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_stats_tbl.md),
[`util_generalized_beta_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_beta_stats_tbl.md),
[`util_generalized_pareto_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_pareto_stats_tbl.md),
[`util_geometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_stats_tbl.md),
[`util_hypergeometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_stats_tbl.md),
[`util_inverse_burr_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_burr_stats_tbl.md),
[`util_inverse_pareto_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_pareto_stats_tbl.md),
[`util_inverse_weibull_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_stats_tbl.md),
[`util_logistic_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_stats_tbl.md),
[`util_lognormal_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_stats_tbl.md),
[`util_negative_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_stats_tbl.md),
[`util_normal_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_stats_tbl.md),
[`util_paralogistic_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_stats_tbl.md),
[`util_pareto1_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_stats_tbl.md),
[`util_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_stats_tbl.md),
[`util_t_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_t_stats_tbl.md),
[`util_triangular_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_stats_tbl.md),
[`util_uniform_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_stats_tbl.md),
[`util_weibull_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_stats_tbl.md),
[`util_zero_truncated_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_stats_tbl.md),
[`util_zero_truncated_geometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_stats_tbl.md),
[`util_zero_truncated_negative_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_stats_tbl.md),
[`util_zero_truncated_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)

tidy_pareto() |>
  util_pareto_stats_tbl() |>
  glimpse()
#> Rows: 1
#> Columns: 17
#> $ tidy_function     <chr> "tidy_pareto"
#> $ function_call     <chr> "Pareto c(10, 0.1)"
#> $ distribution      <chr> "Pareto"
#> $ distribution_type <chr> "continuous"
#> $ points            <dbl> 50
#> $ simulations       <dbl> 1
#> $ mean              <dbl> 0.1111111
#> $ mode_lower        <dbl> 0.1
#> $ range             <chr> "0 to Inf"
#> $ std_dv            <dbl> 0.0124226
#> $ coeff_var         <dbl> 0.000154321
#> $ skewness          <dbl> 2.811057
#> $ kurtosis          <dbl> 14.82857
#> $ computed_std_skew <dbl> 2.29293
#> $ computed_std_kurt <dbl> 9.307314
#> $ ci_lo             <dbl> 0.0003162781
#> $ ci_hi             <dbl> 0.04450354
```
