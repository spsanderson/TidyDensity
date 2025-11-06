# Unnest Tidy Bootstrap Tibble

Unnest the data output from
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md).

## Usage

``` r
bootstrap_unnest_tbl(.data)
```

## Arguments

- .data:

  The data that is passed from the
  [`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
  function.

## Value

A tibble

## Details

This function takes as input the output of the
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
function and returns a two column tibble. The columns are `sim_number`
and `y`

It looks for an attribute that comes from using
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)
so it will not work unless the data comes from that function.

## See also

Other Bootstrap:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md),
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md),
[`tidy_bootstrap()`](https://www.spsanderson.com/TidyDensity/reference/tidy_bootstrap.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tb <- tidy_bootstrap(.x = mtcars$mpg)
bootstrap_unnest_tbl(tb)
#> # A tibble: 50,000 × 2
#>    sim_number     y
#>    <fct>      <dbl>
#>  1 1           10.4
#>  2 1           15.2
#>  3 1           10.4
#>  4 1           10.4
#>  5 1           27.3
#>  6 1           19.2
#>  7 1           21.4
#>  8 1           18.1
#>  9 1           16.4
#> 10 1           15  
#> # ℹ 49,990 more rows

bootstrap_unnest_tbl(tb) |>
  tidy_distribution_summary_tbl(sim_number)
#> # A tibble: 2,000 × 13
#>    sim_number mean_val median_val std_val min_val max_val skewness kurtosis
#>    <fct>         <dbl>      <dbl>   <dbl>   <dbl>   <dbl>    <dbl>    <dbl>
#>  1 1              18.7       18.1    5.37    10.4    30.4    0.549     3.11
#>  2 2              18.8       17.3    5.13    10.4    33.9    1.03      4.55
#>  3 3              21.8       19.2    6.54    10.4    33.9    0.517     2.23
#>  4 4              19.9       17.8    6.28    10.4    32.4    0.719     2.51
#>  5 5              23.9       21.5    7.01    10.4    33.9   -0.316     2.06
#>  6 6              21.4       19.7    6.28    10.4    33.9    0.385     2.27
#>  7 7              21.1       21      6.38    10.4    33.9    0.191     2.78
#>  8 8              21.0       21      5.93    13.3    33.9    0.748     2.75
#>  9 9              20.7       21      6.14    10.4    33.9    0.742     3.09
#> 10 10             18.4       18.1    4.53    10.4    32.4    1.08      4.92
#> # ℹ 1,990 more rows
#> # ℹ 5 more variables: range <dbl>, iqr <dbl>, variance <dbl>, ci_low <dbl>,
#> #   ci_high <dbl>
```
