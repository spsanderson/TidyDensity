# Tidy Randomly Generated Zero Truncated Poisson Distribution Tibble

This function will generate `n` random points from a Zero Truncated
Poisson distribution with a user provided, `.lambda`, and number of
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
tidy_zero_truncated_poisson(
  .n = 50,
  .lambda = 1,
  .num_sims = 1,
  .return_tibble = TRUE
)
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
[`actuar::rztpois()`](https://rdrr.io/pkg/actuar/man/ZeroTruncatedPoisson.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rztpois()`](https://rdrr.io/pkg/actuar/man/ZeroTruncatedPoisson.html)

## See also

<https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html>

Other Poisson:
[`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md),
[`util_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md),
[`util_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_stats_tbl.md),
[`util_zero_truncated_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_param_estimate.md),
[`util_zero_truncated_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_stats_tbl.md)

Other Zero Truncated Distribution:
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md),
[`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md)

Other Discrete Distribution:
[`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md),
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md),
[`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md),
[`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md),
[`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_zero_truncated_poisson()
#> # A tibble: 50 × 7
#>    sim_number     x     y    dx      dy     p     q
#>    <fct>      <int> <int> <dbl>   <dbl> <dbl> <dbl>
#>  1 1              1     1 0.202 0.00934 0.582     1
#>  2 1              2     2 0.275 0.0206  0.873     2
#>  3 1              3     1 0.349 0.0420  0.582     1
#>  4 1              4     1 0.422 0.0794  0.582     1
#>  5 1              5     2 0.495 0.139   0.873     2
#>  6 1              6     1 0.569 0.226   0.582     1
#>  7 1              7     2 0.642 0.340   0.873     2
#>  8 1              8     2 0.716 0.474   0.873     2
#>  9 1              9     3 0.789 0.613   0.970     3
#> 10 1             10     1 0.862 0.734   0.582     1
#> # ℹ 40 more rows
```
