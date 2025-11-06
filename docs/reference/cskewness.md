# Cumulative Skewness

A function to return the cumulative skewness of a vector.

## Usage

``` r
cskewness(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative skewness of a vector.

## See also

Other Vector Function:
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`cgmean()`](https://www.spsanderson.com/TidyDensity/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/TidyDensity/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/TidyDensity/reference/ckurtosis.md),
[`cmean()`](https://www.spsanderson.com/TidyDensity/reference/cmean.md),
[`cmedian()`](https://www.spsanderson.com/TidyDensity/reference/cmedian.md),
[`csd()`](https://www.spsanderson.com/TidyDensity/reference/csd.md),
[`cvar()`](https://www.spsanderson.com/TidyDensity/reference/cvar.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_scale_zero_one_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_scale_zero_one_vec.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

cskewness(x)
#>  [1]          NaN          NaN  0.707106781  0.997869718 -0.502052297
#>  [6] -0.258803244 -0.867969171 -0.628239920 -0.808101715 -0.695348960
#> [11] -0.469220594 -0.256323338 -0.091505282  0.002188142 -0.519593266
#> [16] -0.512660692 -0.379598706  0.614549281  0.581410573  0.649357202
#> [21]  0.631855977  0.706212631  0.775750182  0.821447605  0.844413861
#> [26]  0.716010069  0.614326432  0.525141032  0.582528820  0.601075783
#> [31]  0.652552397  0.640439864
```
