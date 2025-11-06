# Tidy MCMC Sampling

This function performs Markov Chain Monte Carlo (MCMC) sampling on the
input data and returns tidy data and a plot representing the results.

## Usage

``` r
tidy_mcmc_sampling(.x, .fns = "mean", .cum_fns = "cmean", .num_sims = 2000)
```

## Arguments

- .x:

  The data vector for MCMC sampling.

- .fns:

  The function(s) to apply to each MCMC sample. Default is "mean".

- .cum_fns:

  The function(s) to apply to the cumulative MCMC samples. Default is
  "cmean".

- .num_sims:

  The number of simulations. Default is 2000.

## Value

A list containing tidy data and a plot.

## Details

Perform MCMC sampling and return tidy data and a plot.

The function takes a data vector as input and performs MCMC sampling
with the specified number of simulations. It applies user-defined
functions to each MCMC sample and to the cumulative MCMC samples. The
resulting data is formatted in a tidy format, suitable for further
analysis. Additionally, a plot is generated to visualize the MCMC
samples and cumulative statistics.

## See also

Other Utility:
[`check_duplicate_rows()`](https://www.spsanderson.com/TidyDensity/reference/check_duplicate_rows.md),
[`convert_to_ts()`](https://www.spsanderson.com/TidyDensity/reference/convert_to_ts.md),
[`quantile_normalize()`](https://www.spsanderson.com/TidyDensity/reference/quantile_normalize.md),
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
# Generate MCMC samples
set.seed(123)
data <- rnorm(100)
result <- tidy_mcmc_sampling(data, "median", "cmedian", 500)
#> Warning: Setting '.num_sims' to less than 2000 means that results can be potentially
#> unstable. Consider setting to 2000 or more.
result
#> $mcmc_data
#> # A tibble: 1,000 × 3
#>    sim_number name                 value
#>    <fct>      <fct>                <dbl>
#>  1 1          .sample_median    -0.0285 
#>  2 1          .cum_stat_cmedian -0.0285 
#>  3 2          .sample_median     0.239  
#>  4 2          .cum_stat_cmedian  0.105  
#>  5 3          .sample_median     0.00576
#>  6 3          .cum_stat_cmedian  0.00576
#>  7 4          .sample_median    -0.0357 
#>  8 4          .cum_stat_cmedian -0.0114 
#>  9 5          .sample_median    -0.111  
#> 10 5          .cum_stat_cmedian -0.0285 
#> # ℹ 990 more rows
#> 
#> $plt

#> 
```
