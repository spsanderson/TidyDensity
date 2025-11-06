# Tidy Randomly Generated Weibull Distribution Tibble

This function will generate `n` random points from a weibull
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
tidy_weibull(
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

  Shape parameter defaults to 0.

- .scale:

  Scale parameter defaults to 1.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rweibull()`](https://rdrr.io/r/stats/Weibull.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`stats::rweibull()`](https://rdrr.io/r/stats/Weibull.html)

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
[`tidy_lognormal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_lognormal.md),
[`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md),
[`tidy_paralogistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_paralogistic.md),
[`tidy_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto.md),
[`tidy_pareto1()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto1.md),
[`tidy_t()`](https://www.spsanderson.com/TidyDensity/reference/tidy_t.md),
[`tidy_triangular()`](https://www.spsanderson.com/TidyDensity/reference/tidy_triangular.md),
[`tidy_uniform()`](https://www.spsanderson.com/TidyDensity/reference/tidy_uniform.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Weibull:
[`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md),
[`util_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_param_estimate.md),
[`util_weibull_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_weibull()
#> # A tibble: 50 × 7
#>    sim_number     x      y      dx      dy      p      q
#>    <fct>      <int>  <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 1              1 1.97   -0.903  0.00137 0.860  1.97  
#>  2 1              2 2.25   -0.783  0.00459 0.895  2.25  
#>  3 1              3 0.0354 -0.663  0.0133  0.0348 0.0354
#>  4 1              4 1.40   -0.542  0.0335  0.752  1.40  
#>  5 1              5 0.248  -0.422  0.0736  0.219  0.248 
#>  6 1              6 0.201  -0.301  0.141   0.182  0.201 
#>  7 1              7 2.86   -0.181  0.238   0.943  2.86  
#>  8 1              8 0.126  -0.0607 0.356   0.118  0.126 
#>  9 1              9 0.901   0.0597 0.475   0.594  0.901 
#> 10 1             10 3.76    0.180  0.574   0.977  3.76  
#> # ℹ 40 more rows
```
