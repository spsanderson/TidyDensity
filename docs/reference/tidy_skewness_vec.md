# Compute Skewness of a Vector

This function takes in a vector as it's input and will return the
skewness of that vector. The length of this vector must be at least four
numbers. The skewness explains the 'tailedness' of the distribution of
data.

`((1/n) * sum(x - mu})^3) / ((()1/n) * sum(x - mu)^2)^(3/2)`

## Usage

``` r
tidy_skewness_vec(.x)
```

## Arguments

- .x:

  A numeric vector of length four or more.

## Value

The skewness of a vector

## Details

A function to return the skewness of a vector.

## See also

<https://en.wikipedia.org/wiki/Skewness>

Other Statistic:
[`ci_hi()`](https://www.spsanderson.com/TidyDensity/reference/ci_hi.md),
[`ci_lo()`](https://www.spsanderson.com/TidyDensity/reference/ci_lo.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_range_statistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_range_statistic.md),
[`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)

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
[`cvar()`](https://www.spsanderson.com/TidyDensity/reference/cvar.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_scale_zero_one_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_scale_zero_one_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_skewness_vec(rnorm(100, 3, 2))
#> [1] 0.1751819
```
