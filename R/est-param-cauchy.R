#' Estimate Cauchy Parameters
#'
#' @family Parameter Estimation
#' @family Cauchy
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the cauchy location and scale
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated cauchy data.
#'
#' @param .x The vector of data to be passed to the function.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' x <- tidy_cauchy(.location = 0, .scale = 1)$y
#' output <- util_cauchy_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_cauchy_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  minx <- min(x_term)
  maxx <- max(x_term)
  n <- length(x_term)
  unique_terms <- length(unique(x_term))

  # Checks ----
  if (!inherits(x_term, "numeric")) {
    rlang::abort(
      message = "The '.x' parameter must be numeric.",
      use_cli_format = TRUE
    )
  }

  location <- stats::median(x_term)
  scale <- stats::IQR(x_term)

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_cauchy(.n = n, .location = round(location, 3), .scale = round(scale, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Cauchy",
    samp_size = n,
    min = minx,
    max = maxx,
    method = "MASS",
    location = location,
    scale = scale,
    ratio = (location / scale)
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "cauchy"
  attr(ret, "x_term") <- .x
  attr(ret, "n") <- n

  if (.auto_gen_empirical) {
    output <- list(
      combined_data_tbl = combined_tbl,
      parameter_tbl     = ret
    )
  } else {
    output <- list(
      parameter_tbl = ret
    )
  }

  return(output)
}
