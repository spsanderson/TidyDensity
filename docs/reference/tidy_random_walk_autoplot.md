# Automatic Plot of Random Walk Data

This is an auto-plotting function that will take in a `tidy_`
distribution function and a few arguments with regard to the output of
the visualization.

If the number of simulations exceeds 9 then the legend will not print.
The plot subtitle is put together by the attributes of the table passed
to the function.

## Usage

``` r
tidy_random_walk_autoplot(
  .data,
  .line_size = 0.5,
  .geom_rug = FALSE,
  .geom_smooth = FALSE,
  .interactive = FALSE
)
```

## Arguments

- .data:

  The data passed in from a tidy\_`distribution` function like
  [`tidy_normal()`](https://www.spsanderson.com/TidyDensity/reference/tidy_normal.md)

- .line_size:

  The size param ggplot

- .geom_rug:

  A Boolean value of TRUE/FALSE, FALSE is the default. TRUE will return
  the use of
  [`ggplot2::geom_rug()`](https://ggplot2.tidyverse.org/reference/geom_rug.html)

- .geom_smooth:

  A Boolean value of TRUE/FALSE, FALSE is the default. TRUE will return
  the use of
  [`ggplot2::geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html)
  The `aes` parameter of group is set to FALSE. This ensures a single
  smoothing band returned with SE also set to FALSE. Color is set to
  'black' and `linetype` is 'dashed'.

- .interactive:

  A Boolean value of TRUE/FALSE, FALSE is the default. TRUE will return
  an interactive `plotly` plot.

## Value

A ggplot or a plotly plot.

## Details

This function will produce a simple random walk plot from a `tidy_`
distribution function.

## See also

Other Autoplot:
[`bootstrap_stat_plot()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_stat_plot.md),
[`tidy_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_autoplot.md),
[`tidy_combined_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_combined_autoplot.md),
[`tidy_four_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_four_autoplot.md),
[`tidy_multi_dist_autoplot()`](https://www.spsanderson.com/TidyDensity/reference/tidy_multi_dist_autoplot.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_normal(.sd = .1, .num_sims = 5) |>
  tidy_random_walk(.value_type = "cum_sum") |>
  tidy_random_walk_autoplot()


tidy_normal(.sd = .1, .num_sims = 20) |>
  tidy_random_walk(.value_type = "cum_sum", .sample = TRUE, .replace = TRUE) |>
  tidy_random_walk_autoplot()

```
