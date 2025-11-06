# Augment Bootstrap P

Takes a numeric vector and will return the ecdf probability.

## Usage

``` r
bootstrap_p_augment(.data, .value, .names = "auto")
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

Takes a numeric vector and will return the ecdf probability of that
vector. This function is intended to be used on its own in order to add
columns to a tibble.

## See also

Other Augment Function:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md)

Other Bootstrap:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md),
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
  bootstrap_p_augment(y)
#> # A tibble: 50,000 × 3
#>    sim_number     y      p
#>    <fct>      <dbl>  <dbl>
#>  1 1           13.3 0.0944
#>  2 1           21.5 0.716 
#>  3 1           19.2 0.529 
#>  4 1           19.2 0.529 
#>  5 1           21.4 0.687 
#>  6 1           21.4 0.687 
#>  7 1           21   0.625 
#>  8 1           15.5 0.279 
#>  9 1           17.3 0.376 
#> 10 1           15.2 0.249 
#> # ℹ 49,990 more rows
```
