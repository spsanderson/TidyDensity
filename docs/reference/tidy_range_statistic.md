# Get the range statistic

Takes in a numeric vector and returns back the range of that vector

## Usage

``` r
tidy_range_statistic(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A single number, the range statistic

## Details

Takes in a numeric vector and returns the range of that vector using the
`diff` and `range` functions.

## See also

Other Statistic:
[`ci_hi()`](https://www.spsanderson.com/TidyDensity/reference/ci_hi.md),
[`ci_lo()`](https://www.spsanderson.com/TidyDensity/reference/ci_lo.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md),
[`tidy_stat_tbl()`](https://www.spsanderson.com/TidyDensity/reference/tidy_stat_tbl.md)

## Author

Steven P. Sandeson II, MPH

## Examples

``` r
tidy_range_statistic(seq(1:10))
#> [1] 9
```
