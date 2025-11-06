# Tidy Randomly Generated Poisson Distribution Tibble

This function will generate `n` random points from a Poisson
distribution with a user provided, `.lambda`, and number of random
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
tidy_poisson(.n = 50, .lambda = 1, .num_sims = 1, .return_tibble = TRUE)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .lambda:

  A vector of non-negative means.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rpois()`](https://rdrr.io/r/stats/Poisson.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`stats::rpois()`](https://rdrr.io/r/stats/Poisson.html)

## See also

<https://r-coder.com/poisson-distribution-r/>

<https://en.wikipedia.org/wiki/Poisson_distribution>

Other Poisson:
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md),
[`util_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md),
[`util_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_stats_tbl.md),
[`util_zero_truncated_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_param_estimate.md),
[`util_zero_truncated_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_stats_tbl.md)

Other Discrete Distribution:
[`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md),
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md),
[`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md),
[`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md),
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_poisson()
#> # A tibble: 50 × 7
#>    sim_number     x     y      dx      dy     p     q
#>    <fct>      <int> <int>   <dbl>   <dbl> <dbl> <dbl>
#>  1 1              1     1 -0.691  0.00503 0.736     1
#>  2 1              2     2 -0.561  0.0234  0.920     2
#>  3 1              3     0 -0.431  0.0787  0.368     0
#>  4 1              4     0 -0.300  0.193   0.368     0
#>  5 1              5     1 -0.170  0.343   0.736     1
#>  6 1              6     1 -0.0398 0.443   0.736     1
#>  7 1              7     4  0.0904 0.417   0.996     4
#>  8 1              8     2  0.221  0.287   0.920     2
#>  9 1              9     2  0.351  0.158   0.920     2
#> 10 1             10     1  0.481  0.120   0.736     1
#> # ℹ 40 more rows
```
