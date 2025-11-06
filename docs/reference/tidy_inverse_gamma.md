# Tidy Randomly Generated Inverse Gamma Distribution Tibble

This function will generate `n` random points from an inverse gamma
distribution with a user provided, `.shape`, `.rate`, `.scale`, and
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
tidy_inverse_gamma(
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
[`actuar::rinvgamma()`](https://rdrr.io/pkg/actuar/man/InverseGamma.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rinvgamma()`](https://rdrr.io/pkg/actuar/man/InverseGamma.html)

## See also

<https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html>

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
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Gamma:
[`tidy_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_gamma.md),
[`util_gamma_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_param_estimate.md),
[`util_gamma_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_stats_tbl.md)

Other Inverse Distribution:
[`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md),
[`tidy_inverse_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_exponential.md),
[`tidy_inverse_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_normal.md),
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md),
[`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_inverse_gamma()
#> # A tibble: 50 × 7
#>    sim_number     x      y     dx       dy     p      q
#>    <fct>      <int>  <dbl>  <dbl>    <dbl> <dbl>  <dbl>
#>  1 1              1  0.902  -1.31 1.13e- 2 0.330  0.902
#>  2 1              2  1.50   10.8  5.04e- 4 0.514  1.50 
#>  3 1              3  8.34   23.0  2.62e-13 0.887  8.34 
#>  4 1              4  8.63   35.2  0        0.891  8.63 
#>  5 1              5  0.807  47.3  0        0.290  0.807
#>  6 1              6  1.70   59.5  1.19e-18 0.556  1.70 
#>  7 1              7  4.44   71.6  4.39e-19 0.798  4.44 
#>  8 1              8 28.9    83.8  0        0.966 28.9  
#>  9 1              9  0.641  96.0  7.70e-19 0.210  0.641
#> 10 1             10  2.45  108.   0        0.665  2.45 
#> # ℹ 40 more rows
```
