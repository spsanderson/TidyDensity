# Cumulative Harmonic Mean

A function to return the cumulative harmonic mean of a vector.

## Usage

``` r
chmean(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative harmonic mean of a vector.
`1 / (cumsum(1 / .x))`

## See also

Other Vector Function:
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`cgmean()`](https://www.spsanderson.com/TidyDensity/reference/cgmean.md),
[`ckurtosis()`](https://www.spsanderson.com/TidyDensity/reference/ckurtosis.md),
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

chmean(x)
#>  [1] 21.0000000 10.5000000  7.1891892  5.3813575  4.1788087  3.3949947
#>  [7]  2.7436247  2.4663044  2.2255626  1.9943841  1.7934398  1.6166494
#> [13]  1.4784877  1.3474251  1.1928760  1.0701322  0.9975150  0.9677213
#> [19]  0.9378663  0.9126181  0.8754572  0.8286539  0.7858140  0.7419753
#> [25]  0.7143688  0.6961523  0.6779989  0.6632076  0.6364908  0.6165699
#> [31]  0.5922267  0.5762786
```
