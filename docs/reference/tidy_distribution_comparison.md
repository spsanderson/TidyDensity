# Compare Empirical Data to Distributions

Compare some empirical data set against different distributions to help
find the distribution that could be the best fit.

## Usage

``` r
tidy_distribution_comparison(
  .x,
  .distribution_type = "continuous",
  .round_to_place = 3
)
```

## Arguments

- .x:

  The data set being passed to the function

- .distribution_type:

  What kind of data is it, can be one of `continuous` or `discrete`

- .round_to_place:

  How many decimal places should the parameter estimates be rounded off
  to for distibution construction. The default is 3

## Value

An invisible list object. A tibble is printed.

## Details

The purpose of this function is to take some data set provided and to
try to find a distribution that may fit the best. A parameter of
`.distribution_type` must be set to either `continuous` or `discrete` in
order for this the function to try the appropriate types of
distributions.

The following distributions are used:

Continuous:

- tidy_beta

- tidy_cauchy

- tidy_chisquare

- tidy_exponential

- tidy_gamma

- tidy_logistic

- tidy_lognormal

- tidy_normal

- tidy_pareto

- tidy_uniform

- tidy_weibull

Discrete:

- tidy_binomial

- tidy_geometric

- tidy_hypergeometric

- tidy_poisson

The function itself returns a list output of tibbles. Here are the
tibbles that are returned:

- comparison_tbl

- deviance_tbl

- total_deviance_tbl

- aic_tbl

- kolmogorov_smirnov_tbl

- multi_metric_tbl

The `comparison_tbl` is a long `tibble` that lists the values of the
`density` function against the given data.

The `deviance_tbl` and the `total_deviance_tbl` just give the simple
difference from the actual density to the estimated density for the
given estimated distribution.

The `aic_tbl` will provide the `AIC` for liklehood of the distribution.

The `kolmogorov_smirnov_tbl` for now provides a `two.sided` estimate of
the `ks.test` of the estimated density against the empirical.

The `multi_metric_tbl` will summarise all of these metrics into a single
tibble.

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
xc <- mtcars$mpg
output_c <- tidy_distribution_comparison(xc, "continuous")
#> For the beta distribution, its mean 'mu' should be 0 < mu < 1. The data will
#> therefore be scaled to enforce this.
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> There was no need to scale the data.
#> Warning: There were 97 warnings in `dplyr::mutate()`.
#> The first warning was:
#> ℹ In argument: `aic_value = dplyr::case_when(...)`.
#> Caused by warning in `actuar::dpareto()`:
#> ! NaNs produced
#> ℹ Run dplyr::last_dplyr_warnings() to see the 96 remaining warnings.

xd <- trunc(xc)
output_d <- tidy_distribution_comparison(xd, "discrete")
#> There was no need to scale the data.
#> Warning: There were 12 warnings in `dplyr::mutate()`.
#> The first warning was:
#> ℹ In argument: `aic_value = dplyr::case_when(...)`.
#> Caused by warning in `actuar::dpareto()`:
#> ! NaNs produced
#> ℹ Run dplyr::last_dplyr_warnings() to see the 11 remaining warnings.

