# TidyDensity 1.5.1

## Breaking Changes
None

## New Features
None

## Minor Fixes and Improvements
1. Fix #515 - Fix documentation issue with `rinvgauss`
2. Fix #514 - Fix documentation issue with `tidy_geometric()`

# TidyDensity 1.5.0

## Breaking Changes
None

## New Features
1. Fix #468 - Add function `util_negative_binomial_aic()` to calculate the AIC for the negative binomial distribution.
2. Fix #470 - Add function `util_zero_truncated_negative_binomial_param_estimate()` to
estimate the parameters of the zero-truncated negative binomial distribution.
Add function `util_zero_truncated_negative_binomial_aic()` to calculate the AIC for the zero-truncated negative binomial distribution.
Add function `util_zero_truncated_negative_binomial_stats_tbl()` to create a summary table of the zero-truncated negative binomial distribution.
3. Fix #471 - Add function `util_zero_truncated_poisson_param_estimate()` to estimate
the parameters of the zero-truncated Poisson distribution. 
Add function `util_zero_truncated_poisson_aic()` to calculate the AIC for the zero-truncated Poisson distribution. 
Add function `util_zero_truncated_poisson_stats_tbl()` to create a summary table of the zero-truncated Poisson distribution.
4. Fix #472 - Add function `util_f_param_estimate()` and `util_f_aic()` to estimate the parameters and calculate the AIC for the F distribution.
5. Fix #482 - Add function `util_zero_truncated_geometric_param_estimate()` to estimate the parameters of the zero-truncated geometric distribution.
Add function `util_zero_truncated_geometric_aic()` to calculate the AIC for the zero-truncated geometric distribution.
Add function `util_zero_truncated_geometric_stats_tbl()` to create a summary table of the zero-truncated geometric distribution.
6. Fix #481 - Add function `util_triangular_aic()` to calculate the AIC for the triangular distribution.
7. Fix #480 - Add function `util_t_param_estimate()` to estimate the parameters of the
T distribution. 
Add function `util_t_aic()` to calculate the AIC for the T distribution.
8. Fix #479 - Add function `util_pareto1_param_estimate()` to estimate the parameters of the Pareto Type I distribution.
Add function `util_pareto1_aic()` to calculate the AIC for the Pareto Type I distribution.
Add function `util_pareto1_stats_tbl()` to create a summary table of the Pareto Type I distribution.
9. Fix #478 - Add function `util_paralogistic_param_estimate()` to estimate the parameters of the paralogistic distribution.
Add function `util_paralogistic_aic()` to calculate the AIC for the paralogistic distribution.
Add fnction `util_paralogistic_stats_tbl()` to create a summary table of the paralogistic distribution.
10. Fix #477 - Add function `util_inverse_weibull_param_estimate()` to estimate the parameters of the Inverse Weibull distribution.
Add function `util_inverse_weibull_aic()` to calculate the AIC for the Inverse Weibull distribution.
Add function `util_inverse_weibull_stats_tbl()` to create a summary table of the Inverse Weibull distribution.
11. Fix #476 - Add function `util_inverse_pareto_param_estimate()` to estimate the parameters of the Inverse Pareto distribution.
Add function `util_inverse_pareto_aic()` to calculate the AIC for the Inverse Pareto distribution.
Add Function `util_inverse_pareto_stats_tbl()` to create a summary table of the Inverse Pareto distribution.
12. Fix #475 - Add function `util_inverse_burr_param_estimate()` to estimate the parameters of the Inverse Gamma distribution.
Add function `util_inverse_burr_aic()` to calculate the AIC for the Inverse Gamma distribution.
Add function `util_inverse_burr_stats_tbl()` to create a summary table of the Inverse Gamma distribution.
13. Fix #474 - Add function `util_generalized_pareto_param_estimate()` to estimate the parameters of the Generalized Pareto distribution.
Add function `util_generalized_pareto_aic()` to calculate the AIC for the Generalized Pareto distribution.
Add function `util_generalized_pareto_stats_tbl()` to create a summary table of the Generalized Pareto distribution.
14. Fix #473 - Add function `util_generalized_beta_param_estimate()` to estimate the parameters of the Generalized Gamma distribution.
Add function `util_generalized_beta_aic()` to calculate the AIC for the Generalized Gamma distribution.
Add function `util_generalized_beta_stats_tbl()` to create a summary table of the Generalized Gamma distribution.
15. Fix #469 - Add function `util_zero_truncated_binomial_stats_tbl()` to create a summary table of the Zero Truncated binomial distribution.
Add function `util_zero_truncated_binomial_param_estimate()` to estimate the parameters of the Zero Truncated binomial distribution.
Add function `util_zero_truncated_binomial_aic()` to calculate the AIC for the Zero Truncated binomial distribution.

