# Tidy Empirical

This function takes in a single argument of .x a vector and will return
a tibble of information similar to the `tidy_` distribution functions.
The `y` column is set equal to `dy` from the density function.

## Usage

``` r
tidy_empirical(.x, .num_sims = 1, .distribution_type = "continuous")
```

## Arguments

- .x:

  A vector of numbers

- .num_sims:

  How many simulations should be run, defaults to 1.

- .distribution_type:

  A string of either "continuous" or "discrete". The function will
  default to "continuous"

## Value

A tibble

## Details

This function takes in a single argument of .x a vector

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg
tidy_empirical(.x = x, .distribution_type = "continuous")
#> # A tibble: 32 × 7
#>    sim_number     x     y    dx       dy     p     q
#>    <fct>      <int> <dbl> <dbl>    <dbl> <dbl> <dbl>
#>  1 1              1  21    2.97 0.000113 0.625  10.4
#>  2 1              2  21    4.21 0.000452 0.625  10.4
#>  3 1              3  22.8  5.44 0.00142  0.781  13.3
#>  4 1              4  21.4  6.68 0.00354  0.688  14.3
#>  5 1              5  18.7  7.92 0.00720  0.469  14.7
#>  6 1              6  18.1  9.16 0.0124   0.438  15  
#>  7 1              7  14.3 10.4  0.0192   0.125  15.2
#>  8 1              8  24.4 11.6  0.0281   0.812  15.2
#>  9 1              9  22.8 12.9  0.0395   0.781  15.5
#> 10 1             10  19.2 14.1  0.0515   0.531  15.8
#> # ℹ 22 more rows
tidy_empirical(.x = x, .num_sims = 10, .distribution_type = "continuous")
#> # A tibble: 320 × 7
#>    sim_number     x     y    dx        dy     p     q
#>    <fct>      <int> <dbl> <dbl>     <dbl> <dbl> <dbl>
#>  1 1              1  33.9  3.75 0.0000855 1      13.3
#>  2 1              2  33.9  5.03 0.000298  1      14.7
#>  3 1              3  33.9  6.31 0.000898  1      15  
#>  4 1              4  15.2  7.59 0.00235   0.25   15.2
#>  5 1              5  18.7  8.87 0.00536   0.469  15.2
#>  6 1              6  18.1 10.2  0.0107    0.438  15.2
#>  7 1              7  15   11.4  0.0188    0.188  15.5
#>  8 1              8  22.8 12.7  0.0294    0.781  17.8
#>  9 1              9  17.8 14.0  0.0410    0.406  17.8
#> 10 1             10  21.5 15.3  0.0518    0.719  18.1
#> # ℹ 310 more rows
```
