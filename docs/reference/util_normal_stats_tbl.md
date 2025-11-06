# Distribution Statistics

Returns distribution statistics in a tibble.

## Usage

``` r
util_normal_stats_tbl(.data)
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

Other Gaussian:
[`tidy_inverse_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_normal.md),
[`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md),
[`util_normal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_param_estimate.md)

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
[`util_paralogistic_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_stats_tbl.md),
[`util_pareto1_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_stats_tbl.md),
[`util_pareto_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_stats_tbl.md),
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

tidy_normal() |>
  util_normal_stats_tbl() |>
  glimpse()
#> Rows: 1
#> Columns: 17
#> $ tidy_function     <chr> "tidy_gaussian"
#> $ function_call     <chr> "Gaussian c(0, 1)"
#> $ distribution      <chr> "Gaussian"
#> $ distribution_type <chr> "continuous"
#> $ points            <dbl> 50
#> $ simulations       <dbl> 1
#> $ mean              <dbl> 0
#> $ median            <dbl> -0.3889986
#> $ mode              <dbl> 0
#> $ std_dv            <dbl> 1
#> $ coeff_var         <dbl> Inf
#> $ skewness          <dbl> 0
#> $ kurtosis          <dbl> 3
#> $ computed_std_skew <dbl> 0.7063272
#> $ computed_std_kurt <dbl> 2.472276
#> $ ci_lo             <dbl> -1.304932
#> $ ci_hi             <dbl> 1.987782
```