## Minor Improvements and Fixes
1. Fix #468 - Update `util_negative_binomial_param_estimate()` to add the use of
`optim()` for parameter estimation.
2. Fix #465 - Add names to columns when `.return_tibble = TRUE` for `quantile_normalize()`

# TidyDensity 1.4.0

## Breaking Changes
None

## New Features
1. Fix #405 - Add function `quantile_normalize()` to normalize data using quantiles.
2. Fix #409 - Add function `check_duplicate_rows()` to check for duplicate rows in a data frame.
3. Fix #414 - Add function `util_chisquare_param_estimate()` to estimate the parameters of the chi-square distribution.
4. Fix #417 - Add function `tidy_mcmc_sampling()` to sample from a distribution using MCMC.
This outputs the function sampled data and a diagnostic plot.
5. Fix #421 - Add functions `util_dist_aic()` functions to calculate the AIC for a distribution.

## Minor Fixes and Improvements
1. Fix #401 - Update `tidy_multi_single_dist()` to respect the `.return_tibble` parameter
2. Fix #406 - Update `tidy_multi_single_dist()` to exclude the `.return_tibble` parameter
from returning in the distribution parameters.
3. Fix #413 - Update documentation to include `mcmc` where applicable.
4. Fix #240 - Update `tidy_distribution_comparison()` to include the new AIC calculations
from the dedicated `util_dist_aic()` functions.

# TidyDensity 1.3.0

## Breaking Changes
1. Fix #350 - This has caused the function `tidy_multi_single_dist()` to be modified
in that it now requires the user to pass the parameter of `.return_tibbl` with either
TRUE or FALSE as it was introduced into the `tidy_` distribution functions which now
use `data.table` under the hood to generate data.
2. Fix #371 - Modify code to use the native `|>` pipe instead of the `%>%` which 
has caused a need to update the minimum R version to 4.1.0

## New Features
1. Fix #360 - Add function `tidy_triangular()`
2. Fix #361 - Add function `util_triangular_param_estimate()`
3. Fix #362 - Add function `util_triangular_stats_tbl()`
4. Fix #364 - Add function `triangle_plot()`
5. Fix #363 - Add triangular to `tidy_autoplot()`

## Minor Fixes and Improvements
1. Fix #372 and #373 - Update `cvar()` and `csd()` to a vectorized approach from @kokbent
which speeds these up by over 100x
2. Fix #350 - Update all `tidy_` distribution functions to generate data using `data.table` 
this in many instances has resulted in a speed up of 30% or more.
3. Fix #379 - Replace the use of `dplyr::cur_data()` as it was deprecated in 
dplyr in favor of using `dplyr::pick()`
4. Fix #381 - Add `tidy_triangular()` to all autoplot functions.
5. Fix #385 - For `tidy_multi_dist_autoplot()` the `.plot_type = "quantile"` did
not work.
6. Fix #383 - Update all autoplot functions to use linewidth instead of size.
7. Fix #375 - Update `cskewness()` to take advantage of vectorization with a speedup
of 124x faster.
8. Fix #393 - Update `ckurtosis()` with vectorization to improve speed by 121x per
benchmark testing.

# TidyDensity 1.2.6

## Breaking Changes
None

## New Features
1. Fix #351 - Add function `convert_to_ts()` which will convert a `tidy_` distribution
into a time series in either `ts` format or `tibble` you can also have it set to 
wide or long by using `.pivot_longer` set to TRUE and `.ret_ts` set to FALSE
2. Fix #348 - Add function `util_burr_stats_tbl()`

## Minor Fixes and Improvements
1. Fix #344 - Fix `util_burr_param_estimate()`

# TidyDensity 1.2.5

## Breaking Changes
None

## New Features
1. Fix #333 - Add function `util_burr_param_estimate()`

## Minor Fixes and Improvements
1. Fix #335 - Update function `tidy_distribution_comparison()` to add a parameter
of `.round_to_place` which allows a user to round the parameter estimates passed
to their corresponding distribution parameters.
2. Fix #336 - Update logo name to logo.png

# TidyDensity 1.2.4

## Breaking Changes
None

## New Features
1. Fix #302 - Add function `tidy_bernoulli()` 
2. Fix #304 - Add function `util_bernoulli_param_estimate()`
3. Fix #305 - Add function `util_bernoulli_stats_tbl()`

