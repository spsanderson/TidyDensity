# Cumulative Kurtosis

A function to return the cumulative kurtosis of a vector.

## Usage

``` r
ckurtosis(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative kurtosis of a vector.

## See also

Other Vector Function:
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`cgmean()`](https://www.spsanderson.com/TidyDensity/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/TidyDensity/reference/chmean.md),
[`cmean()`](https://www.spsanderson.com/TidyDensity/reference/cmean.md),
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

ckurtosis(x)
#>  [1]      NaN      NaN 1.500000 2.189216 2.518932 1.786006 2.744467 2.724675
#>  [9] 2.930885 2.988093 2.690270 2.269038 2.176622 1.992044 2.839430 2.481896
#> [17] 2.356826 3.877115 3.174702 2.896931 3.000743 3.091225 3.182071 3.212816
#> [25] 3.352916 3.015952 2.837139 2.535185 2.595908 2.691103 2.738468 2.799467
```
