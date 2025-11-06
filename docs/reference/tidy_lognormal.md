# Tidy Randomly Generated Lognormal Distribution Tibble

This function will generate `n` random points from a lognormal
distribution with a user provided, `.meanlog`, `.sdlog`, and number of
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
tidy_lognormal(
  .n = 50,
  .meanlog = 0,
  .sdlog = 1,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .meanlog:

  Mean of the distribution on the log scale with default 0

- .sdlog:

  Standard deviation of the distribution on the log scale with default 1

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rlnorm()`](https://rdrr.io/r/stats/Lognormal.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`stats::rlnorm()`](https://rdrr.io/r/stats/Lognormal.html)

## See also

<https://www.itl.nist.gov/div898/handbook/eda/section3/eda3669.htm>

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
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md),
[`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md),
[`tidy_logistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_logistic.md),
[`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md),
[`tidy_paralogistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_paralogistic.md),
[`tidy_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto.md),
[`tidy_pareto1()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto1.md),
[`tidy_t()`](https://www.spsanderson.com/TidyDensity/reference/tidy_t.md),
[`tidy_triangular()`](https://www.spsanderson.com/TidyDensity/reference/tidy_triangular.md),
[`tidy_uniform()`](https://www.spsanderson.com/TidyDensity/reference/tidy_uniform.md),
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Lognormal:
[`util_lognormal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_param_estimate.md),
[`util_lognormal_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_lognormal()
#> # A tibble: 50 × 7
#>    sim_number     x     y      dx       dy      p     q
#>    <fct>      <int> <dbl>   <dbl>    <dbl>  <dbl> <dbl>
#>  1 1              1 1.02  -0.788  0.000728 0.510  1.02 
#>  2 1              2 1.43  -0.546  0.00861  0.640  1.43 
#>  3 1              3 0.376 -0.304  0.0557   0.164  0.376
#>  4 1              4 0.642 -0.0618 0.207    0.329  0.642
#>  5 1              5 0.910  0.180  0.460    0.463  0.910
#>  6 1              6 0.258  0.423  0.658    0.0876 0.258
#>  7 1              7 0.440  0.665  0.678    0.206  0.440
#>  8 1              8 0.345  0.907  0.548    0.143  0.345
#>  9 1              9 0.616  1.15   0.344    0.314  0.616
#> 10 1             10 0.470  1.39   0.172    0.225  0.470
#> # ℹ 40 more rows
```
