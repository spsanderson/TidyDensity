# Tidy Randomly Generated Inverse Gaussian Distribution Tibble

This function will generate `n` random points from an Inverse Gaussian
distribution with a user provided, `.mean`, `.shape`, `.dispersion`The
function returns a tibble with the simulation number column the x column
which corresponds to the n randomly generated points.

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
tidy_inverse_normal(
  .n = 50,
  .mean = 1,
  .shape = 1,
  .dispersion = 1/.shape,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

- .mean:

  Must be strictly positive.

- .shape:

  Must be strictly positive.

- .dispersion:

  An alternative way to specify the `.shape`.

- .num_sims:

  The number of randomly generated simulations you want.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

This function uses the underlying
[`actuar::rinvgauss()`](https://rdrr.io/pkg/actuar/man/InverseGaussian.html).
For more information please see
[`actuar::rinvgauss()`](https://rdrr.io/pkg/actuar/man/InverseGaussian.html)

## See also

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

Other Gaussian:
[`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md),
[`util_normal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_param_estimate.md),
[`util_normal_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_stats_tbl.md)

Other Inverse Distribution:
[`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md),
[`tidy_inverse_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_exponential.md),
[`tidy_inverse_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_gamma.md),
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md),
[`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_inverse_normal()
#> # A tibble: 50 × 7
#>    sim_number     x     y      dx      dy     p     q
#>    <fct>      <int> <dbl>   <dbl>   <dbl> <dbl> <dbl>
#>  1 1              1 3.88  -0.833  0.00136 0.977 3.88 
#>  2 1              2 0.344 -0.717  0.00407 0.212 0.344
#>  3 1              3 1.45  -0.600  0.0108  0.800 1.45 
#>  4 1              4 0.376 -0.484  0.0257  0.246 0.376
#>  5 1              5 1.15  -0.368  0.0546  0.720 1.15 
#>  6 1              6 0.382 -0.252  0.104   0.252 0.382
#>  7 1              7 2.08  -0.135  0.178   0.894 2.08 
#>  8 1              8 1.70  -0.0192 0.274   0.846 1.70 
#>  9 1              9 0.536  0.0970 0.382   0.396 0.536
#> 10 1             10 1.98   0.213  0.484   0.884 1.98 
#> # ℹ 40 more rows
```