## Minor Fixes and Improvements
1. Fix #291 - Update `tidy_stat_tbl()` to fix `tibble` output so it no longer ignores
passed arguments and fix `data.table` to directly pass ... arguments.
2. Fix #295 - Drop warning message of not passing arguments when .use_data_table = TRUE
3. Fix #303 - Add `tidy_bernoulli()` to autoplot.
4. Fix #299 - Update `tidy_stat_tbl()`
5. Fix #309 - Add function for internal use to drop dependency of stringr. Function
is `dist_type_extractor()` which is used for several functions in the library.
6. Fix #310 - Update combine-multi-dist to use `dist_type_extractor()`
7. Fix #311 - Update all `util_dist_stats_tbl()` functions to use `dist_type_extractor()`
8. Fix #316 - Update all `autoplot` functions for `tidy_bernoulli()`
9. Fix #312 - Update random walk function to use `dist_type_extractor()`
10. Fix #314 - Update `tidy_stat_tbl()` to use `dist_type_extractor()`
11. Fix #301 - Fix `p` and `q` calculations.

# TidyDensity 1.2.3

## Breaking Changes
None

## New Features
1. Fix #237 - Add function `bootstrap_density_augment()`
2. Fix #238 - Add functions `bootstrap_p_vec()` and `bootstrap_p_augment()`
3. Fix #239 - Add functions `bootstrap_q_vec()` and `bootstrap_q_augment()`
4. Fix #256 #257 #258 #260 #265 #266 #267 #268 - Add functions `cmean()`
`chmean()` `cgmean()` `cmedian()` `csd()` `ckurtosis()` `cskewness()` `cvar()`
5. Fix #250 - Add function `bootstrap_stat_plot()`
6. Fix #276 - Add function `tidy_stat_tbl()` Fix #281 adds the parameter of 
`.user_data_table` which is set to `FALSE` by default. If set to `TRUE` will use
`[data.table::melt()]` for the underlying work speeding up the output from a 
benchmark test of regular `tibble` at 72 seconds to `data.table.` at 15 seconds.

## Minor Fixes and Improvements
1. Fix #242 - Fix `prop` check in `tidy_bootstrap()`
2. Fix #247 - Add attributes to `bootstrap_density_augment()` output.

# TidyDensity 1.2.2

## Breaking Changes
None

## New Features
1. Fix #229 - Add `tidy_normal()` to list of tested distributions. Add `AIC` from
a linear model for metric, and add `stats::ks.test()` as a metric.

## Minor Fixes and Improvements
1. Fix #228 - Add ks.test to distribution comparison.
2. Fix #227 - Add AIC and normal to distribution comparison.

# TidyDensity 1.2.1

## Breaking Changes
None

## New Features
None

## Minor Fixes and Improvments
1. Fix #210 - Fix param_grid order on internal which affected attributes and thus
the display of the order of the parameters.
2. Fix #211 - Add High and Low CI to `tidy_distribution_summary_tbl()`
3. Fix #213 - Use `purrr::compact()` on the list of distributions passed in order
to prevent the issue occurring in #212
4. Fix #212 - Make `tidy_distribution_comparison()` more robust in terms of handling
bad or erroneous data.
5. Fix #216 - Add an attribute of "tibble_type" to `tidy_multi_single_dist()` which
helps it to work with other functions like `tidy_random_walk()`

# TidyDensity 1.2.0

## Breaking Changes
None

## New Features
1. Fix #181 - Add functions `color_blind()` `td_scale_fill_colorblind()` and 
`td_scale_color_colorblind()`
2. Fix #187 - Add functions `ci_lo()` and `ci_hi()`
3. Fix #189 - Add function `tidy_bootstrap()`
4. Fix #190 - Add function `bootstrap_unnest_tbl()`
5. Fix #202 - Add function `tidy_distribution_comparison()`

## Minor Fixes and Improvements
1. Fix #176 - Update `_autoplot` functions to include cumulative mean MCMC chart
by taking advantage of the `.num_sims` parameter of `tidy_` distribution
functions.
2. Fix #184 - Update `tidy_empirical()` to add a parameter of `.distribution_type`
3. Fix #183 - `tidy_empirical()` is now again plotted by `_autoplot` functions.
4. Fix #188 - Add the `.num_sims` parameter to `tidy_empirical()`
5. Fix #196 - Add `ci_lo()` and `ci_hi()` to all stats tbl functions.
6. Fix #201 - Correct attribute of `distribution_family_type` to `discrete` for
`tidy_geometric()`

