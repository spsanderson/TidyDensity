# Tidy Mixture Data

Create mixture model data and resulting density and line plots.

## Usage

``` r
tidy_mixture_density(..., .combination_type = "stack", .cumulative_sum = FALSE)
```

## Arguments

- ...:

  The random data you want to pass. Example rnorm(50,0,1) or something
  like tidy_normal(.mean = 5, .sd = 1)

- .combination_type:

  A character string specifying how to combine the distributions.
  Options are 'add', 'subtract', 'multiply', 'divide', or 'stack'
  (default).

- .cumulative_sum:

  A logical value indicating whether to apply cumulative sum to the
  result. Default is FALSE.

## Value

A list object

## Details

This function allows you to make mixture model data. It allows you to
produce density data and plots for data that is not strictly of one
family or of one single type of distribution with a given set of
parameters.

For example this function will allow you to mix say tidy_normal(.mean =
0, .sd = 1) and tidy_normal(.mean = 5, .sd = 1) or you can mix and match
distributions.

The function now supports different combination types:

- 'add': Element-wise addition of distributions (e.g., rnorm(50) +
  rbeta(50, 0.5, 0.5))

- 'subtract': Element-wise subtraction (e.g., rnorm(50) - rbeta(50, 0.5,
  0.5))

- 'multiply': Element-wise multiplication (e.g., rnorm(50) \* rbeta(50,
  0.5, 0.5))

- 'divide': Element-wise division (e.g., rnorm(50) / rbeta(50, 0.5,
  0.5))

- 'stack': Combine all data points together (e.g., c(rnorm(50),
  rbeta(50, 0.5, 0.5)))

When .cumulative_sum = TRUE, the cumulative sum is applied to the
combined result.

The output is a list object with three components.

1.  Data

- input_data (The random data passed)

- dist_tbl (A tibble of the passed random data)

- density_tbl (A tibble of the x and y data from
  [`stats::density()`](https://rdrr.io/r/stats/density.html))

1.  Plots

- line_plot - Plots the dist_tbl

- dens_plot - Plots the density_tbl

1.  Input Functions

- input_fns - A list of the functions and their parameters passed to the
  function itself

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
output <- tidy_mixture_density(rnorm(100, 0, 1), tidy_normal(.mean = 5, .sd = 1))

output$data
#> $dist_tbl
#> # A tibble: 150 × 2
#>        x      y
#>    <int>  <dbl>
#>  1     1 -1.08 
#>  2     2 -0.394
#>  3     3  0.378
#>  4     4 -0.305
#>  5     5  0.558
#>  6     6 -1.39 
#>  7     7  1.68 
#>  8     8 -1.08 
#>  9     9 -0.699
#> 10    10 -0.726
#> # ℹ 140 more rows
#> 
#> $dens_tbl
#> # A tibble: 150 × 2
#>        x         y
#>    <dbl>     <dbl>
#>  1 -5.13 0.0000548
#>  2 -5.03 0.0000787
#>  3 -4.94 0.000112 
#>  4 -4.84 0.000157 
#>  5 -4.74 0.000219 
#>  6 -4.65 0.000302 
#>  7 -4.55 0.000411 
#>  8 -4.45 0.000554 
#>  9 -4.36 0.000740 
#> 10 -4.26 0.000979 
#> # ℹ 140 more rows
#> 
#> $input_data
#> $input_data$`rnorm(100, 0, 1)`
#>   [1] -1.078278941 -0.394494306  0.378351368 -0.305441689  0.558246758
#>   [6] -1.393532326  1.684877827 -1.081165240 -0.699117005 -0.725905652
#>  [11] -1.517417803 -0.687345982  1.138408622 -0.828156661 -1.764248116
#>  [16] -0.394656802  0.680190219  1.674713389 -1.622145315 -1.139302224
#>  [21] -0.653020621  1.259829155 -1.657913877 -0.205151049  0.471233597
#>  [26]  0.126930606  0.776793531  0.463766570  1.121856454  0.287754635
#>  [31] -0.942991367 -1.326285422 -0.831089780  0.870650245  2.220308388
#>  [36] -0.517924250  0.176057409 -0.079394425  0.464457785 -1.228834634
#>  [41] -0.827114503 -0.442650039  0.563441181  3.045195603  0.630522340
#>  [46] -2.287277571 -1.963242402 -0.587886403  0.660829020  0.575452544
#>  [51] -0.732980663  0.646981831 -0.304213920  0.478974620 -0.680208172
#>  [56]  1.020957064  0.211375567  2.556798079 -0.357284695  1.296430536
#>  [61] -0.106096171 -1.788955128  1.306353861  0.267957365  0.046148651
#>  [66]  0.881654738 -1.521475135 -1.074093381  0.784098611 -1.325868925
#>  [71] -0.908470832  0.092405292 -0.637334735  0.420245842 -0.445381955
#>  [76] -0.005572972 -0.095291648  1.458740814 -0.225460424  0.539405404
#>  [81]  0.914422018  0.849907176  1.167660314  0.872550773 -2.588423803
#>  [86] -0.614142664  0.739495589  0.065735720 -0.789692769 -0.382117193
#>  [91] -0.542426104 -0.499944756  2.499905149  0.345791751 -0.489950558
#>  [96]  1.045149401 -0.597249064  0.385316128 -1.478374322 -0.251246452
#> 
#> $input_data$`tidy_normal(.mean = 5, .sd = 1)`
#> # A tibble: 50 × 7
#>    sim_number     x     y    dx       dy      p     q
#>    <fct>      <int> <dbl> <dbl>    <dbl>  <dbl> <dbl>
#>  1 1              1  5.83  1.90 0.000357 0.797   5.83
#>  2 1              2  4.81  2.02 0.00101  0.425   4.81
#>  3 1              3  3.95  2.14 0.00253  0.147   3.95
#>  4 1              4  4.42  2.26 0.00560  0.282   4.42
#>  5 1              5  2.90  2.38 0.0110   0.0179  2.90
#>  6 1              6  4.51  2.50 0.0192   0.313   4.51
#>  7 1              7  6.53  2.62 0.0299   0.937   6.53
#>  8 1              8  6.73  2.73 0.0420   0.958   6.73
#>  9 1              9  6.07  2.85 0.0541   0.857   6.07
#> 10 1             10  5.98  2.97 0.0653   0.837   5.98
#> # ℹ 40 more rows
#> 
#> 

output$plots
#> $line_plot

#> 
#> $dens_plot

#> 

output$input_fns
#> [1] "rnorm(100, 0, 1), tidy_normal(.mean = 5, .sd = 1)"

# Example with different combination types
set.seed(123)
mix_add <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5), .combination_type = "add")
mix_add$input_fns
#> [1] "rnorm(50), rbeta(50, 0.5, 0.5)"

mix_multiply <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5), .combination_type = "multiply")
mix_multiply$input_fns
#> [1] "rnorm(50), rbeta(50, 0.5, 0.5)"

mix_stack <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5), .combination_type = "stack")
mix_stack$input_fns
#> [1] "rnorm(50), rbeta(50, 0.5, 0.5)"

# Example with cumulative sum
mix_cumsum <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5),
                                  .combination_type = "stack", .cumulative_sum = TRUE)
mix_cumsum$input_fns
#> [1] "rnorm(50), rbeta(50, 0.5, 0.5)"
```
