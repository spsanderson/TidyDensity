# Bootstrap Empirical Data

Takes an input vector of numeric data and produces a bootstrapped nested
tibble by simulation number.

## Usage

``` r
tidy_bootstrap(
  .x,
  .num_sims = 2000,
  .proportion = 0.8,
  .distribution_type = "continuous"
)
```

## Arguments

- .x:

  The vector of data being passed to the function. Must be a numeric
  vector.

- .num_sims:

  The default is 2000, can be set to anything desired. A warning will
  pass to the console if the value is less than 2000.

- .proportion:

  How much of the original data do you want to pass through to the
  sampling function. The default is 0.80 (80%)

- .distribution_type:

  This can either be 'continuous' or 'discrete'

## Value

A nested tibble

## Details

This function will take in a numeric input vector and produce a tibble
of bootstrapped values in a list. The table that is output will have two
columns: `sim_number` and `bootstrap_samples`

The `sim_number` corresponds to how many times you want the data to be
resampled, and the `bootstrap_samples` column contains a list of the
boostrapped resampled data.

## See also

Other Bootstrap:
[`bootstrap_density_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_density_augment.md),
[`bootstrap_p_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_augment.md),
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_augment()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_augment.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md),
[`bootstrap_unnest_tbl()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_unnest_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg
tidy_bootstrap(x)
#> # A tibble: 2,000 × 2
#>    sim_number bootstrap_samples
#>    <fct>      <list>           
#>  1 1          <dbl [25]>       
#>  2 2          <dbl [25]>       
#>  3 3          <dbl [25]>       
#>  4 4          <dbl [25]>       
#>  5 5          <dbl [25]>       
#>  6 6          <dbl [25]>       
#>  7 7          <dbl [25]>       
#>  8 8          <dbl [25]>       
#>  9 9          <dbl [25]>       
#> 10 10         <dbl [25]>       
#> # ℹ 1,990 more rows
```
