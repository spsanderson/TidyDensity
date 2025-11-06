# Estimate Chisquare Parameters

This function will attempt to estimate the Chisquare prob parameter
given some vector of values `.x`. The function will return a list output
by default, and if the parameter `.auto_gen_empirical` is set to `TRUE`
then the empirical data given to the parameter `.x` will be run through
the
[`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
function and combined with the estimated Chisquare data.

## Usage

``` r
util_chisquare_param_estimate(.x, .auto_gen_empirical = TRUE)
```

## Arguments

- .x:

  The vector of data to be passed to the function. Must be non-negative
  integers.

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

This function will see if the given vector `.x` is a numeric vector. It
will attempt to estimate the prob parameter of a Chisquare distribution.
The function first performs tidyeval on the input data to ensure it's a
numeric vector. It then checks if there are at least two data points, as
this is a requirement for parameter estimation.

The estimation of the chi-square distribution parameters is performed
using maximum likelihood estimation (MLE) implemented with the `bbmle`
package. The negative log-likelihood function is minimized to obtain the
estimates for the degrees of freedom (`doff`) and the non-centrality
parameter (`ncp`). Initial values for the optimization are set based on
the sample variance and mean, but these can be adjusted if necessary.

If the estimation fails or encounters an error, the function returns
`NA` for both `doff` and `ncp`.

Finally, the function returns a tibble containing the following
information:

- dist_type:

  The type of distribution, which is "Chisquare" in this case.

- samp_size:

  The sample size, i.e., the number of data points in the input vector.

- min:

  The minimum value of the data points.

- max:

  The maximum value of the data points.

- mean:

  The mean of the data points.

- degrees_of_freedom:

  The estimated degrees of freedom (`doff`) for the chi-square
  distribution.

- ncp:

  The estimated non-centrality parameter (`ncp`) for the chi-square
  distribution.

Additionally, if the argument `.auto_gen_empirical` is set to `TRUE`
(which is the default behavior), the function also returns a combined
tibble containing both empirical and chi-square distribution data,
obtained by calling `tidy_empirical` and `tidy_chisquare`, respectively.

## See also

Other Parameter Estimation:
[`util_bernoulli_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_param_estimate.md),
[`util_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_param_estimate.md),
[`util_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md),
[`util_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_param_estimate.md),
[`util_cauchy_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_param_estimate.md),
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
[`util_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md),
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

Other Chisquare:
[`tidy_chisquare()`](https://www.spsanderson.com/TidyDensity/reference/tidy_chisquare.md),
[`util_chisquare_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_stats_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
library(ggplot2)

tc <- tidy_chisquare(.n = 500, .df = 6, .ncp = 1) |> pull(y)
output <- util_chisquare_param_estimate(tc)
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced

output$parameter_tbl
#> # A tibble: 1 × 7
#>   dist_type samp_size   min   max  mean   dof   ncp
#>   <chr>         <int> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 Chisquare       500 0.242  23.1  6.95  6.04 0.913

output$combined_data_tbl |>
  tidy_combined_autoplot()

```
