# Tidy Randomly Generated Inverse Exponential Distribution Tibble

This function will generate `n` random points from an inverse
exponential distribution with a user provided, `.rate` or `.scale` and
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
tidy_inverse_exponential(
  .n = 50,
  .rate = 1,
  .scale = 1/.rate,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of randomly generated points you want.

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
[`actuar::rinvexp()`](https://rdrr.io/pkg/actuar/man/InverseExponential.html),
and its underlying `p`, `d`, and `q` functions. For more information
please see
[`actuar::rinvexp()`](https://rdrr.io/pkg/actuar/man/InverseExponential.html)

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
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Exponential:
[`tidy_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_exponential.md),
[`util_exponential_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_param_estimate.md),
[`util_exponential_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_stats_tbl.md)

Other Inverse Distribution:
[`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md),
[`tidy_inverse_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_gamma.md),
[`tidy_inverse_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_normal.md),
[`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md),
[`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_inverse_exponential()
#> # A tibble: 50 × 7
#>    sim_number     x      y     dx       dy      p      q
#>    <fct>      <int>  <dbl>  <dbl>    <dbl>  <dbl>  <dbl>
#>  1 1              1  4.50  -4.79  0.000525 0.801   4.50 
#>  2 1              2  3.83  -3.15  0.00789  0.770   3.83 
#>  3 1              3  1.46  -1.51  0.0476   0.504   1.46 
#>  4 1              4  7.00   0.129 0.120    0.867   7.00 
#>  5 1              5  0.399  1.77  0.136    0.0814  0.399
#>  6 1              6 26.0    3.41  0.0843   0.962  26.0  
#>  7 1              7  0.399  5.05  0.0472   0.0815  0.399
#>  8 1              8  2.30   6.69  0.0306   0.647   2.30 
#>  9 1              9  0.507  8.33  0.0165   0.139   0.507
#> 10 1             10  0.511  9.97  0.0107   0.141   0.511
#> # ℹ 40 more rows
```
