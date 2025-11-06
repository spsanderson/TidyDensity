# Tidy Randomly Generated Inverse Weibull Distribution Tibble

This function will generate `n` random points from a weibull
distribution with a user provided, `.shape`, `.scale`, `.rate`, and
number of random simulations to be produced. The function returns a
tibble with the simulation number column the x column which corresponds
to the n randomly generated points, the `d_`, `p_` and `q_` data points
as well.

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
tidy_inverse_weibull(
  .n = 50,
  .shape = 1,
  .rate = 1,
  .scale = 1/.rate,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .shape:

  Must be strictly positive.

- .rate:

  An alternative way to specify the `.scale`.

- .scale:

  Must be strictly positive.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`actuar::rinvweibull()`](https://rdrr.io/pkg/actuar/man/InverseWeibull.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rinvweibull()`](https://rdrr.io/pkg/actuar/man/InverseWeibull.html)

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
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md),
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

Other Weibull:
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`util_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_param_estimate.md),
[`util_weibull_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_stats_tbl.md)

Other Inverse Distribution:
[`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md),
[`tidy_inverse_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_exponential.md),
[`tidy_inverse_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_gamma.md),
[`tidy_inverse_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_normal.md),
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_inverse_weibull()
#> # A tibble: 50 × 7
#>    sim_number     x      y     dx       dy     p      q
#>    <fct>      <int>  <dbl>  <dbl>    <dbl> <dbl>  <dbl>
#>  1 1              1  2.93  -2.97  0.000702 0.711  2.93 
#>  2 1              2  2.09  -1.68  0.0174   0.620  2.09 
#>  3 1              3 57.4   -0.378 0.110    0.983 57.4  
#>  4 1              4 37.0    0.920 0.206    0.973 37.0  
#>  5 1              5  0.482  2.22  0.159    0.126  0.482
#>  6 1              6  7.41   3.52  0.0763   0.874  7.41 
#>  7 1              7  1.91   4.81  0.0325   0.592  1.91 
#>  8 1              8  7.19   6.11  0.0318   0.870  7.19 
#>  9 1              9  1.06   7.41  0.0399   0.391  1.06 
#> 10 1             10  7.31   8.71  0.0178   0.872  7.31 
#> # ℹ 40 more rows
```
