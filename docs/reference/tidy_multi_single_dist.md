# Generate Multiple Tidy Distributions of a single type

Generate multiple distributions of data from the same `tidy_`
distribution function.

## Usage

``` r
tidy_multi_single_dist(.tidy_dist = NULL, .param_list = list())
```

## Arguments

- .tidy_dist:

  The type of `tidy_` distribution that you want to run. You can only
  choose one.

- .param_list:

  This must be a [`list()`](https://rdrr.io/r/base/list.html) object of
  the parameters that you want to pass through to the TidyDensity
  `tidy_` distribution function.

## Value

A tibble

## Details

Generate multiple distributions of data from the same `tidy_`
distribution function. This allows you to simulate multiple
distributions of the same family in order to view how shapes change with
parameter changes. You can then visualize the differences however you
choose.

## See also

Other Multiple Distribution:
[`tidy_combine_distributions()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combine_distributions.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_multi_single_dist(
  .tidy_dist = "tidy_normal",
  .param_list = list(
    .n = 50,
    .mean = c(-1, 0, 1),
    .sd = 1,
    .num_sims = 3,
    .return_tibble = TRUE
  )
)
#> # A tibble: 450 × 8
#>    sim_number dist_name             x       y    dx       dy      p       q
#>    <fct>      <fct>             <int>   <dbl> <dbl>    <dbl>  <dbl>   <dbl>
#>  1 1          Gaussian c(-1, 1)     1  0.357  -4.22 0.000288 0.913   0.357 
#>  2 1          Gaussian c(-1, 1)     2 -3.00   -4.09 0.000757 0.0228 -3.00  
#>  3 1          Gaussian c(-1, 1)     3 -0.0439 -3.96 0.00181  0.830  -0.0439
#>  4 1          Gaussian c(-1, 1)     4 -0.124  -3.82 0.00391  0.810  -0.124 
#>  5 1          Gaussian c(-1, 1)     5 -2.27   -3.69 0.00771  0.102  -2.27  
#>  6 1          Gaussian c(-1, 1)     6 -1.77   -3.56 0.0138   0.221  -1.77  
#>  7 1          Gaussian c(-1, 1)     7 -0.806  -3.43 0.0228   0.577  -0.806 
#>  8 1          Gaussian c(-1, 1)     8  0.144  -3.29 0.0344   0.874   0.144 
#>  9 1          Gaussian c(-1, 1)     9 -1.77   -3.16 0.0483   0.222  -1.77  
#> 10 1          Gaussian c(-1, 1)    10 -1.22   -3.03 0.0637   0.411  -1.22  
#> # ℹ 440 more rows

tidy_multi_single_dist(
  .tidy_dist = "tidy_normal",
  .param_list = list(
    .n = 50,
    .mean = c(-1, 0, 1),
    .sd = 1,
    .num_sims = 3,
    .return_tibble = FALSE
  )
)
#>      sim_number         dist_name     x          y        dx           dy
#>          <fctr>            <fctr> <int>      <num>     <num>        <num>
#>   1:          1 Gaussian c(-1, 1)     1  0.4617859 -4.060463 0.0002614114
#>   2:          1 Gaussian c(-1, 1)     2 -3.0128687 -3.920804 0.0008144278
#>   3:          1 Gaussian c(-1, 1)     3 -2.2554443 -3.781146 0.0021771523
#>   4:          1 Gaussian c(-1, 1)     4 -2.0803068 -3.641487 0.0050469049
#>   5:          1 Gaussian c(-1, 1)     5 -0.8246039 -3.501829 0.0102154133
#>  ---                                                                     
#> 446:          3  Gaussian c(1, 1)    46  0.2977894  4.367883 0.0105462026
#> 447:          3  Gaussian c(1, 1)    47  1.6898134  4.522903 0.0051379446
#> 448:          3  Gaussian c(1, 1)    48  0.9416369  4.677923 0.0022253846
#> 449:          3  Gaussian c(1, 1)    49  1.2775876  4.832942 0.0008545079
#> 450:          3  Gaussian c(1, 1)    50  0.1409854  4.987962 0.0002901496
#>               p          q
#>           <num>      <num>
#>   1: 0.92810006  0.4617859
#>   2: 0.02206422 -3.0128687
#>   3: 0.10465876 -2.2554443
#>   4: 0.14000278 -2.0803068
#>   5: 0.56961579 -0.8246039
#>  ---                      
#> 446: 0.24127391  0.2977894
#> 447: 0.75484424  1.6898134
#> 448: 0.47672969  0.9416369
#> 449: 0.60933552  1.2775876
#> 450: 0.19516623  0.1409854
```
