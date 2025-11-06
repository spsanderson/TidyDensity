# Confidence Interval Generic

Gets the lower 2.5% quantile of a numeric vector.

## Usage

``` r
ci_lo(.x, .na_rm = FALSE)
```

## Arguments

- .x:

  A vector of numeric values

- .na_rm:

  A Boolean, defaults to FALSE. Passed to the quantile function.

## Value

A numeric value.

## Details

Gets the lower 2.5% quantile of a numeric vector.

## See also

Other Statistic:
[`ci_hi()`](https://www.spsanderson.com/TidyDensity/reference/ci_hi.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_range_statistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_range_statistic.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md),
[`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg
ci_lo(x)
#> [1] 10.4
```
