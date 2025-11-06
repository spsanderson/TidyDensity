# Generate Tidy Data from Triangular Distribution

This function generates tidy data from the triangular distribution.

## Usage

``` r
tidy_triangular(
  .n = 50,
  .min = 0,
  .max = 1,
  .mode = 1/2,
  .num_sims = 1,
  .return_tibble = TRUE
)
```

## Arguments

- .n:

  The number of x values for each simulation.

- .min:

  The minimum value of the triangular distribution.

- .max:

  The maximum value of the triangular distribution.

- .mode:

  The mode (peak) value of the triangular distribution.

- .num_sims:

  The number of simulations to perform.

- .return_tibble:

  A logical value indicating whether to return the result as a tibble.
  Default is TRUE.

## Value

A tibble of randomly generated data.

## Details

The function takes parameters for the triangular distribution (minimum,
maximum, mode), the number of x values (`n`), the number of simulations
(`num_sims`), and an option to return the result as a tibble
(`return_tibble`). It performs various checks on the input parameters to
ensure validity. The result is a data frame or tibble with tidy data for
further analysis.

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
[`tidy_uniform()`](https://www.spsanderson.com/TidyDensity/reference/tidy_uniform.md),
[`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md),
[`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)

Other Triangular:
[`util_triangular_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_param_estimate.md),
[`util_triangular_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_triangular(.return_tibble = TRUE)
#> # A tibble: 50 × 7
#>    sim_number     x     y        dx      dy      p     q
#>    <fct>      <int> <dbl>     <dbl>   <dbl>  <dbl> <dbl>
#>  1 1              1 0.654 -0.270    0.00145 0.760  0.654
#>  2 1              2 0.168 -0.240    0.00376 0.0567 0.168
#>  3 1              3 0.164 -0.210    0.00880 0.0540 0.164
#>  4 1              4 0.310 -0.180    0.0187  0.192  0.310
#>  5 1              5 0.653 -0.150    0.0361  0.759  0.653
#>  6 1              6 0.529 -0.119    0.0639  0.557  0.529
#>  7 1              7 0.127 -0.0894   0.104   0.0325 0.127
#>  8 1              8 0.584 -0.0593   0.157   0.654  0.584
#>  9 1              9 0.496 -0.0293   0.224   0.493  0.496
#> 10 1             10 0.344  0.000812 0.302   0.237  0.344
#> # ℹ 40 more rows
```
