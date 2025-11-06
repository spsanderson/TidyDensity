# Cumulative Mean

A function to return the cumulative mean of a vector.

## Usage

``` r
cmean(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative mean of a vector. It uses
[`dplyr::cummean()`](https://dplyr.tidyverse.org/reference/cumall.html)
as the basis of the function.

## See also

Other Vector Function:
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`cgmean()`](https://www.spsanderson.com/TidyDensity/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/TidyDensity/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/TidyDensity/reference/ckurtosis.md),
[`cmedian()`](https://www.spsanderson.com/TidyDensity/reference/cmedian.md),
[`csd()`](https://www.spsanderson.com/TidyDensity/reference/csd.md),
[`cskewness()`](https://www.spsanderson.com/TidyDensity/reference/cskewness.md),
[`cvar()`](https://www.spsanderson.com/TidyDensity/reference/cvar.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_scale_zero_one_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_scale_zero_one_vec.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

cmean(x)
#>  [1] 21.00000 21.00000 21.60000 21.55000 20.98000 20.50000 19.61429 20.21250
#>  [9] 20.50000 20.37000 20.13636 19.82500 19.63077 19.31429 18.72000 18.20000
#> [17] 17.99412 18.79444 19.40526 20.13000 20.19524 19.98182 19.77391 19.50417
#> [25] 19.49200 19.79231 20.02222 20.39286 20.23448 20.21667 20.04839 20.09062
```
