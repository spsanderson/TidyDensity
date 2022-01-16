
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

rand <- tidy_rnorm(.n = 100, .num_walks = 30)
head(rand)
#> # A tibble: 6 x 3
#>   rand_walk     x      y
#>   <fct>     <int>  <dbl>
#> 1 1             1 -0.448
#> 2 1             2  0.574
#> 3 1             3  0.800
#> 4 1             4  1.23 
#> 5 1             5 -0.921
#> 6 1             6  1.35
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

rand %>%
  ggplot(mapping = aes(x = y, group = rand_walk, color = rand_walk)) +
  geom_density() +
  theme_minimal() +
  labs(
      title = "Plot of rand",
      color = "Simulation"
  ) +
  theme(legend.position = "none")
```

<img src="man/figures/README-plot_density-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