# TidyDensity 1.1.0

## Breaking Changes
None

## New Features
1. Fix #119 - Add function `tidy_four_autoplot()` - This will auto plot the density,
qq, quantile and probability plots to a single graph.
2. Fix #125 - Add function `util_weibull_param_estimate()`
3. Fix #126 - Add function `util_uniform_param_estimate()`
4. Fix #127 - Add function `util_cauchy_param_estimate()`
5. Fix #130 - Add function `tidy_t()` - Also add to plotting functions.
6. Fix #151 - Add function `tidy_mixture_density()`
7. Fix #150 - Add function `util_geometric_stats_tbl()`
8. Fix #149 - Add function `util_hypergeometric_stats_tbl()`
9. Fix #148 - Add function `util_logistic_stats_tbl()`
10. Fix #147 - Add function `util_lognormal_stats_tbl()`
11. Fix #146 - Add function `util_negative_binomial_stats_tbl()`
12. Fix #145 - Add function `util_normal_stats_tbl()`
13. Fix #144 - Add function `util_pareto_stats_tbl()`
14. Fix #143 - Add function `util_poisson_stats_tbl()`
15. Fix #142 - Add function `util_uniform_stats_tbl()`
16. Fix #141 - Add function `util_cauchy_stats_tbl()`
17. Fix #140 - Add function `util_t_stats_tbl()`
18. Fix #139 - Add function `util_f_stats_tbl()`
19. Fix #138 - Add function `util_chisquare_stats_tbl()`
20. Fix #137 - Add function `util_weibull_stats_tbl()`
21. Fix #136 - Add function `util_gamma_stats_tbl()`
22. Fix #135 - Add function `util_exponential_stats_tbl()`
23. Fix #134 - Add function `util_binomial_stats_tbl()`
24. Fix #133 - Add function `util_beta_stats_tbl()`

## Minor Fixes and Improvements
1. Fix #110 - Bug fix, correct the `p` calculation in `tidy_poisson()` that will
now produce the correct probability chart from the auto plot functions.
2. Fix #112 - Bug fix, correct the `p` calculation in `tidy_hypergeometric()` that
will no produce the correct probability chart from the auto plot functions.
3. Fix #115 - Fix spelling in Quantile chart.
4. Fix #117 - Fix probability plot x axis label.
4. Fix #118 - Fix fill color on combined auto plot
5. Fix #122 - The `tidy_distribution_summary_tbl()` function did not take the 
output of `tidy_multi_single_dist()` 
6. Fix #166 - Change in all plotting functions `ggplot2::xlim(0, max_dy)` to 
`ggplot2::ylim(0, max_dy)`
7. Fix #169 - Fix the computation of the `q` column 
8. Fix #170 - Fix the graphing of the quantile chart due to #169

# TidyDensity 1.0.1

## Breaking Changes
1. Fix #91 - Bug fix, change `tidy_gamma()` parameter of `.rate` to `.scale
Fix `tidy_autoplot_` functions to incorporate this change. Fix `util_gamma_param_estimate()`
to say `scale` instead of `rate` in the returned estimated parameters.

## New Features
None

## Minor Fixes and Improvements
1. Fix #90 - Make sure when `.geom_smooth` is set to TRUE that `ggplot2::xlim(0, max_dy)`
is set.
2. Fix #100 - `tidy_multi_single_dist()` failed on distribution with single parameter
like `tidy_poisson()`
3. Fix #96 - Enhance all `tidy_` distribution functions to add an attribute of 
either discrete or continuous that helps in the autoplot process.
4. Fix #97 - Enhance `tidy_autoplot()` to use histogram or lines for density plot
depending on if the distribution is discrete or continuous.
5. Fix #99 - Enhance `tidy_multi_dist_autoplot()` to use histogram or lines for
density plot depending on if the distribution is discrete or continuous.

# TidyDensity 1.0.0

## Breaking Changes
None

