
<!-- README.md is generated from README.Rmd. Please edit that file -->

# TidyDensity <img src="man/figures/logo.png" width="147" height="170" align="right" />

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
#>    sim_number     x       y    dx       dy     p       q
#>    <fct>      <int>   <dbl> <dbl>    <dbl> <dbl>   <dbl>
#>  1 1              1  1.69   -2.91 0.000292 0.954  1.69  
#>  2 1              2  0.323  -2.78 0.000855 0.627  0.323 
#>  3 1              3 -0.880  -2.65 0.00222  0.189 -0.880 
#>  4 1              4  2.09   -2.53 0.00511  0.982  2.09  
#>  5 1              5  0.226  -2.40 0.0105   0.589  0.226 
#>  6 1              6  0.125  -2.27 0.0194   0.550  0.125 
#>  7 1              7 -0.719  -2.14 0.0324   0.236 -0.719 
#>  8 1              8  0.0652 -2.01 0.0494   0.526  0.0652
#>  9 1              9  1.55   -1.88 0.0694   0.940  1.55  
#> 10 1             10  0.232  -1.75 0.0916   0.592  0.232 
#> # ℹ 40 more rows
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
