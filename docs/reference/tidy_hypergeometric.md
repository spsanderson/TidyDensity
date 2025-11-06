# Tidy Randomly Generated Hypergeometric Distribution Tibble

This function will generate `n` random points from a hypergeometric
distribution with a user provided, `m`,`nn`, and `k`, and number of
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
tidy_hypergeometric(
  .n = 50,
  .m = 0,
  .nn = 0,
  .k = 0,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .m:

  The number of white balls in the urn

- .nn:

  The number of black balls in the urn

- .k:

  The number of balls drawn fro the urn.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rhyper()`](https://rdrr.io/r/stats/Hypergeometric.html), and
its underlying `p`, `d`, and `q` functions. For more information please
see [`stats::rhyper()`](https://rdrr.io/r/stats/Hypergeometric.html)

## See also

<https://en.wikipedia.org/wiki/Hypergeometric_distribution>

Other Discrete Distribution:
[`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md),
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md),
[`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md),
[`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md),
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md)

Other Hypergeometric:
[`util_hypergeometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_param_estimate.md),
[`util_hypergeometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_hypergeometric()
#> # A tibble: 50 × 7
#>    sim_number     x     y     dx     dy     p     q
#>    <fct>      <int> <int>  <dbl>  <dbl> <dbl> <dbl>
#>  1 1              1     0 -1.23  0.0108     1     0
#>  2 1              2     0 -1.18  0.0155     1     0
#>  3 1              3     0 -1.13  0.0218     1     0
#>  4 1              4     0 -1.08  0.0303     1     0
#>  5 1              5     0 -1.03  0.0415     1     0
#>  6 1              6     0 -0.983 0.0561     1     0
#>  7 1              7     0 -0.932 0.0745     1     0
#>  8 1              8     0 -0.882 0.0976     1     0
#>  9 1              9     0 -0.832 0.126      1     0
#> 10 1             10     0 -0.781 0.160      1     0
#> # ℹ 40 more rows
```
