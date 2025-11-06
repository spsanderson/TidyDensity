# Tidy Randomly Generated Zero Truncated Geometric Distribution Tibble

This function will generate `n` random points from a zero truncated
Geometric distribution with a user provided, `.prob`, and number of
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
tidy_zero_truncated_geometric(
  .n = 50,
  .prob = 1,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .prob:

  A probability of success in each trial 0 \< prob \<= 1.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`actuar::rztgeom()`](https://rdrr.io/pkg/actuar/man/ZeroTruncatedGeometric.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rztgeom()`](https://rdrr.io/pkg/actuar/man/ZeroTruncatedGeometric.html)

## See also

<https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html>

Other Geometric:
[`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md),
[`util_geometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_param_estimate.md),
[`util_geometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_stats_tbl.md)

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
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md)

Other Zero Truncated Distribution:
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md),
[`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_zero_truncated_geometric()
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
