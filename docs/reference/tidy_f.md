# Tidy Randomly Generated F Distribution Tibble

This function will generate `n` random points from a rf distribution
with a user provided, `df1`,`df2`, and `ncp`, and number of random
simulations to be produced. The function returns a tibble with the
simulation number column the x column which corresponds to the n
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
tidy_f(
  .n = 50,
  .df1 = 1,
  .df2 = 1,
  .ncp = 0,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .df1:

  Degrees of freedom, Inf is allowed.

- .df2:

  Degrees of freedom, Inf is allowed.

- .ncp:

  Non-centrality parameter.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rf()`](https://rdrr.io/r/stats/Fdist.html), and its underlying
`p`, `d`, and `q` functions. For more information please see
[`stats::rf()`](https://rdrr.io/r/stats/Fdist.html)

## See also

<https://www.itl.nist.gov/div898/handbook/eda/section3/eda3665.htm>

Other Continuous Distribution:
[`tidy_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_beta.md),
[`tidy_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_burr.md),
[`tidy_cauchy()`](https://www.spsanderson.com/TidyDensity/reference/tidy_cauchy.md),
[`tidy_chisquare()`](https://www.spsanderson.com/TidyDensity/reference/tidy_chisquare.md),
[`tidy_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_exponential.md),
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

Other F Distribution:
[`util_f_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_f_param_estimate.md),
[`util_f_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_f_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_f()
#> # A tibble: 50 × 7
#>    sim_number     x      y      dx       dy      p      q
#>    <fct>      <int>  <dbl>   <dbl>    <dbl>  <dbl>  <dbl>
#>  1 1              1 0.579    -7.37 6.12e- 2 0.414  0.579 
#>  2 1              2 0.250   245.   6.72e-20 0.295  0.250 
#>  3 1              3 0.211   497.   4.36e-20 0.274  0.211 
#>  4 1              4 0.762   750.   9.42e-20 0.457  0.762 
#>  5 1              5 9.35   1002.   1.55e-20 0.799  9.35  
#>  6 1              6 0.0243 1254.   1.46e-19 0.0985 0.0243
#>  7 1              7 8.63   1506.   6.44e-20 0.791  8.63  
#>  8 1              8 0.249  1759.   0        0.294  0.249 
#>  9 1              9 2.67   2011.   6.42e-20 0.651  2.67  
#> 10 1             10 5.03   2263.   1.89e-20 0.733  5.03  
#> # ℹ 40 more rows
```
