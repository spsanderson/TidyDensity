# Bootstrap Density Tibble

Add density information to the output of
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md),
and
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md).

## Usage

``` r
bootstrap_density_augment(.data)
```

## Arguments

- .data:

  The data that is passed from the
  [`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
  or
  [`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md)
  functions.

## Value

A tibble

## Details

This function takes as input the output of the
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
or
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md)
and returns an augmented tibble that has the following columns added to
it: *`x`*, *`y`*, *`dx`*, and *`dy`*.

It looks for an attribute that comes from using
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
or
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md)
so it will not work unless the data comes from one of those functions.

## See also

Other Bootstrap:
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md),
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md),
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md),
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)

Other Augment Function:
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

tidy_bootstrap(x) |>
  bootstrap_density_augment()
#> # A tibble: 50,000 × 5
#>    sim_number     x     y    dx       dy
#>    <fct>      <int> <dbl> <dbl>    <dbl>
#>  1 1              1  16.4  6.48 0.000408
#>  2 1              2  15    7.33 0.00230 
#>  3 1              3  18.7  8.17 0.00853 
#>  4 1              4  18.1  9.01 0.0209  
#>  5 1              5  10.4  9.86 0.0340  
#>  6 1              6  10.4 10.7  0.0376  
#>  7 1              7  15   11.5  0.0313  
#>  8 1              8  21.4 12.4  0.0275  
#>  9 1              9  18.1 13.2  0.0357  
#> 10 1             10  22.8 14.1  0.0541  
#> # ℹ 49,990 more rows

tidy_bootstrap(x) |>
  bootstrap_unnest_tbl() |>
  bootstrap_density_augment()
#> # A tibble: 50,000 × 5
#>    sim_number     x     y    dx       dy
#>    <fct>      <int> <dbl> <dbl>    <dbl>
#>  1 1              1  19.2  6.59 0.000140
#>  2 1              2  26    7.89 0.00177 
#>  3 1              3  22.8  9.18 0.00794 
#>  4 1              4  15   10.5  0.0126  
#>  5 1              5  19.2 11.8  0.00749 
#>  6 1              6  21   13.1  0.00546 
#>  7 1              7  21   14.4  0.0133  
#>  8 1              8  17.3 15.7  0.0271  
#>  9 1              9  10.4 17.0  0.0571  
#> 10 1             10  18.1 18.3  0.0946  
#> # ℹ 49,990 more rows
```
