# Estimate Negative Binomial Parameters

The function will return a list output by default, and if the parameter
`.auto_gen_empirical` is set to `TRUE` then the empirical data given to
the parameter `.x` will be run through the
[`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
function and combined with the estimated negative binomial data.

Three different methods of shape parameters are supplied:

- MLE/MME

- MMUE

- MLE via [`optim`](https://rdrr.io/r/stats/optim.html) function.

## Usage

``` r
util_negative_binomial_param_estimate(
  .x,
  .size = 1,
  .auto_gen_empirical = TRUE
)
```

## Arguments

- .x:

  The vector of data to be passed to the function.

- .size:

  The size parameter, the default is 1.

- .auto_gen_empirical:

  This is a boolean value of TRUE/FALSE with default set to TRUE. This
  will automatically create the
  [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
  output for the `.x` parameter and use the
  [`tidy_combine_distributions()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combine_distributions.md).
  The user can then plot out the data using `$combined_data_tbl` from
  the function output.

## Value

A tibble/list

## Details

This function will attempt to estimate the negative binomial size and
prob parameters given some vector of values.

## See also

Other Parameter Estimation:
[`util_bernoulli_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_param_estimate.md),
[`util_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_param_estimate.md),
[`util_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md),
[`util_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_param_estimate.md),
[`util_cauchy_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_param_estimate.md),
[`util_chisquare_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_param_estimate.md),
[`util_exponential_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_param_estimate.md),
[`util_f_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_f_param_estimate.md),
[`util_gamma_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_param_estimate.md),
[`util_generalized_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_beta_param_estimate.md),
[`util_generalized_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_pareto_param_estimate.md),
[`util_geometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_param_estimate.md),
[`util_hypergeometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_param_estimate.md),
[`util_inverse_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_burr_param_estimate.md),
[`util_inverse_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_pareto_param_estimate.md),
[`util_inverse_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_param_estimate.md),
[`util_logistic_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_param_estimate.md),
[`util_lognormal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_param_estimate.md),
[`util_normal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_param_estimate.md),
[`util_paralogistic_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_param_estimate.md),
[`util_pareto1_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_param_estimate.md),
[`util_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_param_estimate.md),
[`util_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md),
[`util_t_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_t_param_estimate.md),
[`util_triangular_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_param_estimate.md),
[`util_uniform_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_param_estimate.md),
[`util_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_param_estimate.md),
[`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md),
[`util_zero_truncated_geometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_param_estimate.md),
[`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md),
[`util_zero_truncated_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_param_estimate.md)

Other Binomial:
[`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md),
[`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md),
[`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md),
[`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md),
[`util_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md),
[`util_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md),
[`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md),
[`util_zero_truncated_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_stats_tbl.md),
[`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md),
[`util_zero_truncated_negative_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
library(ggplot2)

x <- as.integer(mtcars$mpg)
output <- util_negative_binomial_param_estimate(x, .size = 1)

output$parameter_tbl
#> # A tibble: 3 × 9
#>   dist_type         samp_size   min   max  mean method   size   prob shape_ratio
#>   <chr>                 <int> <dbl> <dbl> <dbl> <chr>   <dbl>  <dbl>       <dbl>
#> 1 Negative Binomial        32    10    33  19.7 EnvSta…  32   0.0483       662  
#> 2 Negative Binomial        32    10    33  19.7 EnvSta…  32   0.0469       682. 
#> 3 Negative Binomial        32    10    33  19.7 MLE_Op…  26.9 0.577         46.5

output$combined_data_tbl |>
  tidy_combined_autoplot()


t <- rnbinom(50, 1, .1)
util_negative_binomial_param_estimate(t, .size = 1)$parameter_tbl
#> # A tibble: 3 × 9
#>   dist_type         samp_size   min   max  mean method   size   prob shape_ratio
#>   <chr>                 <int> <dbl> <dbl> <dbl> <chr>   <dbl>  <dbl>       <dbl>
#> 1 Negative Binomial        50     0    48  9.42 EnvSt… 50     0.0960       521  
#> 2 Negative Binomial        50     0    48  9.42 EnvSt… 50     0.0942       531. 
#> 3 Negative Binomial        50     0    48  9.42 MLE_O…  0.980 0.0943        10.4
```
