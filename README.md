
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

-   \[`r_`\]
-   \[`d_`\]
-   \[`q_`\]
-   \[`p_`\]

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
#> # A tibble: 50 x 7
#>    sim_number     x       y    dx       dy     p        q
#>    <fct>      <int>   <dbl> <dbl>    <dbl> <dbl>    <dbl>
#>  1 1              1  1.14   -3.19 0.000254 0.5     0.630 
#>  2 1              2 -0.0394 -3.06 0.000732 0.508  -0.0778
#>  3 1              3  0.451  -2.93 0.00186  0.516   0.201 
#>  4 1              4 -0.916  -2.79 0.00416  0.524  -0.610 
#>  5 1              5  0.453  -2.66 0.00828  0.533   0.202 
#>  6 1              6  0.576  -2.52 0.0149   0.541   0.274 
#>  7 1              7  2.31   -2.39 0.0245   0.549 Inf     
#>  8 1              8 -1.32   -2.25 0.0380   0.557  -0.919 
#>  9 1              9 -0.399  -2.12 0.0560   0.565  -0.285 
#> 10 1             10 -0.919  -1.98 0.0791   0.573  -0.612 
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
