# Tidy Distribution Summary Statistics Tibble

This function returns a summary statistics tibble. It will use the y
column from the `tidy_` distribution function.

## Usage

``` r
tidy_distribution_summary_tbl(.data, ...)
```

## Arguments

- .data:

  The data that is going to be passed from a a `tidy_` distribution
  function.

- ...:

  This is the grouping variable that gets passed to
  [`dplyr::group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)
  and
  [`dplyr::select()`](https://dplyr.tidyverse.org/reference/select.html).

## Value

A summary stats tibble

## Details

This function takes in a `tidy_` distribution table and will return a
tibble of the following information:

- `sim_number`

- `mean_val`

- `median_val`

- `std_val`

- `min_val`

- `max_val`

- `skewness`

- `kurtosis`

- `range`

- `iqr`

- `variance`

- `ci_hi`

- `ci_lo`

The kurtosis and skewness come from the package `healthyR.ai`

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

tn <- tidy_normal(.num_sims = 5)
tb <- tidy_beta(.num_sims = 5)

tidy_distribution_summary_tbl(tn)
#> # A tibble: 1 × 12
#>   mean_val median_val std_val min_val max_val skewness kurtosis range   iqr
#>      <dbl>      <dbl>   <dbl>   <dbl>   <dbl>    <dbl>    <dbl> <dbl> <dbl>
#> 1  -0.0102     0.0255    1.04   -3.80    3.30   -0.172     3.79  7.10  1.33
#> # ℹ 3 more variables: variance <dbl>, ci_low <dbl>, ci_high <dbl>
tidy_distribution_summary_tbl(tn, sim_number)
#> # A tibble: 5 × 13
#>   sim_number mean_val median_val std_val min_val max_val skewness kurtosis range
#>   <fct>         <dbl>      <dbl>   <dbl>   <dbl>   <dbl>    <dbl>    <dbl> <dbl>
#> 1 1            0.189      0.175    1.01    -1.86    3.30   0.528      3.76  5.15
#> 2 2            0.0784     0.0414   1.03    -2.99    2.40   0.0224     3.98  5.39
#> 3 3           -0.264     -0.421    1.08    -3.80    2.23  -0.214      4.17  6.04
#> 4 4            0.0206     0.110    1.07    -2.85    2.09  -0.483      3.00  4.93
#> 5 5           -0.0750     0.0389   0.960   -2.94    1.37  -0.704      3.29  4.31
#> # ℹ 4 more variables: iqr <dbl>, variance <dbl>, ci_low <dbl>, ci_high <dbl>

data_tbl <- tidy_combine_distributions(tn, tb)

tidy_distribution_summary_tbl(data_tbl)
#> # A tibble: 1 × 12
#>   mean_val median_val std_val min_val max_val skewness kurtosis range   iqr
#>      <dbl>      <dbl>   <dbl>   <dbl>   <dbl>    <dbl>    <dbl> <dbl> <dbl>
#> 1    0.236      0.301   0.801   -3.80    3.30   -0.888     6.04  7.10 0.712
#> # ℹ 3 more variables: variance <dbl>, ci_low <dbl>, ci_high <dbl>
tidy_distribution_summary_tbl(data_tbl, dist_type)
#> # A tibble: 2 × 13
#>   dist_type mean_val median_val std_val  min_val max_val skewness kurtosis range
#>   <fct>        <dbl>      <dbl>   <dbl>    <dbl>   <dbl>    <dbl>    <dbl> <dbl>
#> 1 Gaussian…  -0.0102     0.0255   1.04  -3.80      3.30   -0.172      3.79 7.10 
#> 2 Beta c(1…   0.483      0.490    0.304  0.00150   0.999   0.0216     1.62 0.997
#> # ℹ 4 more variables: iqr <dbl>, variance <dbl>, ci_low <dbl>, ci_high <dbl>
```