output_c
#> $comparison_tbl
#> # A tibble: 384 × 8
#>    sim_number     x     y    dx       dy     p     q dist_type
#>    <fct>      <int> <dbl> <dbl>    <dbl> <dbl> <dbl> <fct>    
#>  1 1              1  21    2.97 0.000113 0.625  10.4 Empirical
#>  2 1              2  21    4.21 0.000452 0.625  10.4 Empirical
#>  3 1              3  22.8  5.44 0.00142  0.781  13.3 Empirical
#>  4 1              4  21.4  6.68 0.00354  0.688  14.3 Empirical
#>  5 1              5  18.7  7.92 0.00720  0.469  14.7 Empirical
#>  6 1              6  18.1  9.16 0.0124   0.438  15   Empirical
#>  7 1              7  14.3 10.4  0.0192   0.125  15.2 Empirical
#>  8 1              8  24.4 11.6  0.0281   0.812  15.2 Empirical
#>  9 1              9  22.8 12.9  0.0395   0.781  15.5 Empirical
#> 10 1             10  19.2 14.1  0.0515   0.531  15.8 Empirical
#> # ℹ 374 more rows
#> 
#> $deviance_tbl
#> # A tibble: 384 × 2
#>    name                        value
#>    <chr>                       <dbl>
#>  1 Empirical                  0.451 
#>  2 Beta c(1.107, 1.577, 0)    0.381 
#>  3 Cauchy c(19.2, 7.375)      0.451 
#>  4 Chisquare c(20.243, 0)    -0.112 
#>  5 Exponential c(0.05)       -0.130 
#>  6 Gamma c(11.47, 1.752)      0.451 
#>  7 Logistic c(20.091, 3.27)   0.0457
#>  8 Lognormal c(2.958, 0.293)  0.269 
#>  9 Pareto c(10.4, 1.624)      0.267 
#> 10 Uniform c(8.341, 31.841)   0.238 
#> # ℹ 374 more rows
#> 
#> $total_deviance_tbl
#> # A tibble: 11 × 2
#>    dist_with_params          abs_tot_deviance
#>    <chr>                                <dbl>
#>  1 Gamma c(11.47, 1.752)                0.301
#>  2 Logistic c(20.091, 3.27)             1.18 
#>  3 Uniform c(8.341, 31.841)             1.41 
#>  4 Weibull c(3.579, 22.288)             1.43 
#>  5 Chisquare c(20.243, 0)               1.73 
#>  6 Lognormal c(2.958, 0.293)            2.07 
#>  7 Gaussian c(20.091, 5.932)            2.21 
#>  8 Beta c(1.107, 1.577, 0)              2.29 
#>  9 Exponential c(0.05)                  5.73 
#> 10 Pareto c(10.4, 1.624)                6.51 
#> 11 Cauchy c(19.2, 7.375)                7.37 
#> 
#> $aic_tbl
#> # A tibble: 11 × 3
#>    dist_type                 aic_value abs_aic
#>    <fct>                         <dbl>   <dbl>
#>  1 Beta c(1.107, 1.577, 0)         NA      NA 
#>  2 Cauchy c(19.2, 7.375)          218.    218.
#>  3 Chisquare c(20.243, 0)          NA      NA 
#>  4 Exponential c(0.05)            258.    258.
#>  5 Gamma c(11.47, 1.752)          206.    206.
#>  6 Logistic c(20.091, 3.27)       209.    209.
#>  7 Lognormal c(2.958, 0.293)      206.    206.
#>  8 Pareto c(10.4, 1.624)          260.    260.
#>  9 Uniform c(8.341, 31.841)       206.    206.
#> 10 Weibull c(3.579, 22.288)       209.    209.
#> 11 Gaussian c(20.091, 5.932)      209.    209.
#> 
#> $kolmogorov_smirnov_tbl
#> # A tibble: 11 × 6
#>    dist_type              ks_statistic ks_pvalue ks_method alternative dist_char
#>    <fct>                         <dbl>     <dbl> <chr>     <chr>       <chr>    
#>  1 Beta c(1.107, 1.577, …       0.781   0.000500 Monte-Ca… two-sided   Beta c(1…
#>  2 Cauchy c(19.2, 7.375)        0.656   0.000500 Monte-Ca… two-sided   Cauchy c…
#>  3 Chisquare c(20.243, 0)       0.0938  0.997    Monte-Ca… two-sided   Chisquar…
#>  4 Exponential c(0.05)          0.375   0.0205   Monte-Ca… two-sided   Exponent…
#>  5 Gamma c(11.47, 1.752)        0.25    0.269    Monte-Ca… two-sided   Gamma c(…
#>  6 Logistic c(20.091, 3.…       0.25    0.276    Monte-Ca… two-sided   Logistic…
#>  7 Lognormal c(2.958, 0.…       0.156   0.833    Monte-Ca… two-sided   Lognorma…
#>  8 Pareto c(10.4, 1.624)        0.844   0.000500 Monte-Ca… two-sided   Pareto c…
#>  9 Uniform c(8.341, 31.8…       0.156   0.831    Monte-Ca… two-sided   Uniform …
#> 10 Weibull c(3.579, 22.2…       0.156   0.852    Monte-Ca… two-sided   Weibull …
#> 11 Gaussian c(20.091, 5.…       0.125   0.964    Monte-Ca… two-sided   Gaussian…
#> 
#> $multi_metric_tbl
#> # A tibble: 11 × 8
#>    dist_type abs_tot_deviance aic_value abs_aic ks_statistic ks_pvalue ks_method
#>    <fct>                <dbl>     <dbl>   <dbl>        <dbl>     <dbl> <chr>    
#>  1 Gamma c(…            0.301      206.    206.       0.25    0.269    Monte-Ca…
#>  2 Logistic…            1.18       209.    209.       0.25    0.276    Monte-Ca…
#>  3 Uniform …            1.41       206.    206.       0.156   0.831    Monte-Ca…
#>  4 Weibull …            1.43       209.    209.       0.156   0.852    Monte-Ca…
#>  5 Chisquar…            1.73        NA      NA        0.0938  0.997    Monte-Ca…
#>  6 Lognorma…            2.07       206.    206.       0.156   0.833    Monte-Ca…
#>  7 Gaussian…            2.21       209.    209.       0.125   0.964    Monte-Ca…
#>  8 Beta c(1…            2.29        NA      NA        0.781   0.000500 Monte-Ca…
#>  9 Exponent…            5.73       258.    258.       0.375   0.0205   Monte-Ca…
#> 10 Pareto c…            6.51       260.    260.       0.844   0.000500 Monte-Ca…
#> 11 Cauchy c…            7.37       218.    218.       0.656   0.000500 Monte-Ca…
#> # ℹ 1 more variable: alternative <chr>
#> 
#> attr(,".x")
#>  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
#> [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
#> [31] 15.0 21.4
#> attr(,".n")
#> [1] 32
output_d
#> $comparison_tbl
#> # A tibble: 160 × 8
#>    sim_number     x     y    dx       dy     p     q dist_type
#>    <fct>      <int> <dbl> <dbl>    <dbl> <dbl> <dbl> <fct>    
#>  1 1              1    21  2.95 0.000119 0.719    10 Empirical
#>  2 1              2    21  4.14 0.000484 0.719    10 Empirical
#>  3 1              3    22  5.34 0.00154  0.781    13 Empirical
#>  4 1              4    21  6.54 0.00382  0.719    14 Empirical
#>  5 1              5    18  7.74 0.00765  0.469    14 Empirical
#>  6 1              6    18  8.93 0.0128   0.469    15 Empirical
#>  7 1              7    14 10.1  0.0194   0.156    15 Empirical
#>  8 1              8    24 11.3  0.0281   0.812    15 Empirical
#>  9 1              9    22 12.5  0.0397   0.781    15 Empirical
#> 10 1             10    19 13.7  0.0523   0.562    15 Empirical
#> # ℹ 150 more rows
#> 
#> $deviance_tbl
#> # A tibble: 160 × 2
#>    name                           value
#>    <chr>                          <dbl>
#>  1 Empirical                     0.478 
#>  2 Binomial c(32, 0.031)         0.478 
#>  3 Geometric c(0.048)           -0.245 
#>  4 Hypergeometric c(21, 11, 21) -0.0932
#>  5 Poisson c(19.688)             0.115 
#>  6 Empirical                     0.478 
#>  7 Binomial c(32, 0.031)         0.478 
#>  8 Geometric c(0.048)            0.0936
#>  9 Hypergeometric c(21, 11, 21)  0.193 
#> 10 Poisson c(19.688)             0.206 
#> # ℹ 150 more rows
#> 
#> $total_deviance_tbl
#> # A tibble: 4 × 2
#>   dist_with_params             abs_tot_deviance
#>   <chr>                                   <dbl>
#> 1 Hypergeometric c(21, 11, 21)           0.0497
#> 2 Poisson c(19.688)                      0.842 
#> 3 Geometric c(0.048)                     3.16  
#> 4 Binomial c(32, 0.031)                  3.48  
#> 
#> $aic_tbl
#> # A tibble: 4 × 3
#>   dist_type                    aic_value abs_aic
#>   <fct>                            <dbl>   <dbl>
#> 1 Binomial c(32, 0.031)             Inf     Inf 
#> 2 Geometric c(0.048)                258.    258.
#> 3 Hypergeometric c(21, 11, 21)      NaN     NaN 
#> 4 Poisson c(19.688)                 210.    210.
#> 
#> $kolmogorov_smirnov_tbl
#> # A tibble: 4 × 6
#>   dist_type               ks_statistic ks_pvalue ks_method alternative dist_char
#>   <fct>                          <dbl>     <dbl> <chr>     <chr>       <chr>    
#> 1 Binomial c(32, 0.031)          0.625  0.000500 Monte-Ca… two-sided   Binomial…
#> 2 Geometric c(0.048)             0.438  0.00500  Monte-Ca… two-sided   Geometri…
#> 3 Hypergeometric c(21, 1…        0.438  0.00450  Monte-Ca… two-sided   Hypergeo…
#> 4 Poisson c(19.688)              0.188  0.654    Monte-Ca… two-sided   Poisson …
#> 
#> $multi_metric_tbl
#> # A tibble: 4 × 8
#>   dist_type  abs_tot_deviance aic_value abs_aic ks_statistic ks_pvalue ks_method
#>   <fct>                 <dbl>     <dbl>   <dbl>        <dbl>     <dbl> <chr>    
#> 1 Hypergeom…           0.0497      NaN     NaN         0.438  0.00450  Monte-Ca…
#> 2 Poisson c…           0.842       210.    210.        0.188  0.654    Monte-Ca…
#> 3 Geometric…           3.16        258.    258.        0.438  0.00500  Monte-Ca…
#> 4 Binomial …           3.48        Inf     Inf         0.625  0.000500 Monte-Ca…
#> # ℹ 1 more variable: alternative <chr>
#> 
#> attr(,".x")
#>  [1] 21 21 22 21 18 18 14 24 22 19 17 16 17 15 10 10 14 32 30 33 21 15 15 13 19
#> [26] 27 26 30 15 19 15 21
#> attr(,".n")
#> [1] 32
```
