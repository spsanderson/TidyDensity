# Changelog

## TidyDensity (development version)

### Breaking Changes

None

### New Features

None

### Minor Fixes and Improvements

None

## TidyDensity 1.5.2

CRAN release: 2025-09-06

### Breaking Changes

1.  Fix [\#521](https://github.com/spsanderson/TidyDensity/issues/521) -
    Fundamentally redesign of
    [`quantile_normalize()`](https://www.spsanderson.com/TidyDensity/reference/quantile_normalize.md)
    to use a more efficient algorithm. This has resulted in a breaking
    change as the output is now slightly different. The new algorithm is
    also faster and more memory efficient.

### New Features

1.  Fix [\#510](https://github.com/spsanderson/TidyDensity/issues/510) -
    Add parameter to
    [`tidy_mixture_density()`](https://www.spsanderson.com/TidyDensity/reference/tidy_mixture_density.md)
    to allow for different types of combinations, add, subtract, stack,
    multiply and divide.

### Minor Fixes and Improvements

None

## TidyDensity 1.5.1

CRAN release: 2025-07-23

### Breaking Changes

None

### New Features

None

### Minor Fixes and Improvements

1.  Fix [\#515](https://github.com/spsanderson/TidyDensity/issues/515) -
    Fix documentation issue with `rinvgauss`
2.  Fix [\#514](https://github.com/spsanderson/TidyDensity/issues/514) -
    Fix documentation issue with
    [`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md)

## TidyDensity 1.5.0

CRAN release: 2024-05-28

### Breaking Changes

None

### New Features

1.  Fix [\#468](https://github.com/spsanderson/TidyDensity/issues/468) -
    Add function
    [`util_negative_binomial_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_aic.md)
    to calculate the AIC for the negative binomial distribution.
2.  Fix [\#470](https://github.com/spsanderson/TidyDensity/issues/470) -
    Add function
    [`util_zero_truncated_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_param_estimate.md)
    to estimate the parameters of the zero-truncated negative binomial
    distribution. Add function
    [`util_zero_truncated_negative_binomial_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_aic.md)
    to calculate the AIC for the zero-truncated negative binomial
    distribution. Add function
    [`util_zero_truncated_negative_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_negative_binomial_stats_tbl.md)
    to create a summary table of the zero-truncated negative binomial
    distribution.
3.  Fix [\#471](https://github.com/spsanderson/TidyDensity/issues/471) -
    Add function
    [`util_zero_truncated_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_param_estimate.md)
    to estimate the parameters of the zero-truncated Poisson
    distribution. Add function
    [`util_zero_truncated_poisson_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_aic.md)
    to calculate the AIC for the zero-truncated Poisson distribution.
    Add function
    [`util_zero_truncated_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_poisson_stats_tbl.md)
    to create a summary table of the zero-truncated Poisson
    distribution.
4.  Fix [\#472](https://github.com/spsanderson/TidyDensity/issues/472) -
    Add function
    [`util_f_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_f_param_estimate.md)
    and
    [`util_f_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_f_aic.md)
    to estimate the parameters and calculate the AIC for the F
    distribution.
5.  Fix [\#482](https://github.com/spsanderson/TidyDensity/issues/482) -
    Add function
    [`util_zero_truncated_geometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_param_estimate.md)
    to estimate the parameters of the zero-truncated geometric
    distribution. Add function
    [`util_zero_truncated_geometric_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_aic.md)
    to calculate the AIC for the zero-truncated geometric distribution.
    Add function
    [`util_zero_truncated_geometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_geometric_stats_tbl.md)
    to create a summary table of the zero-truncated geometric
    distribution.
6.  Fix [\#481](https://github.com/spsanderson/TidyDensity/issues/481) -
    Add function
    [`util_triangular_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_aic.md)
    to calculate the AIC for the triangular distribution.
7.  Fix [\#480](https://github.com/spsanderson/TidyDensity/issues/480) -
    Add function
    [`util_t_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_t_param_estimate.md)
    to estimate the parameters of the T distribution. Add function
    [`util_t_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_t_aic.md)
    to calculate the AIC for the T distribution.
8.  Fix [\#479](https://github.com/spsanderson/TidyDensity/issues/479) -
    Add function
    [`util_pareto1_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_param_estimate.md)
    to estimate the parameters of the Pareto Type I distribution. Add
    function
    [`util_pareto1_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_aic.md)
    to calculate the AIC for the Pareto Type I distribution. Add
    function
    [`util_pareto1_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto1_stats_tbl.md)
    to create a summary table of the Pareto Type I distribution.
9.  Fix [\#478](https://github.com/spsanderson/TidyDensity/issues/478) -
    Add function
    [`util_paralogistic_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_param_estimate.md)
    to estimate the parameters of the paralogistic distribution. Add
    function
    [`util_paralogistic_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_aic.md)
    to calculate the AIC for the paralogistic distribution. Add fnction
    [`util_paralogistic_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_paralogistic_stats_tbl.md)
    to create a summary table of the paralogistic distribution.
10. Fix [\#477](https://github.com/spsanderson/TidyDensity/issues/477) -
    Add function
    [`util_inverse_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_param_estimate.md)
    to estimate the parameters of the Inverse Weibull distribution. Add
    function
    [`util_inverse_weibull_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_aic.md)
    to calculate the AIC for the Inverse Weibull distribution. Add
    function
    [`util_inverse_weibull_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_weibull_stats_tbl.md)
    to create a summary table of the Inverse Weibull distribution.
11. Fix [\#476](https://github.com/spsanderson/TidyDensity/issues/476) -
    Add function
    [`util_inverse_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_pareto_param_estimate.md)
    to estimate the parameters of the Inverse Pareto distribution. Add
    function
    [`util_inverse_pareto_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_pareto_aic.md)
    to calculate the AIC for the Inverse Pareto distribution. Add
    Function
    [`util_inverse_pareto_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_pareto_stats_tbl.md)
    to create a summary table of the Inverse Pareto distribution.
12. Fix [\#475](https://github.com/spsanderson/TidyDensity/issues/475) -
    Add function
    [`util_inverse_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_burr_param_estimate.md)
    to estimate the parameters of the Inverse Gamma distribution. Add
    function
    [`util_inverse_burr_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_burr_aic.md)
    to calculate the AIC for the Inverse Gamma distribution. Add
    function
    [`util_inverse_burr_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_inverse_burr_stats_tbl.md)
    to create a summary table of the Inverse Gamma distribution.
13. Fix [\#474](https://github.com/spsanderson/TidyDensity/issues/474) -
    Add function
    [`util_generalized_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_pareto_param_estimate.md)
    to estimate the parameters of the Generalized Pareto distribution.
    Add function
    [`util_generalized_pareto_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_pareto_aic.md)
    to calculate the AIC for the Generalized Pareto distribution. Add
    function
    [`util_generalized_pareto_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_pareto_stats_tbl.md)
    to create a summary table of the Generalized Pareto distribution.
14. Fix [\#473](https://github.com/spsanderson/TidyDensity/issues/473) -
    Add function
    [`util_generalized_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_beta_param_estimate.md)
    to estimate the parameters of the Generalized Gamma distribution.
    Add function
    [`util_generalized_beta_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_beta_aic.md)
    to calculate the AIC for the Generalized Gamma distribution. Add
    function
    [`util_generalized_beta_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_generalized_beta_stats_tbl.md)
    to create a summary table of the Generalized Gamma distribution.
15. Fix [\#469](https://github.com/spsanderson/TidyDensity/issues/469) -
    Add function
    [`util_zero_truncated_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_stats_tbl.md)
    to create a summary table of the Zero Truncated binomial
    distribution. Add function
    [`util_zero_truncated_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_param_estimate.md)
    to estimate the parameters of the Zero Truncated binomial
    distribution. Add function
    [`util_zero_truncated_binomial_aic()`](https://www.spsanderson.com/TidyDensity/reference/util_zero_truncated_binomial_aic.md)
    to calculate the AIC for the Zero Truncated binomial distribution.

### Minor Improvements and Fixes

1.  Fix [\#468](https://github.com/spsanderson/TidyDensity/issues/468) -
    Update
    [`util_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md)
    to add the use of [`optim()`](https://rdrr.io/r/stats/optim.html)
    for parameter estimation.
2.  Fix [\#465](https://github.com/spsanderson/TidyDensity/issues/465) -
    Add names to columns when `.return_tibble = TRUE` for
    [`quantile_normalize()`](https://www.spsanderson.com/TidyDensity/reference/quantile_normalize.md)

## TidyDensity 1.4.0

CRAN release: 2024-04-26

### Breaking Changes

None

### New Features

1.  Fix [\#405](https://github.com/spsanderson/TidyDensity/issues/405) -
    Add function
    [`quantile_normalize()`](https://www.spsanderson.com/TidyDensity/reference/quantile_normalize.md)
    to normalize data using quantiles.
2.  Fix [\#409](https://github.com/spsanderson/TidyDensity/issues/409) -
    Add function
    [`check_duplicate_rows()`](https://www.spsanderson.com/TidyDensity/reference/check_duplicate_rows.md)
    to check for duplicate rows in a data frame.
3.  Fix [\#414](https://github.com/spsanderson/TidyDensity/issues/414) -
    Add function
    [`util_chisquare_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_param_estimate.md)
    to estimate the parameters of the chi-square distribution.
4.  Fix [\#417](https://github.com/spsanderson/TidyDensity/issues/417) -
    Add function
    [`tidy_mcmc_sampling()`](https://www.spsanderson.com/TidyDensity/reference/tidy_mcmc_sampling.md)
    to sample from a distribution using MCMC. This outputs the function
    sampled data and a diagnostic plot.
5.  Fix [\#421](https://github.com/spsanderson/TidyDensity/issues/421) -
    Add functions `util_dist_aic()` functions to calculate the AIC for a
    distribution.

### Minor Fixes and Improvements

1.  Fix [\#401](https://github.com/spsanderson/TidyDensity/issues/401) -
    Update
    [`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)
    to respect the `.return_tibble` parameter
2.  Fix [\#406](https://github.com/spsanderson/TidyDensity/issues/406) -
    Update
    [`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)
    to exclude the `.return_tibble` parameter from returning in the
    distribution parameters.
3.  Fix [\#413](https://github.com/spsanderson/TidyDensity/issues/413) -
    Update documentation to include `mcmc` where applicable.
4.  Fix [\#240](https://github.com/spsanderson/TidyDensity/issues/240) -
    Update
    [`tidy_distribution_comparison()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_comparison.md)
    to include the new AIC calculations from the dedicated
    `util_dist_aic()` functions.

## TidyDensity 1.3.0

CRAN release: 2024-01-09

### Breaking Changes

1.  Fix [\#350](https://github.com/spsanderson/TidyDensity/issues/350) -
    This has caused the function
    [`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)
    to be modified in that it now requires the user to pass the
    parameter of `.return_tibbl` with either TRUE or FALSE as it was
    introduced into the `tidy_` distribution functions which now use
    `data.table` under the hood to generate data.
2.  Fix [\#371](https://github.com/spsanderson/TidyDensity/issues/371) -
    Modify code to use the native `|>` pipe instead of the `%>%` which
    has caused a need to update the minimum R version to 4.1.0

### New Features

1.  Fix [\#360](https://github.com/spsanderson/TidyDensity/issues/360) -
    Add function
    [`tidy_triangular()`](https://www.spsanderson.com/TidyDensity/reference/tidy_triangular.md)
2.  Fix [\#361](https://github.com/spsanderson/TidyDensity/issues/361) -
    Add function
    [`util_triangular_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_param_estimate.md)
3.  Fix [\#362](https://github.com/spsanderson/TidyDensity/issues/362) -
    Add function
    [`util_triangular_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_triangular_stats_tbl.md)
4.  Fix [\#364](https://github.com/spsanderson/TidyDensity/issues/364) -
    Add function
    [`triangle_plot()`](https://www.spsanderson.com/TidyDensity/reference/triangle_plot.md)
5.  Fix [\#363](https://github.com/spsanderson/TidyDensity/issues/363) -
    Add triangular to
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)

### Minor Fixes and Improvements

1.  Fix [\#372](https://github.com/spsanderson/TidyDensity/issues/372)
    and [\#373](https://github.com/spsanderson/TidyDensity/issues/373) -
    Update
    [`cvar()`](https://www.spsanderson.com/TidyDensity/reference/cvar.md)
    and
    [`csd()`](https://www.spsanderson.com/TidyDensity/reference/csd.md)
    to a vectorized approach from [@kokbent](https://github.com/kokbent)
    which speeds these up by over 100x
2.  Fix [\#350](https://github.com/spsanderson/TidyDensity/issues/350) -
    Update all `tidy_` distribution functions to generate data using
    `data.table` this in many instances has resulted in a speed up of
    30% or more.
3.  Fix [\#379](https://github.com/spsanderson/TidyDensity/issues/379) -
    Replace the use of
    [`dplyr::cur_data()`](https://dplyr.tidyverse.org/reference/deprec-context.html)
    as it was deprecated in dplyr in favor of using
    [`dplyr::pick()`](https://dplyr.tidyverse.org/reference/pick.html)
4.  Fix [\#381](https://github.com/spsanderson/TidyDensity/issues/381) -
    Add
    [`tidy_triangular()`](https://www.spsanderson.com/TidyDensity/reference/tidy_triangular.md)
    to all autoplot functions.
5.  Fix [\#385](https://github.com/spsanderson/TidyDensity/issues/385) -
    For
    [`tidy_multi_dist_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_dist_autoplot.md)
    the `.plot_type = "quantile"` did not work.
6.  Fix [\#383](https://github.com/spsanderson/TidyDensity/issues/383) -
    Update all autoplot functions to use linewidth instead of size.
7.  Fix [\#375](https://github.com/spsanderson/TidyDensity/issues/375) -
    Update
    [`cskewness()`](https://www.spsanderson.com/TidyDensity/reference/cskewness.md)
    to take advantage of vectorization with a speedup of 124x faster.
8.  Fix [\#393](https://github.com/spsanderson/TidyDensity/issues/393) -
    Update
    [`ckurtosis()`](https://www.spsanderson.com/TidyDensity/reference/ckurtosis.md)
    with vectorization to improve speed by 121x per benchmark testing.

## TidyDensity 1.2.6

CRAN release: 2023-10-30

### Breaking Changes

None

### New Features

1.  Fix [\#351](https://github.com/spsanderson/TidyDensity/issues/351) -
    Add function
    [`convert_to_ts()`](https://www.spsanderson.com/TidyDensity/reference/convert_to_ts.md)
    which will convert a `tidy_` distribution into a time series in
    either `ts` format or `tibble` you can also have it set to wide or
    long by using `.pivot_longer` set to TRUE and `.ret_ts` set to FALSE
2.  Fix [\#348](https://github.com/spsanderson/TidyDensity/issues/348) -
    Add function
    [`util_burr_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_stats_tbl.md)

### Minor Fixes and Improvements

1.  Fix [\#344](https://github.com/spsanderson/TidyDensity/issues/344) -
    Fix
    [`util_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_param_estimate.md)

## TidyDensity 1.2.5

CRAN release: 2023-05-19

### Breaking Changes

None

### New Features

1.  Fix [\#333](https://github.com/spsanderson/TidyDensity/issues/333) -
    Add function
    [`util_burr_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_burr_param_estimate.md)

### Minor Fixes and Improvements

1.  Fix [\#335](https://github.com/spsanderson/TidyDensity/issues/335) -
    Update function
    [`tidy_distribution_comparison()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_comparison.md)
    to add a parameter of `.round_to_place` which allows a user to round
    the parameter estimates passed to their corresponding distribution
    parameters.
2.  Fix [\#336](https://github.com/spsanderson/TidyDensity/issues/336) -
    Update logo name to logo.png

## TidyDensity 1.2.4

CRAN release: 2022-11-16

### Breaking Changes

None

### New Features

1.  Fix [\#302](https://github.com/spsanderson/TidyDensity/issues/302) -
    Add function
    [`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md)
2.  Fix [\#304](https://github.com/spsanderson/TidyDensity/issues/304) -
    Add function
    [`util_bernoulli_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_param_estimate.md)
3.  Fix [\#305](https://github.com/spsanderson/TidyDensity/issues/305) -
    Add function
    [`util_bernoulli_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_bernoulli_stats_tbl.md)

### Minor Fixes and Improvements

1.  Fix [\#291](https://github.com/spsanderson/TidyDensity/issues/291) -
    Update
    [`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)
    to fix `tibble` output so it no longer ignores passed arguments and
    fix `data.table` to directly pass … arguments.
2.  Fix [\#295](https://github.com/spsanderson/TidyDensity/issues/295) -
    Drop warning message of not passing arguments when .use_data_table =
    TRUE
3.  Fix [\#303](https://github.com/spsanderson/TidyDensity/issues/303) -
    Add
    [`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md)
    to autoplot.
4.  Fix [\#299](https://github.com/spsanderson/TidyDensity/issues/299) -
    Update
    [`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)
5.  Fix [\#309](https://github.com/spsanderson/TidyDensity/issues/309) -
    Add function for internal use to drop dependency of stringr.
    Function is
    [`dist_type_extractor()`](https://www.spsanderson.com/TidyDensity/reference/dist_type_extractor.md)
    which is used for several functions in the library.
6.  Fix [\#310](https://github.com/spsanderson/TidyDensity/issues/310) -
    Update combine-multi-dist to use
    [`dist_type_extractor()`](https://www.spsanderson.com/TidyDensity/reference/dist_type_extractor.md)
7.  Fix [\#311](https://github.com/spsanderson/TidyDensity/issues/311) -
    Update all `util_dist_stats_tbl()` functions to use
    [`dist_type_extractor()`](https://www.spsanderson.com/TidyDensity/reference/dist_type_extractor.md)
8.  Fix [\#316](https://github.com/spsanderson/TidyDensity/issues/316) -
    Update all `autoplot` functions for
    [`tidy_bernoulli()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bernoulli.md)
9.  Fix [\#312](https://github.com/spsanderson/TidyDensity/issues/312) -
    Update random walk function to use
    [`dist_type_extractor()`](https://www.spsanderson.com/TidyDensity/reference/dist_type_extractor.md)
10. Fix [\#314](https://github.com/spsanderson/TidyDensity/issues/314) -
    Update
    [`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)
    to use
    [`dist_type_extractor()`](https://www.spsanderson.com/TidyDensity/reference/dist_type_extractor.md)
11. Fix [\#301](https://github.com/spsanderson/TidyDensity/issues/301) -
    Fix `p` and `q` calculations.

## TidyDensity 1.2.3

CRAN release: 2022-10-04

### Breaking Changes

None

### New Features

1.  Fix [\#237](https://github.com/spsanderson/TidyDensity/issues/237) -
    Add function
    [`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md)
2.  Fix [\#238](https://github.com/spsanderson/TidyDensity/issues/238) -
    Add functions
    [`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md)
    and
    [`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md)
3.  Fix [\#239](https://github.com/spsanderson/TidyDensity/issues/239) -
    Add functions
    [`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md)
    and
    [`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md)
4.  Fix [\#256](https://github.com/spsanderson/TidyDensity/issues/256)
    [\#257](https://github.com/spsanderson/TidyDensity/issues/257)
    [\#258](https://github.com/spsanderson/TidyDensity/issues/258)
    [\#260](https://github.com/spsanderson/TidyDensity/issues/260)
    [\#265](https://github.com/spsanderson/TidyDensity/issues/265)
    [\#266](https://github.com/spsanderson/TidyDensity/issues/266)
    [\#267](https://github.com/spsanderson/TidyDensity/issues/267)
    [\#268](https://github.com/spsanderson/TidyDensity/issues/268) - Add
    functions
    [`cmean()`](https://www.spsanderson.com/TidyDensity/reference/cmean.md)
    [`chmean()`](https://www.spsanderson.com/TidyDensity/reference/chmean.md)
    [`cgmean()`](https://www.spsanderson.com/TidyDensity/reference/cgmean.md)
    [`cmedian()`](https://www.spsanderson.com/TidyDensity/reference/cmedian.md)
    [`csd()`](https://www.spsanderson.com/TidyDensity/reference/csd.md)
    [`ckurtosis()`](https://www.spsanderson.com/TidyDensity/reference/ckurtosis.md)
    [`cskewness()`](https://www.spsanderson.com/TidyDensity/reference/cskewness.md)
    [`cvar()`](https://www.spsanderson.com/TidyDensity/reference/cvar.md)
5.  Fix [\#250](https://github.com/spsanderson/TidyDensity/issues/250) -
    Add function
    [`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md)
6.  Fix [\#276](https://github.com/spsanderson/TidyDensity/issues/276) -
    Add function
    [`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)
    Fix [\#281](https://github.com/spsanderson/TidyDensity/issues/281)
    adds the parameter of `.user_data_table` which is set to `FALSE` by
    default. If set to `TRUE` will use `[data.table::melt()]` for the
    underlying work speeding up the output from a benchmark test of
    regular `tibble` at 72 seconds to `data.table.` at 15 seconds.

### Minor Fixes and Improvements

1.  Fix [\#242](https://github.com/spsanderson/TidyDensity/issues/242) -
    Fix `prop` check in
    [`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
2.  Fix [\#247](https://github.com/spsanderson/TidyDensity/issues/247) -
    Add attributes to
    [`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md)
    output.

## TidyDensity 1.2.2

CRAN release: 2022-08-10

### Breaking Changes

None

### New Features

1.  Fix [\#229](https://github.com/spsanderson/TidyDensity/issues/229) -
    Add
    [`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md)
    to list of tested distributions. Add `AIC` from a linear model for
    metric, and add
    [`stats::ks.test()`](https://rdrr.io/r/stats/ks.test.html) as a
    metric.

### Minor Fixes and Improvements

1.  Fix [\#228](https://github.com/spsanderson/TidyDensity/issues/228) -
    Add ks.test to distribution comparison.
2.  Fix [\#227](https://github.com/spsanderson/TidyDensity/issues/227) -
    Add AIC and normal to distribution comparison.

## TidyDensity 1.2.1

CRAN release: 2022-07-19

### Breaking Changes

None

### New Features

None

### Minor Fixes and Improvments

1.  Fix [\#210](https://github.com/spsanderson/TidyDensity/issues/210) -
    Fix param_grid order on internal which affected attributes and thus
    the display of the order of the parameters.
2.  Fix [\#211](https://github.com/spsanderson/TidyDensity/issues/211) -
    Add High and Low CI to
    [`tidy_distribution_summary_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_summary_tbl.md)
3.  Fix [\#213](https://github.com/spsanderson/TidyDensity/issues/213) -
    Use
    [`purrr::compact()`](https://purrr.tidyverse.org/reference/keep.html)
    on the list of distributions passed in order to prevent the issue
    occurring in
    [\#212](https://github.com/spsanderson/TidyDensity/issues/212)
4.  Fix [\#212](https://github.com/spsanderson/TidyDensity/issues/212) -
    Make
    [`tidy_distribution_comparison()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_comparison.md)
    more robust in terms of handling bad or erroneous data.
5.  Fix [\#216](https://github.com/spsanderson/TidyDensity/issues/216) -
    Add an attribute of “tibble_type” to
    [`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)
    which helps it to work with other functions like
    [`tidy_random_walk()`](https://www.spsanderson.com/TidyDensity/reference/tidy_random_walk.md)

## TidyDensity 1.2.0

CRAN release: 2022-06-08

### Breaking Changes

None

### New Features

1.  Fix [\#181](https://github.com/spsanderson/TidyDensity/issues/181) -
    Add functions
    [`color_blind()`](https://www.spsanderson.com/TidyDensity/reference/color_blind.md)
    [`td_scale_fill_colorblind()`](https://www.spsanderson.com/TidyDensity/reference/td_scale_fill_colorblind.md)
    and
    [`td_scale_color_colorblind()`](https://www.spsanderson.com/TidyDensity/reference/td_scale_color_colorblind.md)
2.  Fix [\#187](https://github.com/spsanderson/TidyDensity/issues/187) -
    Add functions
    [`ci_lo()`](https://www.spsanderson.com/TidyDensity/reference/ci_lo.md)
    and
    [`ci_hi()`](https://www.spsanderson.com/TidyDensity/reference/ci_hi.md)
3.  Fix [\#189](https://github.com/spsanderson/TidyDensity/issues/189) -
    Add function
    [`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
4.  Fix [\#190](https://github.com/spsanderson/TidyDensity/issues/190) -
    Add function
    [`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md)
5.  Fix [\#202](https://github.com/spsanderson/TidyDensity/issues/202) -
    Add function
    [`tidy_distribution_comparison()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_comparison.md)

### Minor Fixes and Improvements

1.  Fix [\#176](https://github.com/spsanderson/TidyDensity/issues/176) -
    Update `_autoplot` functions to include cumulative mean MCMC chart
    by taking advantage of the `.num_sims` parameter of `tidy_`
    distribution functions.
2.  Fix [\#184](https://github.com/spsanderson/TidyDensity/issues/184) -
    Update
    [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
    to add a parameter of `.distribution_type`
3.  Fix [\#183](https://github.com/spsanderson/TidyDensity/issues/183) -
    [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
    is now again plotted by `_autoplot` functions.
4.  Fix [\#188](https://github.com/spsanderson/TidyDensity/issues/188) -
    Add the `.num_sims` parameter to
    [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
5.  Fix [\#196](https://github.com/spsanderson/TidyDensity/issues/196) -
    Add
    [`ci_lo()`](https://www.spsanderson.com/TidyDensity/reference/ci_lo.md)
    and
    [`ci_hi()`](https://www.spsanderson.com/TidyDensity/reference/ci_hi.md)
    to all stats tbl functions.
6.  Fix [\#201](https://github.com/spsanderson/TidyDensity/issues/201) -
    Correct attribute of `distribution_family_type` to `discrete` for
    [`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md)

## TidyDensity 1.1.0

CRAN release: 2022-05-06

### Breaking Changes

None

### New Features

1.  Fix [\#119](https://github.com/spsanderson/TidyDensity/issues/119) -
    Add function
    [`tidy_four_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_four_autoplot.md) -
    This will auto plot the density, qq, quantile and probability plots
    to a single graph.
2.  Fix [\#125](https://github.com/spsanderson/TidyDensity/issues/125) -
    Add function
    [`util_weibull_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_param_estimate.md)
3.  Fix [\#126](https://github.com/spsanderson/TidyDensity/issues/126) -
    Add function
    [`util_uniform_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_param_estimate.md)
4.  Fix [\#127](https://github.com/spsanderson/TidyDensity/issues/127) -
    Add function
    [`util_cauchy_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_param_estimate.md)
5.  Fix [\#130](https://github.com/spsanderson/TidyDensity/issues/130) -
    Add function
    [`tidy_t()`](https://www.spsanderson.com/TidyDensity/reference/tidy_t.md) -
    Also add to plotting functions.
6.  Fix [\#151](https://github.com/spsanderson/TidyDensity/issues/151) -
    Add function
    [`tidy_mixture_density()`](https://www.spsanderson.com/TidyDensity/reference/tidy_mixture_density.md)
7.  Fix [\#150](https://github.com/spsanderson/TidyDensity/issues/150) -
    Add function
    [`util_geometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_stats_tbl.md)
8.  Fix [\#149](https://github.com/spsanderson/TidyDensity/issues/149) -
    Add function
    [`util_hypergeometric_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_stats_tbl.md)
9.  Fix [\#148](https://github.com/spsanderson/TidyDensity/issues/148) -
    Add function
    [`util_logistic_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_stats_tbl.md)
10. Fix [\#147](https://github.com/spsanderson/TidyDensity/issues/147) -
    Add function
    [`util_lognormal_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_stats_tbl.md)
11. Fix [\#146](https://github.com/spsanderson/TidyDensity/issues/146) -
    Add function
    [`util_negative_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_stats_tbl.md)
12. Fix [\#145](https://github.com/spsanderson/TidyDensity/issues/145) -
    Add function
    [`util_normal_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_stats_tbl.md)
13. Fix [\#144](https://github.com/spsanderson/TidyDensity/issues/144) -
    Add function
    [`util_pareto_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_stats_tbl.md)
14. Fix [\#143](https://github.com/spsanderson/TidyDensity/issues/143) -
    Add function
    [`util_poisson_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_stats_tbl.md)
15. Fix [\#142](https://github.com/spsanderson/TidyDensity/issues/142) -
    Add function
    [`util_uniform_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_uniform_stats_tbl.md)
16. Fix [\#141](https://github.com/spsanderson/TidyDensity/issues/141) -
    Add function
    [`util_cauchy_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_cauchy_stats_tbl.md)
17. Fix [\#140](https://github.com/spsanderson/TidyDensity/issues/140) -
    Add function
    [`util_t_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_t_stats_tbl.md)
18. Fix [\#139](https://github.com/spsanderson/TidyDensity/issues/139) -
    Add function
    [`util_f_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_f_stats_tbl.md)
19. Fix [\#138](https://github.com/spsanderson/TidyDensity/issues/138) -
    Add function
    [`util_chisquare_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_chisquare_stats_tbl.md)
20. Fix [\#137](https://github.com/spsanderson/TidyDensity/issues/137) -
    Add function
    [`util_weibull_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_weibull_stats_tbl.md)
21. Fix [\#136](https://github.com/spsanderson/TidyDensity/issues/136) -
    Add function
    [`util_gamma_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_stats_tbl.md)
22. Fix [\#135](https://github.com/spsanderson/TidyDensity/issues/135) -
    Add function
    [`util_exponential_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_stats_tbl.md)
23. Fix [\#134](https://github.com/spsanderson/TidyDensity/issues/134) -
    Add function
    [`util_binomial_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_stats_tbl.md)
24. Fix [\#133](https://github.com/spsanderson/TidyDensity/issues/133) -
    Add function
    [`util_beta_stats_tbl()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_stats_tbl.md)

### Minor Fixes and Improvements

1.  Fix [\#110](https://github.com/spsanderson/TidyDensity/issues/110) -
    Bug fix, correct the `p` calculation in
    [`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md)
    that will now produce the correct probability chart from the auto
    plot functions.
2.  Fix [\#112](https://github.com/spsanderson/TidyDensity/issues/112) -
    Bug fix, correct the `p` calculation in
    [`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md)
    that will no produce the correct probability chart from the auto
    plot functions.
3.  Fix [\#115](https://github.com/spsanderson/TidyDensity/issues/115) -
    Fix spelling in Quantile chart.
4.  Fix [\#117](https://github.com/spsanderson/TidyDensity/issues/117) -
    Fix probability plot x axis label.
5.  Fix [\#118](https://github.com/spsanderson/TidyDensity/issues/118) -
    Fix fill color on combined auto plot
6.  Fix [\#122](https://github.com/spsanderson/TidyDensity/issues/122) -
    The
    [`tidy_distribution_summary_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_summary_tbl.md)
    function did not take the output of
    [`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)
7.  Fix [\#166](https://github.com/spsanderson/TidyDensity/issues/166) -
    Change in all plotting functions `ggplot2::xlim(0, max_dy)` to
    `ggplot2::ylim(0, max_dy)`
8.  Fix [\#169](https://github.com/spsanderson/TidyDensity/issues/169) -
    Fix the computation of the `q` column
9.  Fix [\#170](https://github.com/spsanderson/TidyDensity/issues/170) -
    Fix the graphing of the quantile chart due to
    [\#169](https://github.com/spsanderson/TidyDensity/issues/169)

## TidyDensity 1.0.1

CRAN release: 2022-03-27

### Breaking Changes

1.  Fix [\#91](https://github.com/spsanderson/TidyDensity/issues/91) -
    Bug fix, change
    [`tidy_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_gamma.md)
    parameter of `.rate` to
    `.scale Fix`tidy_autoplot\_`functions to incorporate this change. Fix`util_gamma_param_estimate()`to say`scale`instead of`rate\`
    in the returned estimated parameters.

### New Features

None

### Minor Fixes and Improvements

1.  Fix [\#90](https://github.com/spsanderson/TidyDensity/issues/90) -
    Make sure when `.geom_smooth` is set to TRUE that
    `ggplot2::xlim(0, max_dy)` is set.
2.  Fix [\#100](https://github.com/spsanderson/TidyDensity/issues/100) -
    [`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)
    failed on distribution with single parameter like
    [`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md)
3.  Fix [\#96](https://github.com/spsanderson/TidyDensity/issues/96) -
    Enhance all `tidy_` distribution functions to add an attribute of
    either discrete or continuous that helps in the autoplot process.
4.  Fix [\#97](https://github.com/spsanderson/TidyDensity/issues/97) -
    Enhance
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)
    to use histogram or lines for density plot depending on if the
    distribution is discrete or continuous.
5.  Fix [\#99](https://github.com/spsanderson/TidyDensity/issues/99) -
    Enhance
    [`tidy_multi_dist_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_dist_autoplot.md)
    to use histogram or lines for density plot depending on if the
    distribution is discrete or continuous.

## TidyDensity 1.0.0

CRAN release: 2022-03-08

### Breaking Changes

None

### New Features

1.  Fix [\#27](https://github.com/spsanderson/TidyDensity/issues/27) -
    Add function
    [`tidy_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_binomial.md)
2.  Fix [\#32](https://github.com/spsanderson/TidyDensity/issues/32) -
    Add function
    [`tidy_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_geometric.md)
3.  Fix [\#33](https://github.com/spsanderson/TidyDensity/issues/33) -
    Add function
    [`tidy_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_negative_binomial.md)
4.  Fix [\#34](https://github.com/spsanderson/TidyDensity/issues/34) -
    Add function
    [`tidy_zero_truncated_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_poisson.md)
5.  Fix [\#35](https://github.com/spsanderson/TidyDensity/issues/35) -
    Add function
    [`tidy_zero_truncated_geometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_geometric.md)
6.  Fix [\#36](https://github.com/spsanderson/TidyDensity/issues/36) -
    Add function
    [`tidy_zero_truncated_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_binomial.md)
7.  Fix [\#37](https://github.com/spsanderson/TidyDensity/issues/37) -
    Add function
    [`tidy_zero_truncated_negative_binomial()`](https://www.spsanderson.com/TidyDensity/reference/tidy_zero_truncated_negative_binomial.md)
8.  Fix [\#41](https://github.com/spsanderson/TidyDensity/issues/41) -
    Add function
    [`tidy_pareto1()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto1.md)
9.  Fix [\#42](https://github.com/spsanderson/TidyDensity/issues/42) -
    Add function
    [`tidy_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_pareto.md)
10. Fix [\#43](https://github.com/spsanderson/TidyDensity/issues/43) -
    Add function
    [`tidy_inverse_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_pareto.md)
11. Fix [\#58](https://github.com/spsanderson/TidyDensity/issues/58) -
    Add function
    [`tidy_random_walk()`](https://www.spsanderson.com/TidyDensity/reference/tidy_random_walk.md)
12. Fix [\#60](https://github.com/spsanderson/TidyDensity/issues/60) -
    Add function
    [`tidy_random_walk_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_random_walk_autoplot.md)
13. Fix [\#47](https://github.com/spsanderson/TidyDensity/issues/47) -
    Add function
    [`tidy_generalized_pareto()`](https://www.spsanderson.com/TidyDensity/reference/tidy_generalized_pareto.md)
14. Fix [\#44](https://github.com/spsanderson/TidyDensity/issues/44) -
    Add function
    [`tidy_paralogistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_paralogistic.md)
15. Fix [\#38](https://github.com/spsanderson/TidyDensity/issues/38) -
    Add function
    [`tidy_inverse_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_exponential.md)
16. Fix [\#45](https://github.com/spsanderson/TidyDensity/issues/45) -
    Add function
    [`tidy_inverse_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_gamma.md)
17. Fix [\#46](https://github.com/spsanderson/TidyDensity/issues/46) -
    Add function
    [`tidy_inverse_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_weibull.md)
18. Fix [\#48](https://github.com/spsanderson/TidyDensity/issues/48) -
    Add function
    [`tidy_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_burr.md)
19. Fix [\#49](https://github.com/spsanderson/TidyDensity/issues/49) -
    Add function
    [`tidy_inverse_burr()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_burr.md)
20. Fix [\#50](https://github.com/spsanderson/TidyDensity/issues/50) -
    Add function
    [`tidy_inverse_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_inverse_normal.md)
21. Fix [\#51](https://github.com/spsanderson/TidyDensity/issues/51) -
    Add function
    [`tidy_generalized_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_generalized_beta.md)
22. Fix [\#26](https://github.com/spsanderson/TidyDensity/issues/26) -
    Add function
    [`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)
23. Fix [\#62](https://github.com/spsanderson/TidyDensity/issues/62) -
    Add function
    [`tidy_multi_dist_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_dist_autoplot.md)
24. Fix [\#66](https://github.com/spsanderson/TidyDensity/issues/66) -
    Add function
    [`tidy_combine_distributions()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combine_distributions.md)
25. Fix [\#69](https://github.com/spsanderson/TidyDensity/issues/69) -
    Add functions
    [`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
    [`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md),
    and
    [`tidy_range_statistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_range_statistic.md)
26. Fix [\#75](https://github.com/spsanderson/TidyDensity/issues/75) -
    Add function
    [`util_beta_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_beta_param_estimate.md)
27. Fix [\#76](https://github.com/spsanderson/TidyDensity/issues/76) -
    Add function
    [`util_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_binomial_param_estimate.md)
28. Fix [\#77](https://github.com/spsanderson/TidyDensity/issues/77) -
    Add function
    [`util_exponential_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_exponential_param_estimate.md)
29. Fix [\#78](https://github.com/spsanderson/TidyDensity/issues/78) -
    Add function
    [`util_gamma_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_gamma_param_estimate.md)
30. Fix [\#79](https://github.com/spsanderson/TidyDensity/issues/79) -
    Add function
    [`util_geometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_geometric_param_estimate.md)
31. Fix [\#80](https://github.com/spsanderson/TidyDensity/issues/80) -
    Add function
    [`util_hypergeometric_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_hypergeometric_param_estimate.md)
32. Fix [\#81](https://github.com/spsanderson/TidyDensity/issues/81) -
    Add function
    [`util_lognormal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_lognormal_param_estimate.md)
33. Fix [\#89](https://github.com/spsanderson/TidyDensity/issues/89) -
    Add function
    [`tidy_scale_zero_one_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_scale_zero_one_vec.md)
34. Fix [\#87](https://github.com/spsanderson/TidyDensity/issues/87) -
    Add function
    [`tidy_combined_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combined_autoplot.md)
35. Fix [\#82](https://github.com/spsanderson/TidyDensity/issues/82) -
    Add function
    [`util_logistic_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_logistic_param_estimate.md)
36. Fix [\#83](https://github.com/spsanderson/TidyDensity/issues/83) -
    Add function
    [`util_negative_binomial_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_negative_binomial_param_estimate.md)
37. Fix [\#84](https://github.com/spsanderson/TidyDensity/issues/84) -
    Add function
    [`util_normal_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_normal_param_estimate.md)
38. Fix [\#85](https://github.com/spsanderson/TidyDensity/issues/85) -
    Add function
    [`util_pareto_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_pareto_param_estimate.md)
39. Fix [\#86](https://github.com/spsanderson/TidyDensity/issues/86) -
    Add function
    [`util_poisson_param_estimate()`](https://www.spsanderson.com/TidyDensity/reference/util_poisson_param_estimate.md)

### Fixes and Minor Improvements

1.  Fix [\#30](https://github.com/spsanderson/TidyDensity/issues/30) -
    Move `crayon`, `rstudioapi`, and `cli` from Suggests to Imports due
    to `pillar` no longer importing.
2.  Fix [\#52](https://github.com/spsanderson/TidyDensity/issues/52) -
    Add parameter `.geom_rug` to
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)
    function
3.  Fix [\#54](https://github.com/spsanderson/TidyDensity/issues/54) -
    Add parameter `.geom_point` to
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)
    function
4.  Fix [\#53](https://github.com/spsanderson/TidyDensity/issues/53) -
    Add parameter `.geom_smooth` to
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)
    function
5.  Fix [\#55](https://github.com/spsanderson/TidyDensity/issues/55) -
    Add parameter `.geom_jitter` to
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)
    function
6.  Fix [\#57](https://github.com/spsanderson/TidyDensity/issues/57) -
    Fix
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)
    for when the distribution is
    [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
    the legend argument would fail.
7.  Fix [\#56](https://github.com/spsanderson/TidyDensity/issues/56) -
    Add attributes of .n and .num_sims (1L for now) to
    [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
8.  Fix [\#61](https://github.com/spsanderson/TidyDensity/issues/61) -
    Update `_pkgdown.yml` file to update site.
9.  Fix [\#67](https://github.com/spsanderson/TidyDensity/issues/67) -
    Add `param_grid`, `param_grid_txt`, and `dist_with_params` to the
    attributes of all `tidy_` distribution functions.
10. Fix [\#70](https://github.com/spsanderson/TidyDensity/issues/70) -
    Add `...` as a grouping parameter to
    [`tidy_distribution_summary_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_summary_tbl.md)
11. Fix [\#88](https://github.com/spsanderson/TidyDensity/issues/88) -
    Make the column `dist_type` a factor for
    [`tidy_combine_distributions()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combine_distributions.md)

## TidyDensity 0.0.1

CRAN release: 2022-01-21

### Breaking Changes

None

### New Features

1.  Fix [\#1](https://github.com/spsanderson/TidyDensity/issues/1) - Add
    function
    [`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md)
2.  Fix [\#4](https://github.com/spsanderson/TidyDensity/issues/4) - Add
    function
    [`tidy_gamma()`](https://www.spsanderson.com/TidyDensity/reference/tidy_gamma.md)
3.  Fix [\#5](https://github.com/spsanderson/TidyDensity/issues/5) - Add
    function
    [`tidy_beta()`](https://www.spsanderson.com/TidyDensity/reference/tidy_beta.md)
4.  Fix [\#6](https://github.com/spsanderson/TidyDensity/issues/6) - Add
    function
    [`tidy_poisson()`](https://www.spsanderson.com/TidyDensity/reference/tidy_poisson.md)
5.  Fix [\#2](https://github.com/spsanderson/TidyDensity/issues/2) - Add
    function
    [`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md)
6.  Fix [\#11](https://github.com/spsanderson/TidyDensity/issues/11) -
    Add function
    [`tidy_distribution_summary_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_distribution_summary_tbl.md)
7.  Fix [\#10](https://github.com/spsanderson/TidyDensity/issues/10) -
    Add function
    [`tidy_empirical()`](https://www.spsanderson.com/TidyDensity/reference/tidy_empirical.md)
8.  Fix [\#13](https://github.com/spsanderson/TidyDensity/issues/13) -
    Add function
    [`tidy_uniform()`](https://www.spsanderson.com/TidyDensity/reference/tidy_uniform.md)
9.  Fix [\#14](https://github.com/spsanderson/TidyDensity/issues/14) -
    Add function
    [`tidy_exponential()`](https://www.spsanderson.com/TidyDensity/reference/tidy_exponential.md)
10. Fix [\#15](https://github.com/spsanderson/TidyDensity/issues/15) -
    Add function
    [`tidy_logistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_logistic.md)
11. Fix [\#16](https://github.com/spsanderson/TidyDensity/issues/16) -
    Add function
    [`tidy_lognormal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_lognormal.md)
12. Fix [\#17](https://github.com/spsanderson/TidyDensity/issues/17) -
    Add function
    [`tidy_weibull()`](https://www.spsanderson.com/TidyDensity/reference/tidy_weibull.md)
13. Fix [\#18](https://github.com/spsanderson/TidyDensity/issues/18) -
    Add function
    [`tidy_chisquare()`](https://www.spsanderson.com/TidyDensity/reference/tidy_chisquare.md)
14. Fix [\#19](https://github.com/spsanderson/TidyDensity/issues/19) -
    Add function
    [`tidy_cauchy()`](https://www.spsanderson.com/TidyDensity/reference/tidy_cauchy.md)
15. Fix [\#20](https://github.com/spsanderson/TidyDensity/issues/20) -
    Add function
    [`tidy_hypergeometric()`](https://www.spsanderson.com/TidyDensity/reference/tidy_hypergeometric.md)
16. Fix [\#21](https://github.com/spsanderson/TidyDensity/issues/21) -
    Add function
    [`tidy_f()`](https://www.spsanderson.com/TidyDensity/reference/tidy_f.md)

### Minor Fixes and Improvements

None

## TidyDensity 0.0.0.9000

### Breaking Changes

None

### New Features

- Added a `NEWS.md` file to track changes to the package.

### Fixes and Minor Improvements

None
