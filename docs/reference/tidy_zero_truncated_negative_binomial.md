# Tidy Randomly Generated Binomial Distribution Tibble

This function will generate `n` random points from a zero truncated
binomial distribution with a user provided, `.size`, `.prob`, and number
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
tidy_zero_truncated_negative_binomial(
  .n = 50,
  .size = 0,
  .prob = 1,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .size:

  Number of trials, zero or more.

- .prob:

  Probability of success on each trial 0 \<= prob \<= 1.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`actuar::rztnbinom()`](https://rdrr.io/pkg/actuar/man/ZeroTruncatedNegativeBinomial.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rztnbinom()`](https://rdrr.io/pkg/actuar/man/ZeroTruncatedNegativeBinomial.html)

## See also

<https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html>

Other Discrete Distribution:
[`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md),
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md),
[`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md),
[`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md),
[`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md)

Other Binomial:
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`util_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md),
[`util_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md),
[`util_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md),
[`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md),
[`util_zero_truncated_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_stats_tbl.md),
[`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md),
[`util_zero_truncated_negative_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_stats_tbl.md)

Other Zero Truncated Negative Distribution:
[`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_zero_truncated_negative_binomial()
#> # A tibble: 50 × 7
#>    sim_number     x     y      dx     dy     p     q
#>    <fct>      <int> <int>   <dbl>  <dbl> <dbl> <dbl>
#>  1 1              1     1 -0.235  0.0108     1     1
#>  2 1              2     1 -0.184  0.0155     1     1
#>  3 1              3     1 -0.134  0.0218     1     1
#>  4 1              4     1 -0.0835 0.0303     1     1
#>  5 1              5     1 -0.0331 0.0415     1     1
#>  6 1              6     1  0.0173 0.0561     1     1
#>  7 1              7     1  0.0677 0.0745     1     1
#>  8 1              8     1  0.118  0.0976     1     1
#>  9 1              9     1  0.168  0.126      1     1
#> 10 1             10     1  0.219  0.160      1     1
#> # ℹ 40 more rows
```
