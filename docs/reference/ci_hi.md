# Confidence Interval Generic

Gets the upper 97.5% quantile of a numeric vector.

## Usage

``` r
ci_hi(.x, .na_rm = FALSE)
```

## Arguments

- .x:

  A vector of numeric values

- .na_rm:

  A Boolean, defaults to FALSE. Passed to the quantile function.

## Value

A numeric value.

## Details

Gets the upper 97.5% quantile of a numeric vector.

## See also

Other Statistic:
[`ci_lo()`](https://www.spsanderson.com/TidyDensity/reference/ci_lo.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_range_statistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_range_statistic.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md),
[`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg
ci_hi(x)
#> [1] 32.7375
```
