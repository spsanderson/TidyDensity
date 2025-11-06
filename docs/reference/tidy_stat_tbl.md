# Tidy Stats of Tidy Distribution

A function to return the `stat` function values of a given `tidy_`
distribution output.

## Usage

``` r
tidy_stat_tbl(
  .data,
  .x = y,
  .fns,
  .return_type = "vector",
  .use_data_table = FALSE,
  ...
)
```

## Arguments

- .data:

  The input data coming from a `tidy_` distribution function.

- .x:

  The default is `y` but can be one of the other columns from the input
  data.

- .fns:

  The default is `IQR`, but this can be any `stat` function like
  `quantile` or `median` etc.

- .return_type:

  The default is "vector" which returns an `sapply` object.

- .use_data_table:

  The default is FALSE, TRUE will use data.table under the hood and
  still return a tibble. If this argument is set to TRUE then the
  `.return_type` parameter will be ignored.

- ...:

  Addition function arguments to be supplied to the parameters of `.fns`

## Value

A return of object of either `sapply` `lapply` or `tibble` based upon
user input.

## Details

A function to return the value(s) of a given `tidy_` distribution
function output and chosen column from it. This function will only work
with `tidy_` distribution functions.

There are currently three different output types for this function.
These are:

- "vector" - which gives an
  [`sapply()`](https://rdrr.io/r/base/lapply.html) output

- "list" - which gives an
  [`lapply()`](https://rdrr.io/r/base/lapply.html) output, and

- "tibble" - which returns a `tibble` in long format.

Currently you can pass any stat function that performs an operation on a
vector input. This means you can pass things like `IQR`, `quantile` and
their associated arguments in the `...` portion of the function.

This function also by default will rename the value column of the
`tibble` to the name of the function. This function will also give the
column name of sim_number for the `tibble` output with the corresponding
simulation numbers as the values.

For the `sapply` and `lapply` outputs the column names will also give
the simulation number information by making column names like
`sim_number_1` etc.

There is an option of `.use_data_table` which can greatly enhance the
speed of the calculations performed if used while still returning a
`tibble`. The calculations are performed after turning the input data
into a `data.table` object, performing the necessary calculation and
then converting back to a `tibble` object.

## See also

Other Statistic:
[`ci_hi()`](https://www.spsanderson.com/TidyDensity/reference/ci_hi.md),
[`ci_lo()`](https://www.spsanderson.com/TidyDensity/reference/ci_lo.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_range_statistic()`](https://www.spsanderson.com/TidyDensity/reference/tidy_range_statistic.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tn <- tidy_normal(.num_sims = 3)

p <- c(0.025, 0.25, 0.5, 0.75, 0.95)

tidy_stat_tbl(tn, y, quantile, "vector", probs = p, na.rm = TRUE)
#>      sim_number_1 sim_number_2 sim_number_3
#> 2.5%   -1.5199049   -1.3808825  -3.12265469
#> 25%    -0.8896384   -0.5572267  -0.93429139
#> 50%    -0.3103529   -0.0369386  -0.08771205
#> 75%     0.2731464    0.6132503   0.95542966
#> 95%     1.3687915    1.1043639   1.62294349
tidy_stat_tbl(tn, y, quantile, "list", probs = p)
#> $sim_number_1
#>       2.5%        25%        50%        75%        95% 
#> -1.5199049 -0.8896384 -0.3103529  0.2731464  1.3687915 
#> 
#> $sim_number_2
#>       2.5%        25%        50%        75%        95% 
#> -1.3808825 -0.5572267 -0.0369386  0.6132503  1.1043639 
#> 
#> $sim_number_3
#>        2.5%         25%         50%         75%         95% 
#> -3.12265469 -0.93429139 -0.08771205  0.95542966  1.62294349 
#> 
tidy_stat_tbl(tn, y, quantile, "tibble", probs = p)
#> # A tibble: 15 × 3
#>    sim_number name  quantile
#>    <fct>      <chr>    <dbl>
#>  1 1          2.5%   -1.52  
#>  2 1          25%    -0.890 
#>  3 1          50%    -0.310 
#>  4 1          75%     0.273 
#>  5 1          95%     1.37  
#>  6 2          2.5%   -1.38  
#>  7 2          25%    -0.557 
#>  8 2          50%    -0.0369
#>  9 2          75%     0.613 
#> 10 2          95%     1.10  
#> 11 3          2.5%   -3.12  
#> 12 3          25%    -0.934 
#> 13 3          50%    -0.0877
#> 14 3          75%     0.955 
#> 15 3          95%     1.62  
tidy_stat_tbl(tn, y, quantile, .use_data_table = TRUE, probs = p, na.rm = TRUE)
#> # A tibble: 15 × 3
#>    sim_number name  quantile
#>    <fct>      <fct>    <dbl>
#>  1 1          2.5%   -1.52  
#>  2 1          25%    -0.890 
#>  3 1          50%    -0.310 
#>  4 1          75%     0.273 
#>  5 1          95%     1.37  
#>  6 2          2.5%   -1.38  
#>  7 2          25%    -0.557 
#>  8 2          50%    -0.0369
#>  9 2          75%     0.613 
#> 10 2          95%     1.10  
#> 11 3          2.5%   -3.12  
#> 12 3          25%    -0.934 
#> 13 3          50%    -0.0877
#> 14 3          75%     0.955 
#> 15 3          95%     1.62  
```
