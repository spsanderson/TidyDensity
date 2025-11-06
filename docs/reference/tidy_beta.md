# Tidy Randomly Generated Beta Distribution Tibble

This function will generate `n` random points from a beta distribution
with a user provided, `.shape1`, `.shape2`, `.ncp` or
`non-centrality parameter`, and number of random simulations to be
produced. The function returns a tibble with the simulation number
column the x column which corresponds to the n randomly generated
points, the `d_`, `p_` and `q_` data points as well.

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
tidy_beta(
  .n = 50,
  .shape1 = 1,
  .shape2 = 1,
  .ncp = 0,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .shape1:

  A non-negative parameter of the Beta distribution.

- .shape2:

  A non-negative parameter of the Beta distribution.

- .ncp:

  The `non-centrality parameter` of the Beta distribution.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rbeta()`](https://rdrr.io/r/stats/Beta.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`stats::rbeta()`](https://rdrr.io/r/stats/Beta.html)

## See also

<https://statisticsglobe.com/beta-distribution-in-r-dbeta-pbeta-qbeta-rbeta>

<https://en.wikipedia.org/wiki/Beta_distribution>

Other Continuous Distribution:
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
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md),
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

Other Beta:
[`tidy_generalized_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_generalized_beta.md),
[`util_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_param_estimate.md),
[`util_beta_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_beta()
#> # A tibble: 50 × 7
#>    sim_number     x     y      dx      dy     p     q
#>    <fct>      <int> <dbl>   <dbl>   <dbl> <dbl> <dbl>
#>  1 1              1 0.419 -0.377  0.00316 0.419 0.419
#>  2 1              2 0.229 -0.341  0.00749 0.229 0.229
#>  3 1              3 0.710 -0.305  0.0165  0.710 0.710
#>  4 1              4 0.737 -0.270  0.0336  0.737 0.737
#>  5 1              5 0.497 -0.234  0.0635  0.497 0.497
#>  6 1              6 0.995 -0.198  0.112   0.995 0.995
#>  7 1              7 0.252 -0.162  0.182   0.252 0.252
#>  8 1              8 0.336 -0.127  0.276   0.336 0.336
#>  9 1              9 0.451 -0.0911 0.392   0.451 0.451
#> 10 1             10 0.497 -0.0553 0.519   0.497 0.497
#> # ℹ 40 more rows
```
