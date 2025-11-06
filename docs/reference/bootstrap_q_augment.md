# Augment Bootstrap Q

Takes a numeric vector and will return the quantile.

## Usage

``` r
bootstrap_q_augment(.data, .value, .names = "auto")
```

## Arguments

- .data:

  The data being passed that will be augmented by the function.

- .value:

  This is passed
  [`rlang::enquo()`](https://rlang.r-lib.org/reference/enquo.html) to
  capture the vectors you want to augment.

- .names:

  The default is "auto"

## Value

A augmented tibble

## Details

Takes a numeric vector and will return the quantile of that vector. This
function is intended to be used on its own in order to add columns to a
tibble.

## See also

Other Augment Function:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md)

Other Bootstrap:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md),
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md),
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md),
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

tidy_bootstrap(x) |>
  bootstrap_unnest_tbl() |>
  bootstrap_q_augment(y)
#> # A tibble: 50,000 × 3
#>    sim_number     y     q
#>    <fct>      <dbl> <dbl>
#>  1 1           18.1  10.4
#>  2 1           21    10.4
#>  3 1           30.4  10.4
#>  4 1           21.4  10.4
#>  5 1           15    10.4
#>  6 1           18.1  10.4
#>  7 1           21.4  10.4
#>  8 1           16.4  10.4
#>  9 1           24.4  10.4
#> 10 1           22.8  10.4
#> # ℹ 49,990 more rows
```
