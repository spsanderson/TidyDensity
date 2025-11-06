# Cumulative Variance

A function to return the cumulative variance of a vector.

## Usage

``` r
cvar(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector. Note: The first entry will always be NaN.

## Details

A function to return the cumulative variance of a vector.
`exp(cummean(log(.x)))`

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
[`cskewness()`](https://www.spsanderson.com/TidyDensity/reference/cskewness.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_scale_zero_one_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_scale_zero_one_vec.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

cvar(x)
#>  [1]       NaN  0.000000  1.080000  0.730000  2.172000  3.120000  8.091429
#>  [8]  9.798393  9.317500  8.451222  8.206545  8.623864  8.395641  9.152088
#> [15] 13.796000 17.202667 16.848088 27.386438 32.953860 41.724316 39.727476
#> [22] 38.837749 38.066561 38.157808 36.571600 37.453538 37.440256 39.899947
#> [29] 39.202340 37.860057 37.475914 36.324103
```
