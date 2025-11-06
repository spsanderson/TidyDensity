# Cumulative Standard Deviation

A function to return the cumulative standard deviation of a vector.

## Usage

``` r
csd(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector. Note: The first entry will always be NaN.

## Details

A function to return the cumulative standard deviation of a vector.

## See also

Other Vector Function:
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`cgmean()`](https://www.spsanderson.com/TidyDensity/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/TidyDensity/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/TidyDensity/reference/ckurtosis.md),
[`cmean()`](https://www.spsanderson.com/TidyDensity/reference/cmean.md),
[`cmedian()`](https://www.spsanderson.com/TidyDensity/reference/cmedian.md),
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

csd(x)
#>  [1]       NaN 0.0000000 1.0392305 0.8544004 1.4737707 1.7663522 2.8445436
#>  [8] 3.1302385 3.0524580 2.9070986 2.8647069 2.9366416 2.8975233 3.0252418
#> [15] 3.7142967 4.1476098 4.1046423 5.2332053 5.7405452 6.4594362 6.3029736
#> [22] 6.2319940 6.1698105 6.1772007 6.0474457 6.1199296 6.1188444 6.3166405
#> [29] 6.2611772 6.1530527 6.1217574 6.0269481
```
