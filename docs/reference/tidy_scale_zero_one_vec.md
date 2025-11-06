# Vector Function Scale to Zero and One

Takes a numeric vector and will return a vector that has been scaled
from `[0,1]`

## Usage

``` r
tidy_scale_zero_one_vec(.x)
```

## Arguments

- .x:

  A numeric vector to be scaled from `[0,1]` inclusive.

## Value

A numeric vector

## Details

Takes a numeric vector and will return a vector that has been scaled
from `[0,1]` The input vector must be numeric. The computation is fairly
straightforward. This may be helpful when trying to compare the
distributions of data where a distribution like beta which requires data
to be between 0 and 1

\$\$y\[h\] = (x - min(x))/(max(x) - min(x))\$\$

## See also

Other Vector Function:
[`bootstrap_p_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_p_vec.md),
[`bootstrap_q_vec()`](https://www.spsanderson.com/TidyDensity/reference/bootstrap_q_vec.md),
[`cgmean()`](https://www.spsanderson.com/TidyDensity/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/TidyDensity/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/TidyDensity/reference/ckurtosis.md),
[`cmean()`](https://www.spsanderson.com/TidyDensity/reference/cmean.md),
[`cmedian()`](https://www.spsanderson.com/TidyDensity/reference/cmedian.md),
[`csd()`](https://www.spsanderson.com/TidyDensity/reference/csd.md),
[`cskewness()`](https://www.spsanderson.com/TidyDensity/reference/cskewness.md),
[`cvar()`](https://www.spsanderson.com/TidyDensity/reference/cvar.md),
[`tidy_kurtosis_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_kurtosis_vec.md),
[`tidy_skewness_vec()`](https://www.spsanderson.com/TidyDensity/reference/tidy_skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
vec_1 <- rnorm(100, 2, 1)
vec_2 <- tidy_scale_zero_one_vec(vec_1)

dens_1 <- density(vec_1)
dens_2 <- density(vec_2)
max_x <- max(dens_1$x, dens_2$x)
max_y <- max(dens_1$y, dens_2$y)
plot(dens_1,
  asp = max_y / max_x, main = "Density vec_1 (Red) and vec_2 (Blue)",
  col = "red", xlab = "", ylab = "Density of Vec 1 and Vec 2"
)
lines(dens_2, col = "blue")

```
