# Compute Bootstrap P of a Vector

This function takes in a vector as it's input and will return the ecdf
probability of a vector.

## Usage

``` r
bootstrap_p_vec(.x)
```

## Arguments

- .x:

  A numeric

## Value

A vector

## Details

A function to return the ecdf probability of a vector.

## See also

Other Bootstrap:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md),
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md),
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)

Other Vector Function:
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
[`tidy_scale_zero_one_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_scale_zero_one_vec.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg
bootstrap_p_vec(x)
#>  [1] 0.62500 0.62500 0.78125 0.68750 0.46875 0.43750 0.12500 0.81250 0.78125
#> [10] 0.53125 0.40625 0.34375 0.37500 0.25000 0.06250 0.06250 0.15625 0.96875
#> [19] 0.93750 1.00000 0.71875 0.28125 0.25000 0.09375 0.53125 0.87500 0.84375
#> [28] 0.93750 0.31250 0.56250 0.18750 0.68750
```
