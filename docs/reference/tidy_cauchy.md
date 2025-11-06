# Tidy Randomly Generated Cauchy Distribution Tibble

This function will generate `n` random points from a cauchy distribution
with a user provided, `.location`, `.scale`, and number of random
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
tidy_cauchy(
  .n = 50,
  .location = 0,
  .scale = 1,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .location:

  The location parameter.

- .scale:

  The scale parameter, must be greater than or equal to 0.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rcauchy()`](https://rdrr.io/r/stats/Cauchy.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`stats::rcauchy()`](https://rdrr.io/r/stats/Cauchy.html)

## See also

<https://www.itl.nist.gov/div898/handbook/eda/section3/eda3663.htm>

Other Continuous Distribution:
[`tidy_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_beta.md),
[`tidy_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_burr.md),
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

Other Cauchy:
[`util_cauchy_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_param_estimate.md),
[`util_cauchy_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_cauchy()
#> # A tibble: 50 × 7
#>    sim_number     x        y      dx       dy      p        q
#>    <fct>      <int>    <dbl>   <dbl>    <dbl>  <dbl>    <dbl>
#>  1 1              1   4.59   -16.7   0.000205 0.932    4.59  
#>  2 1              2  -0.173  -14.7   0.0183   0.446   -0.173 
#>  3 1              3  83.2    -12.6   0.000240 0.996   83.2   
#>  4 1              4 -14.1    -10.5   0.0151   0.0225 -14.1   
#>  5 1              5  -3.24    -8.46  0.000802 0.0953  -3.24  
#>  6 1              6   0.110   -6.39  0.0188   0.535    0.110 
#>  7 1              7  -6.65    -4.32  0.00818  0.0475  -6.65  
#>  8 1              8   0.199   -2.25  0.0447   0.563    0.199 
#>  9 1              9   0.0877  -0.178 0.294    0.528    0.0877
#> 10 1             10   0.626    1.89  0.0671   0.678    0.626 
#> # ℹ 40 more rows
```
