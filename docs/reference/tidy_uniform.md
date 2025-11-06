# Tidy Randomly Generated Uniform Distribution Tibble

This function will generate `n` random points from a uniform
distribution with a user provided, `.min` and `.max` values, and number
of random simulations to be produced. The function returns a tibble with
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
tidy_uniform(.n = 50, .min = 0, .max = 1, .num_sims = 1, .return_tibble = TRUE)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .min:

  A lower limit of the distribution.

- .max:

  An upper limit of the distribution

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::runif()`](https://rdrr.io/r/stats/Uniform.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`stats::runif()`](https://rdrr.io/r/stats/Uniform.html)

## See also

<https://www.itl.nist.gov/div898/handbook/eda/section3/eda3662.htm>

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
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Uniform:
[`util_uniform_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_param_estimate.md),
[`util_uniform_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_uniform()
#> # A tibble: 50 × 7
#>    sim_number     x       y      dx      dy       p       q
#>    <fct>      <int>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#>  1 1              1 0.157   -0.296  0.00219 0.157   0.157  
#>  2 1              2 0.699   -0.265  0.00539 0.699   0.699  
#>  3 1              3 0.00615 -0.234  0.0122  0.00615 0.00615
#>  4 1              4 0.0328  -0.204  0.0253  0.0328  0.0328 
#>  5 1              5 0.397   -0.173  0.0485  0.397   0.397  
#>  6 1              6 0.288   -0.143  0.0861  0.288   0.288  
#>  7 1              7 0.722   -0.112  0.142   0.722   0.722  
#>  8 1              8 0.245   -0.0813 0.219   0.245   0.245  
#>  9 1              9 0.607   -0.0506 0.316   0.607   0.607  
#> 10 1             10 0.447   -0.0200 0.432   0.447   0.447  
#> # ℹ 40 more rows
```
