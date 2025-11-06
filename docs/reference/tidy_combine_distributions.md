# Combine Multiple Tidy Distributions of Different Types

This allows a user to specify any `n` number of `tidy_` distributions
that can be combined into a single tibble. This is the preferred method
for combining multiple distributions of different types, for example a
Gaussian distribution and a Beta distribution.

This generates a single tibble with an added column of dist_type that
will give the distribution family name and its associated parameters.

## Usage

``` r
tidy_combine_distributions(...)
```

## Arguments

- ...:

  The `...` is where you can place your different distributions

## Value

A tibble

## Details

Allows a user to generate a tibble of different `tidy_` distributions

## See also

Other Multiple Distribution:
[`tidy_multi_single_dist()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_single_dist.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tn <- tidy_normal()
tb <- tidy_beta()
tc <- tidy_cauchy()

tidy_combine_distributions(tn, tb, tc)
#> # A tibble: 150 × 8
#>    sim_number     x      y    dx       dy      p      q dist_type       
#>    <fct>      <int>  <dbl> <dbl>    <dbl>  <dbl>  <dbl> <fct>           
#>  1 1              1  0.623 -3.34 0.000289 0.734   0.623 Gaussian c(0, 1)
#>  2 1              2  0.461 -3.20 0.000969 0.678   0.461 Gaussian c(0, 1)
#>  3 1              3  0.549 -3.07 0.00268  0.709   0.549 Gaussian c(0, 1)
#>  4 1              4  2.24  -2.94 0.00615  0.987   2.24  Gaussian c(0, 1)
#>  5 1              5 -1.30  -2.80 0.0117   0.0965 -1.30  Gaussian c(0, 1)
#>  6 1              6 -1.01  -2.67 0.0184   0.156  -1.01  Gaussian c(0, 1)
#>  7 1              7  0.522 -2.54 0.0240   0.699   0.522 Gaussian c(0, 1)
#>  8 1              8 -0.197 -2.40 0.0260   0.422  -0.197 Gaussian c(0, 1)
#>  9 1              9  1.27  -2.27 0.0235   0.898   1.27  Gaussian c(0, 1)
#> 10 1             10  0.542 -2.14 0.0182   0.706   0.542 Gaussian c(0, 1)
#> # ℹ 140 more rows

## OR

tidy_combine_distributions(
  tidy_normal(),
  tidy_beta(),
  tidy_cauchy(),
  tidy_logistic()
)
#> # A tibble: 200 × 8
#>    sim_number     x      y    dx       dy      p      q dist_type       
#>    <fct>      <int>  <dbl> <dbl>    <dbl>  <dbl>  <dbl> <fct>           
#>  1 1              1 -0.277 -3.57 0.000264 0.391  -0.277 Gaussian c(0, 1)
#>  2 1              2 -0.881 -3.43 0.000827 0.189  -0.881 Gaussian c(0, 1)
#>  3 1              3  0.733 -3.29 0.00219  0.768   0.733 Gaussian c(0, 1)
#>  4 1              4 -0.365 -3.15 0.00493  0.358  -0.365 Gaussian c(0, 1)
#>  5 1              5 -0.238 -3.02 0.00941  0.406  -0.238 Gaussian c(0, 1)
#>  6 1              6 -1.68  -2.88 0.0154   0.0467 -1.68  Gaussian c(0, 1)
#>  7 1              7  1.28  -2.74 0.0217   0.899   1.28  Gaussian c(0, 1)
#>  8 1              8 -0.736 -2.60 0.0273   0.231  -0.736 Gaussian c(0, 1)
#>  9 1              9  0.139 -2.46 0.0324   0.555   0.139 Gaussian c(0, 1)
#> 10 1             10 -0.160 -2.33 0.0390   0.436  -0.160 Gaussian c(0, 1)
#> # ℹ 190 more rows
```
