# Tidy Randomly Generated Paralogistic Distribution Tibble

This function will generate `n` random points from a paralogistic
distribution with a user provided, `.shape`, `.rate`, `.scale` and
number of random simulations to be produced. The function returns a
tibble with the simulation number column the x column which corresponds
to the n randomly generated points, the `d_`, `p_` and `q_` data points
as well.

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
tidy_paralogistic(
  .n = 50,
  .shape = 1,
  .rate = 1,
  .scale = 1/.rate,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .shape:

  Must be strictly positive.

- .rate:

  An alternative way to specify the `.scale`

- .scale:

  Must be strictly positive.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`actuar::rparalogis()`](https://rdrr.io/pkg/actuar/man/Paralogistic.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rparalogis()`](https://rdrr.io/pkg/actuar/man/Paralogistic.html)

## See also

<https://en.wikipedia.org/wiki/Logistic_distribution>

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
[`tidy_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto.md),
[`tidy_pareto1()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto1.md),
[`tidy_t()`](https://www.spsanderson.com/TidyDensity/reference/tidy_t.md),
[`tidy_triangular()`](https://www.spsanderson.com/TidyDensity/reference/tidy_triangular.md),
[`tidy_uniform()`](https://www.spsanderson.com/TidyDensity/reference/tidy_uniform.md),
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Logistic:
[`tidy_logistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_logistic.md),
[`util_logistic_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_param_estimate.md),
[`util_logistic_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_paralogistic()
#> # A tibble: 50 × 7
#>    sim_number     x      y     dx           dy     p      q
#>    <fct>      <int>  <dbl>  <dbl>        <dbl> <dbl>  <dbl>
#>  1 1              1  4.85  -2.86  0.000944     0.829  4.85 
#>  2 1              2 46.2    0.892 0.207        0.979 46.2  
#>  3 1              3  3.72   4.64  0.0403       0.788  3.72 
#>  4 1              4  2.14   8.39  0.00809      0.682  2.14 
#>  5 1              5  0.716 12.1   0.00415      0.417  0.716
#>  6 1              6 18.5   15.9   0.0117       0.949 18.5  
#>  7 1              7  3.00  19.6   0.00436      0.750  3.00 
#>  8 1              8 67.1   23.4   0.0000000366 0.985 67.1  
#>  9 1              9  3.58  27.2   0            0.782  3.58 
#> 10 1             10  0.910 30.9   0            0.476  0.910
#> # ℹ 40 more rows
```
