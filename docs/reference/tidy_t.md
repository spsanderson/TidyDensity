# Tidy Randomly Generated T Distribution Tibble

This function will generate `n` random points from a rt distribution
with a user provided, `df`, `ncp`, and number of random simulations to
be produced. The function returns a tibble with the simulation number
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
tidy_t(.n = 50, .df = 1, .ncp = 0, .num_sims = 1, .return_tibble = TRUE)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .df:

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
[`stats::rt()`](https://rdrr.io/r/stats/TDist.html), and its underlying
`p`, `d`, and `q` functions. For more information please see
[`stats::rt()`](https://rdrr.io/r/stats/TDist.html)

## See also

<https://www.itl.nist.gov/div898/handbook/eda/section3/eda3664.htm>

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
[`tidy_triangular()`](https://www.spsanderson.com/TidyDensity/reference/tidy_triangular.md),
[`tidy_uniform()`](https://www.spsanderson.com/TidyDensity/reference/tidy_uniform.md),
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other T Distribution:
[`util_t_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_t_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_t()
#> # A tibble: 50 × 7
#>    sim_number     x        y    dx       dy       p        q
#>    <fct>      <int>    <dbl> <dbl>    <dbl>   <dbl>    <dbl>
#>  1 1              1   0.187  -34.7 1.31e- 4 0.559     0.187 
#>  2 1              2   1.15   -33.8 2.50e- 3 0.772     1.15  
#>  3 1              3   1.83   -33.0 1.00e- 2 0.841     1.83  
#>  4 1              4   0.664  -32.1 8.47e- 3 0.687     0.664 
#>  5 1              5 -32.6    -31.2 1.50e- 3 0.00976 -32.6   
#>  6 1              6   0.452  -30.3 5.60e- 5 0.635     0.452 
#>  7 1              7  -6.23   -29.4 4.33e- 7 0.0507   -6.23  
#>  8 1              8   0.870  -28.6 6.72e-10 0.728     0.870 
#>  9 1              9   0.425  -27.7 2.39e-13 0.628     0.425 
#> 10 1             10   0.0347 -26.8 1.08e-17 0.511     0.0347
#> # ℹ 40 more rows
```
