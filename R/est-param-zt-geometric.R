#' Estimate Zero-Truncated Geometric Parameters
#'
#' @family Parameter Estimation
#' @family Zero-Truncated Geometric
#'
#' @details This function will attempt to estimate the `prob` parameter of the
#' Zero-Truncated Geometric distribution using given vector `.x` as input data.
#' If the parameter `.auto_gen_empirical` is set to `TRUE`, the empirical data
#' in `.x` will be run through the `tidy_empirical()` function and combined with
#' the estimated zero-truncated geometric data.
#'
#' @description This function will estimate the `prob` parameter for a
#' Zero-Truncated Geometric distribution from a given vector `.x`. The function
#' returns a list with a parameter table, and if `.auto_gen_empirical` is set
#' to `TRUE`, the empirical data is combined with the estimated distribution
#' data.
#'
#' @param .x The vector of data to be passed to the function. Must contain
#' non-negative integers and should have no zeros.
#' @param .auto_gen_empirical Boolean value (default `TRUE`) that, when set to
#' `TRUE`, will generate `tidy_empirical()` output for `.x` and combine it with
#' the estimated distribution data.
#'
#' @examples
#' library(actuar)
#' library(dplyr)
#' library(ggplot2)
#' library(actuar)
#'
#' set.seed(123)
#' ztg <- rztgeom(100, prob = 0.2)
#' output <- util_zero_truncated_geometric_param_estimate(ztg)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @name util_zero_truncated_geometric_param_estimate
NULL

#' @export
#' @rdname util_zero_truncated_geometric_param_estimate

util_zero_truncated_geometric_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)
  minx <- min(as.numeric(x_term))
  maxx <- max(as.numeric(x_term))
  m <- mean(as.numeric(x_term))
  s <- var(x_term)
  sum_x <- sum(x_term)

  # Checks ----
  if (!is.vector(x_term, mode = "numeric")) {
    rlang::abort(
      message = "The '.x' term must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  if (!all(x_term == trunc(x_term)) || any(x_term <= 0)) {
    rlang::abort(
      message = "All values of 'x' must be positive non-zero integers.",
      use_cli_format = TRUE
    )
  }

  if (n < 2) {
    rlang::abort(
      message = "You must supply at least two data points for this function.",
      use_cli_format = TRUE
    )
  }

  # Estimate the prob parameter for the Zero-Truncated Geometric distribution
  es_ztgeom_prob <- 1 / (1 + m - 1)

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_zero_truncated_geometric(.n = n, .prob = round(es_ztgeom_prob, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Zero-Truncated Geometric",
    samp_size = n,
    min = minx,
    max = maxx,
    mean = m,
    variance = s,
    sum_x = sum_x,
    method = "Moment Estimate",
    prob = es_ztgeom_prob
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "zero_truncated_geometric"
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
