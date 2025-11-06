# Tidy Randomly Generated Burr Distribution Tibble

This function will generate `n` random points from a Burr distribution
with a user provided, `.shape1`, `.shape2`, `.scale`, `.rate`, and
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
tidy_burr(
  .n = 50,
  .shape1 = 1,
  .shape2 = 1,
  .rate = 1,
  .scale = 1/.rate,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .shape1:

  Must be strictly positive.

- .shape2:

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
[`actuar::rburr()`](https://rdrr.io/pkg/actuar/man/Burr.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`actuar::rburr()`](https://rdrr.io/pkg/actuar/man/Burr.html)

## See also

<https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html>

Other Continuous Distribution:
[`tidy_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_beta.md),
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

Other Burr:
[`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md),
[`util_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_param_estimate.md),
[`util_burr_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_burr()
#> # A tibble: 50 × 7
#>    sim_number     x      y     dx       dy      p      q
#>    <fct>      <int>  <dbl>  <dbl>    <dbl>  <dbl>  <dbl>
#>  1 1              1  4.23  -3.05  0.000968 0.809   4.23 
#>  2 1              2  1.41  -1.22  0.0640   0.585   1.41 
#>  3 1              3  0.105  0.600 0.241    0.0953  0.105
#>  4 1              4  0.112  2.42  0.0952   0.100   0.112
#>  5 1              5  2.09   4.25  0.0331   0.676   2.09 
#>  6 1              6  9.22   6.07  0.00813  0.902   9.22 
#>  7 1              7 83.2    7.89  0.0160   0.988  83.2  
#>  8 1              8  1.24   9.72  0.0205   0.553   1.24 
#>  9 1              9  0.371 11.5   0.00417  0.271   0.371
#> 10 1             10  0.567 13.4   0.00758  0.362   0.567
#> # ℹ 40 more rows
```
