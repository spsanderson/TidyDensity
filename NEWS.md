# TidyDensity (development version)

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
