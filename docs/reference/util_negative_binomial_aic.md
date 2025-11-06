# Calculate Akaike Information Criterion (AIC) for Negative Binomial Distribution

This function estimates the parameters size (r) and probability (prob)
of a negative binomial distribution from the provided data and then
calculates the AIC value based on the fitted distribution.

## Usage

``` r
util_negative_binomial_aic(.x)
```

## Arguments

- .x:

  A numeric vector containing the data to be fitted to a negative
  binomial distribution.

## Value

The AIC value calculated based on the fitted negative binomial
distribution to the provided data.

## Details

This function calculates the Akaike Information Criterion (AIC) for a
negative binomial distribution fitted to the provided data.

This function fits a negative binomial distribution to the provided
data. It estimates the parameters size (r) and probability (prob) of the
negative binomial distribution from the data. Then, it calculates the
AIC value based on the fitted distribution.

Initial parameter estimates: The function uses the method of moments
estimate as a starting point for the size (r) parameter of the negative
binomial distribution, and the probability (prob) is estimated based on
the mean and variance of the data.

Optimization method: Since the parameters are directly calculated from
the data, no optimization is needed.

Goodness-of-fit: While AIC is a useful metric for model comparison, it's
recommended to also assess the goodness-of-fit of the chosen model using
visualization and other statistical tests.

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
[`util_normal_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_aic.md),
[`util_paralogistic_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_aic.md),
[`util_pareto1_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_aic.md),
[`util_pareto_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_aic.md),
[`util_poisson_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_aic.md),
[`util_t_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_t_aic.md),
[`util_triangular_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_aic.md),
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
# Example 1: Calculate AIC for a sample dataset
set.seed(123)
data <- rnbinom(n = 100, size = 5, mu = 10)
util_negative_binomial_aic(data)
#> [1] 600.7162
```
