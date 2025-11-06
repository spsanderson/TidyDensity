# Tidy Randomly Generated Bernoulli Distribution Tibble

This function will generate `n` random points from a Bernoulli
distribution with a user provided, `.prob`, and number of random
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
tidy_bernoulli(.n = 50, .prob = 0.1, .num_sims = 1, .return_tibble = TRUE)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .prob:

  The probability of success/failure.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the
[`rbinom()`](https://rdrr.io/r/stats/Binomial.html), and its underlying
`p`, `d`, and `q` functions. The *Bernoulli* distribution is a special
case of the *Binomial* distribution with `size = 1` hence this is why
the `binom` functions are used and set to size = 1.

## See also

<https://en.wikipedia.org/wiki/Bernoulli_distribution>

Other Discrete Distribution:
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md),
[`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md),
[`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md),
[`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md),
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md)

Other Bernoulli:
[`util_bernoulli_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_param_estimate.md),
[`util_bernoulli_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_bernoulli()
#> # A tibble: 50 × 7
#>    sim_number     x     y       dx     dy     p     q
#>    <fct>      <int> <int>    <dbl>  <dbl> <dbl> <dbl>
#>  1 1              1     0 -0.296   0.0423   0.9     0
#>  2 1              2     0 -0.264   0.108    0.9     0
#>  3 1              3     0 -0.231   0.245    0.9     0
#>  4 1              4     1 -0.199   0.502    1       1
#>  5 1              5     0 -0.166   0.922    0.9     0
#>  6 1              6     0 -0.134   1.52     0.9     0
#>  7 1              7     0 -0.101   2.25     0.9     0
#>  8 1              8     0 -0.0687  2.98     0.9     0
#>  9 1              9     0 -0.0362  3.55     0.9     0
#> 10 1             10     0 -0.00372 3.79     0.9     0
#> # ℹ 40 more rows
```
