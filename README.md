
<!-- README.md is generated from README.Rmd. Please edit that file -->

# TidyDensity <img src="man/figures/tidy_density_logo.png" width="147" height="170" align="right" />

<!-- badges: start -->

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/TidyDensity)](https://cran.r-project.org/package=TidyDensity)
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
#>  1 1              1  0.454  -3.03 0.000288 0         -Inf    
#>  2 1              2  0.603  -2.89 0.000794 0           -2.05 
#>  3 1              3  0.0601 -2.75 0.00199  0           -1.74 
#>  4 1              4  1.44   -2.61 0.00452  0           -1.54 
#>  5 1              5  0.482  -2.47 0.00938  0           -1.39 
#>  6 1              6  0.790  -2.33 0.0178   0           -1.27 
#>  7 1              7  1.00   -2.19 0.0308   0           -1.16 
#>  8 1              8 -0.109  -2.05 0.0491   4.18e-284   -1.07 
#>  9 1              9 -0.311  -1.91 0.0722   1.11e-253   -0.981
#> 10 1             10  0.429  -1.77 0.0984   5.45e-225   -0.901
#> # ... with 40 more rows
tidy_beta()
#> # A tibble: 50 x 7
#>    sim_number     x      y      dx      dy     p      q
#>    <fct>      <int>  <dbl>   <dbl>   <dbl> <dbl>  <dbl>
#>  1 1              1 0.419  -0.326  0.00148     0 0     
#>  2 1              2 0.906  -0.292  0.00357     0 0.0204
#>  3 1              3 0.475  -0.258  0.00791     0 0.0408
#>  4 1              4 0.572  -0.224  0.0162      0 0.0612
#>  5 1              5 0.152  -0.190  0.0308      0 0.0816
#>  6 1              6 0.304  -0.156  0.0544      0 0.102 
#>  7 1              7 0.0300 -0.123  0.0898      0 0.122 
#>  8 1              8 0.898  -0.0888 0.139       0 0.143 
#>  9 1              9 0.979  -0.0549 0.204       0 0.163 
#> 10 1             10 0.250  -0.0211 0.283       0 0.184 
#> # ... with 40 more rows
tidy_gamma()
#> # A tibble: 50 x 7
#>    sim_number     x     y      dx      dy     p      q
#>    <fct>      <int> <dbl>   <dbl>   <dbl> <dbl>  <dbl>
#>  1 1              1 0.894 -1.05   0.00101     0 0     
#>  2 1              2 0.294 -0.918  0.00310     0 0.0206
#>  3 1              3 2.92  -0.782  0.00840     0 0.0417
#>  4 1              4 2.71  -0.647  0.0202      0 0.0632
#>  5 1              5 0.791 -0.511  0.0432      0 0.0852
#>  6 1              6 0.543 -0.375  0.0823      0 0.108 
#>  7 1              7 0.204 -0.240  0.141       0 0.131 
#>  8 1              8 0.627 -0.104  0.217       0 0.154 
#>  9 1              9 2.32   0.0315 0.304       0 0.178 
#> 10 1             10 0.188  0.167  0.389       0 0.203 
#> # ... with 40 more rows
tidy_poisson()
#> # A tibble: 50 x 7
#>    sim_number     x     y      dx      dy     p     q
#>    <fct>      <int> <int>   <dbl>   <dbl> <dbl> <dbl>
#>  1 1              1     2 -1.36   0.00454     0     0
#>  2 1              2     1 -1.20   0.0121      0     0
#>  3 1              3     1 -1.05   0.0285      0     0
#>  4 1              4     0 -0.890  0.0596      0     0
#>  5 1              5     0 -0.732  0.111       0     0
#>  6 1              6     2 -0.574  0.183       0     0
#>  7 1              7     0 -0.417  0.267       0     0
#>  8 1              8     1 -0.259  0.349       0     0
#>  9 1              9     2 -0.101  0.407       0     0
#> 10 1             10     1  0.0563 0.429       0     0
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
