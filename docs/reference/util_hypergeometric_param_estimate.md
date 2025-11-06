# Estimate Hypergeometric Parameters

This function will attempt to estimate the geometric prob parameter
given some vector of values `.x`. Estimate m, the number of white balls
in the urn, or m+n, the total number of balls in the urn, for a
hypergeometric distribution.

## Usage

``` r
util_hypergeometric_param_estimate(
  .x,
  .m = NULL,
  .total = NULL,
  .k,
  .auto_gen_empirical = TRUE
)
```

## Arguments

- .x:

  A non-negative integer indicating the number of white balls out of a
  sample of size `.k` drawn without replacement from the urn. You cannot
  have missing, undefined or infinite values.

- .m:

  Non-negative integer indicating the number of white balls in the urn.
  You must supply `.m` or `.total`, but not both. You cannot have
  missing values.

- .total:

  A positive integer indicating the total number of balls in the urn
  (i.e., m+n). You must supply `.m` or `.total`, but not both. You
  cannot have missing values.

- .k:

  A positive integer indicating the number of balls drawn without
  replacement from the urn. You cannot have missing values.

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

This function will see if the given vector `.x` is a numeric integer. It
will attempt to estimate the prob parameter of a geometric distribution.
Missing (NA), undefined (NaN), and infinite (Inf, -Inf) values are not
allowed. Let `.x` be an observation from a hypergeometric distribution
with parameters `.m` = `M`, .`n` = `N`, and `.k` = `K`. In R
nomenclature, .`x` represents the number of white balls drawn out of a
sample of `.k` balls drawn without replacement from an urn containing
`.m` white balls and `.n` black balls. The total number of balls in the
urn is thus `.m` + `.n`. Denote the total number of balls by `T` =
`.m` + `.n`

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
[`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md),
[`util_zero_truncated_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_param_estimate.md)

Other Hypergeometric:
[`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md),
[`util_hypergeometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
library(ggplot2)

th <- rhyper(10, 20, 30, 5)
output <- util_hypergeometric_param_estimate(th, .total = 50, .k = 5)

output$parameter_tbl
#> # A tibble: 2 × 5
#>   dist_type      samp_size method            m total
#>   <chr>              <int> <chr>         <dbl> <dbl>
#> 1 Hypergeometric        10 EnvStats_MLE   20.4    NA
#> 2 Hypergeometric        10 EnvStats_MVUE  20      50

output$combined_data_tbl |>
  tidy_combined_autoplot()

```
