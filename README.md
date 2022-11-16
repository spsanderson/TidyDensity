
<!-- README.md is generated from README.Rmd. Please edit that file -->

# TidyDensity <img src="man/figures/tidy_density_logo.png" width="147" height="170" align="right" />

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/TidyDensity)](https://cran.r-project.org/package=TidyDensity)
![](https://cranlogs.r-pkg.org/badges/TidyDensity)
![](https://cranlogs.r-pkg.org/badges/grand-total/TidyDensity)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html##stable)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://makeapullrequest.com)
<!-- badges: end -->

The goal of `{TidyDensity}` is to make working with random numbers from
different distributions easy. All `tidy_` distribution functions provide
the following components:

- \[`r_`\]
- \[`d_`\]
- \[`q_`\]
- \[`p_`\]

## Installation

You can install the released version of `{TidyDensity}` from
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
#> # A tibble: 50 × 7
#>    sim_number     x       y    dx       dy      p       q
#>    <fct>      <int>   <dbl> <dbl>    <dbl>  <dbl>   <dbl>
#>  1 1              1  1.27   -3.47 0.000336 0.899   1.27  
#>  2 1              2  1.18   -3.33 0.000903 0.881   1.18  
#>  3 1              3 -0.955  -3.20 0.00217  0.170  -0.955 
#>  4 1              4  0.909  -3.06 0.00463  0.818   0.909 
#>  5 1              5 -0.0293 -2.92 0.00884  0.488  -0.0293
#>  6 1              6  0.631  -2.79 0.0151   0.736   0.631 
#>  7 1              7 -1.35   -2.65 0.0230   0.0882 -1.35  
#>  8 1              8 -0.930  -2.52 0.0316   0.176  -0.930 
#>  9 1              9  0.487  -2.38 0.0393   0.687   0.487 
#> 10 1             10  0.635  -2.24 0.0447   0.737   0.635 
#> # … with 40 more rows
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
