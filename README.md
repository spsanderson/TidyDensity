
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
library(dplyr)
library(ggplot2)

tidy_normal()
#> # A tibble: 50 x 7
#>    sim_number     x      y    dx       dy         p        q
#>    <fct>      <int>  <dbl> <dbl>    <dbl>     <dbl>    <dbl>
#>  1 1              1  0.907 -2.99 0.000310 0         -Inf    
#>  2 1              2 -0.337 -2.86 0.000996 0           -2.05 
#>  3 1              3  1.70  -2.73 0.00276  0           -1.74 
#>  4 1              4 -0.173 -2.59 0.00660  0           -1.54 
#>  5 1              5  1.66  -2.46 0.0137   0           -1.39 
#>  6 1              6  1.42  -2.33 0.0249   0           -1.27 
#>  7 1              7 -1.67  -2.20 0.0400   0           -1.16 
#>  8 1              8  0.253 -2.07 0.0575   4.18e-284   -1.07 
#>  9 1              9 -0.473 -1.94 0.0756   1.11e-253   -0.981
#> 10 1             10  0.410 -1.80 0.0933   5.45e-225   -0.901
#> # ... with 40 more rows
```

An example plot of the `tidy_normal` data.

``` r
tn <- tidy_normal(.n = 100, .num_sims = 6)

tidy_autoplot(tn, .plot_type = "density")
```

<img src="man/figures/README-plot_density-1.png" width="100%" />

``` r
tidy_autoplot(tn, .plot_type = "quantile")
```

<img src="man/figures/README-plot_density-2.png" width="100%" />

``` r
tidy_autoplot(tn, .plot_type = "probability")
```

<img src="man/figures/README-plot_density-3.png" width="100%" />

``` r
tidy_autoplot(tn, .plot_type = "qq")
```

<img src="man/figures/README-plot_density-4.png" width="100%" />

We can also take a look at the plots when the number of simulations is
greater than nine. This will automatically turn off the legend as it
will become too noisy.

``` r
tn <- tidy_normal(.n = 100, .num_sims = 20)

tidy_autoplot(tn, .plot_type = "density")
```

<img src="man/figures/README-more_than_nine_simulations-1.png" width="100%" />

``` r
tidy_autoplot(tn, .plot_type = "quantile")
```

<img src="man/figures/README-more_than_nine_simulations-2.png" width="100%" />

``` r
tidy_autoplot(tn, .plot_type = "probability")
```

<img src="man/figures/README-more_than_nine_simulations-3.png" width="100%" />

``` r
tidy_autoplot(tn, .plot_type = "qq")
```

<img src="man/figures/README-more_than_nine_simulations-4.png" width="100%" />