## New Features
1. Fix #27 - Add function `tidy_binomial()`
2. Fix #32 - Add function `tidy_geometric()`
3. Fix #33 - Add function `tidy_negative_binomial()`
4. Fix #34 - Add function `tidy_zero_truncated_poisson()`
5. Fix #35 - Add function `tidy_zero_truncated_geometric()`
6. Fix #36 - Add function `tidy_zero_truncated_binomial()`
7. Fix #37 - Add function `tidy_zero_truncated_negative_binomial()`
8. Fix #41 - Add function `tidy_pareto1()`
9. Fix #42 - Add function `tidy_pareto()`
10. Fix #43 - Add function `tidy_inverse_pareto()`
11. Fix #58 - Add function `tidy_random_walk()`
12. Fix #60 - Add function `tidy_random_walk_autoplot()`
13. Fix #47 - Add function `tidy_generalized_pareto()`
14. Fix #44 - Add function `tidy_paralogistic()`
15. Fix #38 - Add function `tidy_inverse_exponential()`
16. Fix #45 - Add function `tidy_inverse_gamma()`
17. Fix #46 - Add function `tidy_inverse_weibull()`
18. Fix #48 - Add function `tidy_burr()`
19. Fix #49 - Add function `tidy_inverse_burr()`
20. Fix #50 - Add function `tidy_inverse_normal()`
21. Fix #51 - Add function `tidy_generalized_beta()`
22. Fix #26 - Add function `tidy_multi_single_dist()`
23. Fix #62 - Add function `tidy_multi_dist_autoplot()`
24. Fix #66 - Add function `tidy_combine_distributions()`
25. Fix #69 - Add functions `tidy_kurtosis_vec()`, `tidy_skewness_vec()`, and
`tidy_range_statistic()`
26. Fix #75 - Add function `util_beta_param_estimate()`
27. Fix #76 - Add function `util_binomial_param_estimate()`
28. Fix #77 - Add function `util_exponential_param_estimate()`
29. Fix #78 - Add function `util_gamma_param_estimate()`
30. Fix #79 - Add function `util_geometric_param_estimate()`
31. Fix #80 - Add function `util_hypergeometric_param_estimate()`
32. Fix #81 - Add function `util_lognormal_param_estimate()`
33. Fix #89 - Add function `tidy_scale_zero_one_vec()`
34. Fix #87 - Add function `tidy_combined_autoplot()`
35. Fix #82 - Add function `util_logistic_param_estimate()`
36. Fix #83 - Add function `util_negative_binomial_param_estimate()`
37. Fix #84 - Add function `util_normal_param_estimate()`
38. Fix #85 - Add function `util_pareto_param_estimate()`
39. Fix #86 - Add function `util_poisson_param_estimate()`

## Fixes and Minor Improvements
1. Fix #30 - Move `crayon`, `rstudioapi`, and `cli` from Suggests to Imports due to `pillar`
no longer importing.
2. Fix #52 - Add parameter `.geom_rug` to `tidy_autoplot()` function
3. Fix #54 - Add parameter `.geom_point` to `tidy_autoplot()` function
4. Fix #53 - Add parameter `.geom_smooth` to `tidy_autoplot()` function
5. Fix #55 - Add parameter `.geom_jitter` to `tidy_autoplot()` function
6. Fix #57 - Fix `tidy_autoplot()` for when the distribution is `tidy_empirical()`
the legend argument would fail.
7. Fix #56 - Add attributes of .n and .num_sims (1L for now) to `tidy_empirical()`
8. Fix #61 - Update `_pkgdown.yml` file to update site.
9. Fix #67 - Add `param_grid`, `param_grid_txt`, and `dist_with_params` to the
attributes of all `tidy_` distribution functions.
10. Fix #70 - Add `...` as a grouping parameter to `tidy_distribution_summary_tbl()`
11. Fix #88 - Make the column `dist_type` a factor for `tidy_combine_distributions()`

# TidyDensity 0.0.1

## Breaking Changes
None

## New Features
1. Fix #1 - Add function `tidy_normal()`
2. Fix #4 - Add function `tidy_gamma()`
3. Fix #5 - Add function `tidy_beta()`
4. Fix #6 - Add function `tidy_poisson()`
5. Fix #2 - Add function `tidy_autoplot()`
6. Fix #11 - Add function `tidy_distribution_summary_tbl()`
7. Fix #10 - Add function `tidy_empirical()`
8. Fix #13 - Add function `tidy_uniform()`
9. Fix #14 - Add function `tidy_exponential()`
10. Fix #15 - Add function `tidy_logistic()`
11. Fix #16 - Add function `tidy_lognormal()`
12. Fix #17 - Add function `tidy_weibull()`
13. Fix #18 - Add function `tidy_chisquare()`
14. Fix #19 - Add function `tidy_cauchy()`
15. Fix #20 - Add function `tidy_hypergeometric()`
16. Fix #21 - Add function `tidy_f()`

## Minor Fixes and Improvements
None

# TidyDensity 0.0.0.9000

## Breaking Changes
None

## New Features
* Added a `NEWS.md` file to track changes to the package.

## Fixes and Minor Improvements
None
