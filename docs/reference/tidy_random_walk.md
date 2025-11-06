# Tidy Random Walk

Takes in the data from a `tidy_` distribution function and applies a
random walk calculation of either `cum_prod` or `cum_sum` to `y`.

## Usage

``` r
tidy_random_walk(
  .data,
  .initial_value = 0,
  .sample = FALSE,
  .replace = FALSE,
  .value_type = "cum_prod"
)
```

## Arguments

- .data:

  The data that is being passed from a `tidy_` distribution function.

- .initial_value:

  The default is 0, this can be set to whatever you want.

- .sample:

  This is a boolean value TRUE/FALSE. The default is FALSE. If set to
  TRUE then the `y` value from the `tidy_` distribution function is
  sampled.

- .replace:

  This is a boolean value TRUE/FALSE. The default is FALSE. If set to
  TRUE AND `.sample` is set to TRUE then the replace parameter of the
  sample function will be set to TRUE.

- .value_type:

  This can take one of three different values for now. These are the
  following:

  - "cum_prod" - This will take the cumprod of y

  - "cum_sum" - This will take the cumsum of y

## Value

An ungrouped tibble.

## Details

Monte Carlo simulations were first formally designed in the 1940’s while
developing nuclear weapons, and since have been heavily used in various
fields to use randomness solve problems that are potentially
deterministic in nature. In finance, Monte Carlo simulations can be a
useful tool to give a sense of how assets with certain characteristics
might behave in the future. While there are more complex and
sophisticated financial forecasting methods such as ARIMA
(Auto-Regressive Integrated Moving Average) and GARCH (Generalised
Auto-Regressive Conditional Heteroskedasticity) which attempt to model
not only the randomness but underlying macro factors such as seasonality
and volatility clustering, Monte Carlo random walks work surprisingly
well in illustrating market volatility as long as the results are not
taken too seriously.

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
tidy_normal(.sd = .1, .num_sims = 25) %>%
  tidy_random_walk()
#> # A tibble: 1,250 × 8
#>    sim_number     x        y     dx      dy      p        q random_walk_value
#>    <fct>      <int>    <dbl>  <dbl>   <dbl>  <dbl>    <dbl>             <dbl>
#>  1 1              1 -0.162   -0.290 0.00407 0.0530 -0.162              -0.162
#>  2 1              2 -0.0873  -0.278 0.0133  0.191  -0.0873             -0.235
#>  3 1              3 -0.0158  -0.266 0.0372  0.437  -0.0158             -0.247
#>  4 1              4 -0.146   -0.254 0.0896  0.0719 -0.146              -0.357
#>  5 1              5 -0.0205  -0.241 0.186   0.419  -0.0205             -0.370
#>  6 1              6 -0.00932 -0.229 0.339   0.463  -0.00932            -0.376
#>  7 1              7 -0.132   -0.217 0.548   0.0927 -0.132              -0.459
#>  8 1              8  0.00606 -0.205 0.800   0.524   0.00606            -0.455
#>  9 1              9  0.00386 -0.193 1.08    0.515   0.00386            -0.453
#> 10 1             10  0.0940  -0.181 1.36    0.826   0.0940             -0.402
#> # ℹ 1,240 more rows
```
