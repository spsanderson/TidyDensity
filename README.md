
<!-- README.md is generated from README.Rmd. Please edit that file -->

# TidyDensity <img src="man/figures/tidy_density_logo.png" width="147" height="170" align="right" />

<!-- badges: start -->
<!--[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/TidyDensity)](https://cran.r-project.org/package=TidyDensity) -->

![](https://cranlogs.r-pkg.org/badges/TidyDensity)
![](https://cranlogs.r-pkg.org/badges/grand-total/TidyDensity)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html##experimental)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://makeapullrequest.com)
<!-- badges: end -->

The goal of TidyDensity is to …

## Installation

You can install the released version of TidyDensity from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("TidyDensity")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("spsanderson/TidyDensity")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(TidyDensity)

tidy_normal()
#> # A tibble: 50 x 7
#>    sim_number     x       y    dx       dy         p        q
#>    <fct>      <int>   <dbl> <dbl>    <dbl>     <dbl>    <dbl>
#>  1 1              1  0.215  -4.41 0.000224 0         -Inf    
#>  2 1              2  0.0509 -4.26 0.000622 0           -2.05 
#>  3 1              3  0.614  -4.12 0.00151  0           -1.74 
#>  4 1              4 -0.438  -3.97 0.00322  0           -1.54 
#>  5 1              5 -0.183  -3.83 0.00602  0           -1.39 
#>  6 1              6  0.709  -3.68 0.00987  0           -1.27 
#>  7 1              7  0.345  -3.54 0.0142   0           -1.16 
#>  8 1              8 -1.08   -3.39 0.0180   4.18e-284   -1.07 
#>  9 1              9  1.08   -3.25 0.0201   1.11e-253   -0.981
#> 10 1             10  0.405  -3.10 0.0199   5.45e-225   -0.901
#> # ... with 40 more rows
tidy_beta()
#> # A tibble: 50 x 7
#>    sim_number     x      y       dx      dy     p      q
#>    <fct>      <int>  <dbl>    <dbl>   <dbl> <dbl>  <dbl>
#>  1 1              1 0.736  -0.296   0.00107     0 0     
#>  2 1              2 0.246  -0.263   0.00264     0 0.0204
#>  3 1              3 0.818  -0.231   0.00600     0 0.0408
#>  4 1              4 0.222  -0.198   0.0126      0 0.0612
#>  5 1              5 0.313  -0.165   0.0246      0 0.0816
#>  6 1              6 0.510  -0.132   0.0446      0 0.102 
#>  7 1              7 0.695  -0.0997  0.0754      0 0.122 
#>  8 1              8 0.207  -0.0669  0.120       0 0.143 
#>  9 1              9 0.0310 -0.0342  0.179       0 0.163 
#> 10 1             10 0.250  -0.00140 0.254       0 0.184 
#> # ... with 40 more rows
tidy_gamma()
#> # A tibble: 50 x 7
#>    sim_number     x     y      dx      dy     p      q
#>    <fct>      <int> <dbl>   <dbl>   <dbl> <dbl>  <dbl>
#>  1 1              1 1.84  -0.604  0.00136     0 0     
#>  2 1              2 0.441 -0.494  0.00604     0 0.0206
#>  3 1              3 0.660 -0.383  0.0215      0 0.0417
#>  4 1              4 3.20  -0.273  0.0622      0 0.0632
#>  5 1              5 1.54  -0.163  0.147       0 0.0852
#>  6 1              6 0.316 -0.0527 0.287       0 0.108 
#>  7 1              7 0.432  0.0575 0.473       0 0.131 
#>  8 1              8 0.512  0.168  0.666       0 0.154 
#>  9 1              9 4.08   0.278  0.816       0 0.178 
#> 10 1             10 1.38   0.388  0.880       0 0.203 
#> # ... with 40 more rows
tidy_poisson()
#> # A tibble: 50 x 7
#>    sim_number     x     y     dx      dy     p     q
#>    <fct>      <int> <int>  <dbl>   <dbl> <dbl> <dbl>
#>  1 1              1     3 -1.17  0.00437     0     0
#>  2 1              2     3 -1.06  0.00970     0     0
#>  3 1              3     1 -0.951 0.0199      0     0
#>  4 1              4     1 -0.842 0.0378      0     0
#>  5 1              5     2 -0.733 0.0665      0     0
#>  6 1              6     2 -0.624 0.108       0     0
#>  7 1              7     0 -0.515 0.163       0     0
#>  8 1              8     2 -0.406 0.227       0     0
#>  9 1              9     1 -0.297 0.292       0     0
#> 10 1             10     1 -0.189 0.350       0     0
#> # ... with 40 more rows
```

An example plot of the `tidy_normal` data.

``` r
library(dplyr)
library(ggplot2)

tn <- tidy_normal(.num_sims = 30)
tg <- tidy_gamma(.num_sims = 9)
tb <- tidy_beta(.num_sims = 5)
tp <- tidy_poisson()

tidy_autoplot(tn, .plot_type = "density")
```

<img src="man/figures/README-plot_density-1.png" width="100%" />

``` r
tidy_autoplot(tg, .plot_type = "quantile")
```

<img src="man/figures/README-plot_density-2.png" width="100%" />

``` r
tidy_autoplot(tb, .plot_type = "probability")
```

<img src="man/figures/README-plot_density-3.png" width="100%" />

``` r
tidy_autoplot(tp, .plot_type = "qq")
```

<img src="man/figures/README-plot_density-4.png" width="100%" />
