
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
#>    sim_number     x        y    dx       dy         p        q
#>    <fct>      <int>    <dbl> <dbl>    <dbl>     <dbl>    <dbl>
#>  1 1              1  0.963   -3.71 0.000254 0         -Inf    
#>  2 1              2 -0.192   -3.58 0.000729 0           -2.05 
#>  3 1              3  0.758   -3.45 0.00182  0           -1.74 
#>  4 1              4 -0.00266 -3.31 0.00394  0           -1.54 
#>  5 1              5 -0.00543 -3.18 0.00740  0           -1.39 
#>  6 1              6 -0.204   -3.05 0.0121   0           -1.27 
#>  7 1              7 -0.788   -2.92 0.0171   0           -1.16 
#>  8 1              8  0.594   -2.78 0.0211   4.18e-284   -1.07 
#>  9 1              9 -1.51    -2.65 0.0227   1.11e-253   -0.981
#> 10 1             10 -0.0337  -2.52 0.0213   5.45e-225   -0.901
#> # ... with 40 more rows
tidy_beta()
#> # A tibble: 50 x 7
#>    sim_number     x      y      dx      dy     p      q
#>    <fct>      <int>  <dbl>   <dbl>   <dbl> <dbl>  <dbl>
#>  1 1              1 0.347  -0.311  0.00441     0 0     
#>  2 1              2 0.247  -0.279  0.0102      0 0.0204
#>  3 1              3 0.118  -0.246  0.0220      0 0.0408
#>  4 1              4 0.444  -0.214  0.0439      0 0.0612
#>  5 1              5 0.631  -0.182  0.0814      0 0.0816
#>  6 1              6 0.151  -0.149  0.140       0 0.102 
#>  7 1              7 0.755  -0.117  0.225       0 0.122 
#>  8 1              8 0.269  -0.0843 0.338       0 0.143 
#>  9 1              9 0.0636 -0.0518 0.475       0 0.163 
#> 10 1             10 0.769  -0.0194 0.628       0 0.184 
#> # ... with 40 more rows
tidy_gamma()
#> # A tibble: 50 x 7
#>    sim_number     x       y      dx      dy     p      q
#>    <fct>      <int>   <dbl>   <dbl>   <dbl> <dbl>  <dbl>
#>  1 1              1 1.88    -1.15   0.00206     0 0     
#>  2 1              2 0.774   -0.998  0.00654     0 0.0206
#>  3 1              3 2.63    -0.849  0.0180      0 0.0417
#>  4 1              4 0.345   -0.701  0.0429      0 0.0632
#>  5 1              5 0.0893  -0.552  0.0890      0 0.0852
#>  6 1              6 0.905   -0.403  0.161       0 0.108 
#>  7 1              7 2.35    -0.255  0.254       0 0.131 
#>  8 1              8 0.0225  -0.106  0.354       0 0.154 
#>  9 1              9 0.00162  0.0425 0.436       0 0.178 
#> 10 1             10 1.19     0.191  0.483       0 0.203 
#> # ... with 40 more rows
tidy_poisson()
#> # A tibble: 50 x 7
#>    sim_number     x     y      dx      dy     p     q
#>    <fct>      <int> <int>   <dbl>   <dbl> <dbl> <dbl>
#>  1 1              1     0 -1.37   0.00355     0     0
#>  2 1              2     1 -1.21   0.00942     0     0
#>  3 1              3     1 -1.05   0.0222      0     0
#>  4 1              4     1 -0.892  0.0465      0     0
#>  5 1              5     0 -0.734  0.0864      0     0
#>  6 1              6     0 -0.577  0.143       0     0
#>  7 1              7     1 -0.419  0.209       0     0
#>  8 1              8     1 -0.261  0.275       0     0
#>  9 1              9     1 -0.103  0.325       0     0
#> 10 1             10     2  0.0545 0.352       0     0
#> # ... with 40 more rows
```

An example plot of the `tidy_normal` data.

``` r
library(dplyr)
library(ggplot2)

tn <- tidy_normal(.num_sims = 30)
tn_mean <- tn %>%
  summarise(grp_mean = mean(y, na.rm = TRUE))

p1 <- tn %>%
  ggplot(aes(x = y, group = sim_number, color = sim_number)) +
  geom_density() + 
  geom_vline(data = tn_mean, aes(xintercept = grp_mean),
             linetype ="dashed", color = "black") +
  theme_minimal() + 
  theme(legend.position = "none") + 
  labs(
    title = "Density Distribution", 
    subtitle = paste0(
      "Simulations: ", attributes(tn)$.num_sims, 
      " - mu: ", attributes(tn)$.mean, 
      " - sd: ", attributes(tn)$.sd, 
      " - Random Points: ", attributes(tn)$.n
    ),
    color = "Simulation",
    x = "x",
    y = "Density"
  )

p1
```

<img src="man/figures/README-plot_density-1.png" width="100%" />
