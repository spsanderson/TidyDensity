
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

tn <- tidy_normal(.n = 100, .num_sims = 30)
head(tn)
#> # A tibble: 6 x 6
#>   sim_number     x      y d_norm p_norm  q_norm
#>   <fct>      <int>  <dbl>  <dbl>  <dbl>   <dbl>
#> 1 1              1  0.438  0.362      0 -Inf   
#> 2 1              2 -0.439  0.362      0   -2.32
#> 3 1              3 -1.28   0.175      0   -2.05
#> 4 1              4  1.66   0.101      0   -1.88
#> 5 1              5  0.769  0.297      0   -1.75
#> 6 1              6  0.219  0.389      0   -1.64
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

``` r
library(dplyr)
library(ggplot2)

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

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
