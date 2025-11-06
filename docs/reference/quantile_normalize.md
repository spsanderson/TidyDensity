# Perform quantile normalization on a numeric matrix/data.frame

This function will perform quantile normalization on two or more
distributions of equal length. Quantile normalization is a technique
used to make the distribution of values across different samples more
similar. It ensures that the distributions of values for each sample
have the same quantiles. This function takes a numeric matrix as input
and returns a quantile-normalized matrix.

## Usage

``` r
quantile_normalize(.data, .return_tibble = FALSE)
```

## Arguments

- .data:

  A numeric matrix where each column represents a sample.

- .return_tibble:

  A logical value that determines if the output should be a tibble.
  Default is 'FALSE'.

## Value

A numeric matrix (or tibble if .return_tibble = TRUE) that has been
quantile normalized. Each column represents a sample, and the quantile
normalization ensures that the distributions of values for each sample
have the same quantiles.

## Details

This function performs quantile normalization on a numeric matrix by
following these steps:

1.  Sort each column of the input matrix.

2.  Calculate the mean of each row across the sorted columns.

3.  Replace each column's sorted values with the row means.

4.  Unsort the columns to their original order.

## See also

[`rowMeans`](https://rdrr.io/r/base/colSums.html): Calculate row means.

[`apply`](https://rdrr.io/r/base/apply.html): Apply a function over the
margins of an array.

[`order`](https://rdrr.io/r/base/order.html): Order the elements of a
vector.

Other Utility:
[`check_duplicate_rows()`](https://www.spsanderson.com/TidyDensity/reference/check_duplicate_rows.md),
[`convert_to_ts()`](https://www.spsanderson.com/TidyDensity/reference/convert_to_ts.md),
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
# Create a sample numeric matrix
data <- matrix(rnorm(20), ncol = 4)

# Perform quantile normalization
normalized_data <- quantile_normalize(data)
normalized_data
#>             [,1]        [,2]        [,3]        [,4]
#> [1,]  1.54004626  1.54004626 -0.42145863 -0.42145863
#> [2,]  0.09638238  0.37319866  0.09638238  0.09638238
#> [3,] -1.50679669 -0.42145863  0.37319866  0.37319866
#> [4,] -0.42145863  0.09638238  1.54004626  1.54004626
#> [5,]  0.37319866 -1.50679669 -1.50679669 -1.50679669

as.data.frame(normalized_data) |>
  sapply(function(x) quantile(x, probs = seq(0, 1, 1 / 4)))
#>               V1          V2          V3          V4
#> 0%   -1.50679669 -1.50679669 -1.50679669 -1.50679669
#> 25%  -0.42145863 -0.42145863 -0.42145863 -0.42145863
#> 50%   0.09638238  0.09638238  0.09638238  0.09638238
#> 75%   0.37319866  0.37319866  0.37319866  0.37319866
#> 100%  1.54004626  1.54004626  1.54004626  1.54004626

quantile_normalize(
data.frame(rnorm(30),
           rnorm(30)),
           .return_tibble = TRUE)
#> # A tibble: 30 × 2
#>    rnorm.30. rnorm.30..1
#>        <dbl>       <dbl>
#>  1    -0.434      -0.694
#>  2     0.649      -0.445
#>  3    -1.88       -0.162
#>  4     0.683       0.263
#>  5    -1.14        0.600
#>  6    -0.298      -0.898
#>  7    -0.996      -0.996
#>  8    -1.52       -1.19 
#>  9     0.229       1.82 
#> 10    -0.898      -0.104
#> # ℹ 20 more rows
```
