# Convert Data to Time Series Format

This function converts data in a data frame or tibble into a time series
format. It is designed to work with data generated from `tidy_`
distribution functions. The function can return time series data, pivot
it into long format, or both.

## Usage

``` r
convert_to_ts(.data, .return_ts = TRUE, .pivot_longer = FALSE)
```

## Arguments

- .data:

  A data frame or tibble to be converted into a time series format.

- .return_ts:

  A logical value indicating whether to return the time series data.
  Default is TRUE.

- .pivot_longer:

  A logical value indicating whether to pivot the data into long format.
  Default is FALSE.

## Value

The function returns the processed data based on the chosen options:

- If `ret_ts` is set to TRUE, it returns time series data.

- If `pivot_longer` is set to TRUE, it returns the data in long format.

- If both options are set to FALSE, it returns the data as a tibble.

## Details

The function takes a data frame or tibble as input and processes it
based on the specified options. It performs the following actions:

1.  Checks if the input is a data frame or tibble; otherwise, it raises
    an error.

2.  Checks if the data comes from a `tidy_` distribution function;
    otherwise, it raises an error.

3.  Converts the data into a time series format, grouping it by
    "sim_number" and transforming the "y" column into a time series.

4.  Returns the result based on the chosen options:

    - If `ret_ts` is set to TRUE, it returns the time series data.

    - If `pivot_longer` is set to TRUE, it pivots the data into long
      format.

    - If both options are set to FALSE, it returns the data as a tibble.

## See also

Other Utility:
[`check_duplicate_rows()`](https://www.spsanderson.com/TidyDensity/reference/check_duplicate_rows.md),
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
# Example 1: Convert data to time series format without returning time series data
x <- tidy_normal()
result <- convert_to_ts(x, FALSE)
head(result)
#> # A tibble: 6 × 1
#>        y
#>    <dbl>
#> 1  1.30 
#> 2 -0.739
#> 3  1.58 
#> 4 -2.11 
#> 5 -2.43 
#> 6 -0.151

# Example 2: Convert data to time series format and pivot it into long format
x <- tidy_normal()
result <- convert_to_ts(x, FALSE, TRUE)
head(result)
#> # A tibble: 6 × 1
#>         y
#>     <dbl>
#> 1  1.02  
#> 2 -0.0722
#> 3  1.73  
#> 4  0.0478
#> 5 -0.713 
#> 6  0.470 

# Example 3: Convert data to time series format and return the time series data
x <- tidy_normal()
result <- convert_to_ts(x)
head(result)
#> Time Series:
#> Start = 1 
#> End = 6 
#> Frequency = 1 
#>               y
#> [1,] -0.4729851
#> [2,] -1.5943602
#> [3,] -2.0650183
#> [4,]  0.2766477
#> [5,]  0.1118095
#> [6,]  1.0223913
```
