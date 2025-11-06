# Compute Bootstrap Q of a Vector

This function takes in a vector as it's input and will return the
quantile of a vector.

## Usage

``` r
bootstrap_q_vec(.x)
```

## Arguments

- .x:

  A numeric

## Value

A vector

## Details

A function to return the quantile of a vector.

## See also

Other Bootstrap:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md),
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md),
[`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md),
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md),
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)

Other Vector Function:
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
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

bootstrap_q_vec(x)
#>  [1] 10.4 10.4 13.3 14.3 14.7 15.0 15.2 15.2 15.5 15.8 16.4 17.3 17.8 18.1 18.7
#> [16] 19.2 19.2 19.7 21.0 21.0 21.4 21.4 21.5 22.8 22.8 24.4 26.0 27.3 30.4 30.4
#> [31] 32.4 33.9
```
