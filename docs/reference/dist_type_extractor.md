# Extract Distribution Type from Tidy Distribution Object

Get the distribution name in title case from the `tidy_` distribution
function.

## Usage

``` r
dist_type_extractor(.x)
```

## Arguments

- .x:

  The attribute list passed from a `tidy_` distribution function.

## Value

A character string

## Details

This will extract the distribution type from a `tidy_` distribution
function output using the attributes of that object. You must pass the
attribute directly to the function. It is meant really to be used
internally.

You should be passing if using manually the `$tibble_type` attribute.

## Author

Steven P. Sanderson II,

## Examples

``` r
tn <- tidy_normal()
atb <- attributes(tn)
dist_type_extractor(atb$tibble_type)
#> [1] "Gaussian"
```
