# Tidy Randomly Generated Inverse Pareto Distribution Tibble

This function will generate `n` random points from an inverse pareto
distribution with a user provided, `.shape`, `.scale`, and number of
random simulations to be produced. The function returns a tibble with
the simulation number column the x column which corresponds to the n
randomly generated points, the `d_`, `p_` and `q_` data points as well.

The data is returned un-grouped.

The columns that are output are:

- `sim_number` The current simulation number.

- `x` The current value of `n` for the current simulation.

- `y` The randomly generated data point.

- `dx` The `x` value from the
  [`stats::density()`](https://rdrr.io/r/stats/density.html) function.

- `dy` The `y` value from the
  [`stats::density()`](https://rdrr.io/r/stats/density.html) function.

- `p` The values from the resulting p\_ function of the distribution
  family.

- `q` The values from the resulting q\_ function of the distribution
  family.

## Usage

``` r
tidy_inverse_pareto(
  .n = 50,
  .shape = 1,
  .scale = 1,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .shape:

  Must be positive.

- .scale:

  Must be positive.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`actuar::rinvpareto()`](https://rdrr.io/pkg/actuar/man/InversePareto.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rinvpareto()`](https://rdrr.io/pkg/actuar/man/InversePareto.html)

## See also

<https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html>

Other Continuous Distribution:
[`tidy_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_beta.md),
[`tidy_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_burr.md),
[`tidy_cauchy()`](https://www.spsanderson.com/TidyDensity/reference/tidy_cauchy.md),
[`tidy_chisquare()`](https://www.spsanderson.com/TidyDensity/reference/tidy_chisquare.md),
[`tidy_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_exponential.md),
[`tidy_f()`](https://www.spsanderson.com/TidyDensity/reference/tidy_f.md),
[`tidy_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_gamma.md),
[`tidy_generalized_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_generalized_beta.md),
[`tidy_generalized_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_generalized_pareto.md),
[`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md),
[`tidy_inverse_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_exponential.md),
[`tidy_inverse_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_gamma.md),
[`tidy_inverse_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_normal.md),
[`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md),
[`tidy_logistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_logistic.md),
[`tidy_lognormal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_lognormal.md),
[`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md),
[`tidy_paralogistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_paralogistic.md),
[`tidy_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto.md),
[`tidy_pareto1()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto1.md),
[`tidy_t()`](https://www.spsanderson.com/TidyDensity/reference/tidy_t.md),
[`tidy_triangular()`](https://www.spsanderson.com/TidyDensity/reference/tidy_triangular.md),
[`tidy_uniform()`](https://www.spsanderson.com/TidyDensity/reference/tidy_uniform.md),
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Pareto:
[`tidy_generalized_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_generalized_pareto.md),
[`tidy_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto.md),
[`tidy_pareto1()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto1.md),
[`util_pareto1_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_aic.md),
[`util_pareto1_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_param_estimate.md),
[`util_pareto1_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_stats_tbl.md),
[`util_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_param_estimate.md),
[`util_pareto_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_stats_tbl.md)

Other Inverse Distribution:
[`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md),
[`tidy_inverse_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_exponential.md),
[`tidy_inverse_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_gamma.md),
[`tidy_inverse_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_normal.md),
[`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_inverse_pareto()
#> # A tibble: 50 × 7
#>    sim_number     x     y     dx       dy     p     q
#>    <fct>      <int> <dbl>  <dbl>    <dbl> <dbl> <dbl>
#>  1 1              1 0.206 -2.83  0.000887 0.171 0.206
#>  2 1              2 3.61  -1.75  0.0166   0.783 3.61 
#>  3 1              3 0.630 -0.666 0.0953   0.387 0.630
#>  4 1              4 0.972  0.415 0.193    0.493 0.972
#>  5 1              5 1.57   1.50  0.184    0.612 1.57 
#>  6 1              6 3.40   2.58  0.127    0.773 3.40 
#>  7 1              7 1.96   3.66  0.0869   0.663 1.96 
#>  8 1              8 3.24   4.74  0.0517   0.764 3.24 
#>  9 1              9 2.56   5.82  0.0287   0.719 2.56 
#> 10 1             10 3.56   6.90  0.0114   0.781 3.56 
#> # ℹ 40 more rows
```
