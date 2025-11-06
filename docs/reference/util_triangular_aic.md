# Calculate Akaike Information Criterion (AIC) for Triangular Distribution

This function estimates the parameters of a triangular distribution
(min, max, and mode) from the provided data and calculates the AIC value
based on the fitted distribution.

## Usage

``` r
util_triangular_aic(.x)
```

## Arguments

- .x:

  A numeric vector containing the data to be fitted to a triangular
  distribution.

## Value

The AIC value calculated based on the fitted triangular distribution to
the provided data.

## Details

This function calculates the Akaike Information Criterion (AIC) for a
triangular distribution fitted to the provided data.

The function operates in several steps:

1.  **Parameter Estimation**: The function extracts the minimum,
    maximum, and mode values from the data via the
    [`TidyDensity::util_triangular_param_estimate`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_param_estimate.md)
    function. It returns these initial parameters as the starting point
    for optimization.

2.  **Negative Log-Likelihood Calculation**: A custom function
    calculates the negative log-likelihood using the
    [`EnvStats::dtri`](https://alexkowa.github.io/EnvStats/reference/Triangular.html)
    function to obtain density values for each data point. The densities
    are logged manually to simulate the behavior of a `log` parameter.

3.  **Parameter Validation**: During optimization, the function checks
    that the constraints `min <= mode <= max` are met, and returns an
    infinite loss if not.

4.  **Optimization**: The optimization process utilizes the "SANN"
    (Simulated Annealing) method to minimize the negative log-likelihood
    and find optimal parameter values.

5.  **AIC Calculation**: The Akaike Information Criterion (AIC) is
    calculated using the optimized negative log-likelihood and the total
    number of parameters (3).

## See also

Other Utility:
[`check_duplicate_rows()`](https://www.spsanderson.com/TidyDensity/reference/check_duplicate_rows.md),
[`convert_to_ts()`](https://www.spsanderson.com/TidyDensity/reference/convert_to_ts.md),
[`quantile_normalize()`](https://www.spsanderson.com/TidyDensity/reference/quantile_normalize.md),
[`tidy_mcmc_sampling()`](https://www.spsanderson.com/TidyDensity/reference/tidy_mcmc_sampling.md),
[`util_beta_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_aic.md),
[`util_binomial_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_aic.md),
[`util_cauchy_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_aic.md),
[`util_chisq_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_chisq_aic.md),
[`util_exponential_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_aic.md),
[`util_f_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_f_aic.md),
[`util_gamma_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_aic.md),
[`util_generalized_beta_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_beta_aic.md),
[`util_generalized_pareto_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_pareto_aic.md),
[`util_geometric_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_aic.md),
[`util_hypergeometric_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_aic.md),
[`util_inverse_burr_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_burr_aic.md),
[`util_inverse_pareto_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_pareto_aic.md),
[`util_inverse_weibull_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_aic.md),
[`util_logistic_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_aic.md),
[`util_lognormal_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_aic.md),
[`util_negative_binomial_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_aic.md),
[`util_normal_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_aic.md),
[`util_paralogistic_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_aic.md),
[`util_pareto1_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_aic.md),
[`util_pareto_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_aic.md),
[`util_poisson_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_aic.md),
[`util_t_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_t_aic.md),
[`util_uniform_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_aic.md),
[`util_weibull_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_aic.md),
[`util_zero_truncated_binomial_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_aic.md),
[`util_zero_truncated_geometric_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_aic.md),
[`util_zero_truncated_negative_binomial_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_aic.md),
[`util_zero_truncated_poisson_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_aic.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
# Example: Calculate AIC for a sample dataset
set.seed(123)
data <- tidy_triangular(.min = 0, .max = 1, .mode = 1/2)$y
util_triangular_aic(data)
#> [1] -14.39203
```
