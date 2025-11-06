# Calculate Akaike Information Criterion (AIC) for Zero-Truncated Negative Binomial Distribution

This function estimates the parameters (`size` and `prob`) of a ZTNB
distribution from the provided data using maximum likelihood estimation
(via the [`optim()`](https://rdrr.io/r/stats/optim.html) function), and
then calculates the AIC value based on the fitted distribution.

## Usage

``` r
util_rztnbinom_aic(.x)
```

## Arguments

- .x:

  A numeric vector containing the data (non-zero counts) to be fitted to
  a ZTNB distribution.

## Value

The AIC value calculated based on the fitted ZTNB distribution to the
provided data.

## Details

This function calculates the Akaike Information Criterion (AIC) for a
zero-truncated negative binomial (ZTNB) distribution fitted to the
provided data.

**Initial parameter estimates:** The choice of initial values for `size`
and `prob` can impact the convergence of the optimization. Consider
using prior knowledge or method of moments estimates to obtain
reasonable starting values.

**Optimization method:** The default optimization method used is
"Nelder-Mead". You might explore other optimization methods available in
[`optim()`](https://rdrr.io/r/stats/optim.html) for potentially better
performance or different constraint requirements.

**Data requirements:** The input data `.x` should consist of non-zero
counts, as the ZTNB distribution does not include zero values.

**Goodness-of-fit:** While AIC is a useful metric for model comparison,
it's recommended to also assess the goodness-of-fit of the chosen ZTNB
model using visualization (e.g., probability plots, histograms) and
other statistical tests (e.g., chi-square goodness-of-fit test) to
ensure it adequately describes the data.

## See also

Other Utility:
[`check_duplicate_rows`](https://www.spsanderson.com/TidyDensity/reference/check_duplicate_rows.md)`()`,
[`convert_to_ts`](https://www.spsanderson.com/TidyDensity/reference/convert_to_ts.md)`()`,
[`quantile_normalize`](https://www.spsanderson.com/TidyDensity/reference/quantile_normalize.md)`()`,
[`tidy_mcmc_sampling`](https://www.spsanderson.com/TidyDensity/reference/tidy_mcmc_sampling.md)`()`,
[`util_beta_aic`](https://www.spsanderson.com/TidyDensity/reference/util_beta_aic.md)`()`,
[`util_binomial_aic`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_aic.md)`()`,
[`util_cauchy_aic`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_aic.md)`()`,
[`util_chisq_aic`](https://www.spsanderson.com/TidyDensity/reference/util_chisq_aic.md)`()`,
[`util_exponential_aic`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_aic.md)`()`,
[`util_f_aic`](https://www.spsanderson.com/TidyDensity/reference/util_f_aic.md)`()`,
[`util_gamma_aic`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_aic.md)`()`,
[`util_geometric_aic`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_aic.md)`()`,
[`util_hypergeometric_aic`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_aic.md)`()`,
[`util_logistic_aic`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_aic.md)`()`,
[`util_lognormal_aic`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_aic.md)`()`,
[`util_negative_binomial_aic`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_aic.md)`()`,
[`util_normal_aic`](https://www.spsanderson.com/TidyDensity/reference/util_normal_aic.md)`()`,
[`util_pareto_aic`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_aic.md)`()`,
[`util_poisson_aic`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_aic.md)`()`,
[`util_uniform_aic`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_aic.md)`()`,
[`util_weibull_aic`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_aic.md)`()`,
[`util_zero_truncated_poisson_aic`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_aic.md)`()`

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(actuar)
#> 
#> Attaching package: 'actuar'
#> The following objects are masked from 'package:stats':
#> 
#>     sd, var
#> The following object is masked from 'package:grDevices':
#> 
#>     cm

# Example data
set.seed(123)
x <- rztnbinom(30, size = 2, prob = 0.4)

# Calculate AIC
util_rztnbinom_aic(x)
#> [1] 140.8286
```
