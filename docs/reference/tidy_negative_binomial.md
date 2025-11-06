# Tidy Randomly Generated Negative Binomial Distribution Tibble

This function will generate `n` random points from a negative binomial
distribution with a user provided, `.size`, `.prob`, and number of
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
tidy_negative_binomial(
  .n = 50,
  .size = 1,
  .prob = 0.1,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .size:

  target for number of successful trials, or dispersion parameter (the
  shape parameter of the gamma mixing distribution). Must be strictly
  positive, need not be integer.

- .prob:

  Probability of success on each trial where 0 \< .prob \<= 1.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`stats::rnbinom()`](https://rdrr.io/r/stats/NegBinomial.html), and its
underlying `p`, `d`, and `q` functions. For more information please see
[`stats::rnbinom()`](https://rdrr.io/r/stats/NegBinomial.html)

## See also

<https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html>

Other Discrete Distribution:
[`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md),
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md),
[`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md),
[`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md),
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md)

Other Binomial:
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md),
[`util_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md),
[`util_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md),
[`util_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md),
[`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md),
[`util_zero_truncated_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_stats_tbl.md),
[`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md),
[`util_zero_truncated_negative_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_negative_binomial()
#> # A tibble: 50 × 7
#>    sim_number     x     y     dx       dy     p     q
#>    <fct>      <int> <int>  <dbl>    <dbl> <dbl> <dbl>
#>  1 1              1     4 -9.47  0.000175 0.410     4
#>  2 1              2     8 -8.43  0.000482 0.613     8
#>  3 1              3    15 -7.39  0.00120  0.815    15
#>  4 1              4     3 -6.35  0.00270  0.344     3
#>  5 1              5     1 -5.31  0.00551  0.190     1
#>  6 1              6     4 -4.27  0.0102   0.410     4
#>  7 1              7    18 -3.24  0.0172   0.865    18
#>  8 1              8     2 -2.20  0.0263   0.271     2
#>  9 1              9    10 -1.16  0.0369   0.686    10
#> 10 1             10     8 -0.116 0.0473   0.613     8
#> # ℹ 40 more rows
```
