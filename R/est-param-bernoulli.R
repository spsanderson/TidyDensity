#' Estimate Bernoulli Parameters
#'
#' @family Parameter Estimation
#' @family Bernoulli
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will see if the given vector `.x` is a numeric vector.
#' It will attempt to estimate the prob parameter of a Bernoulli distribution.
#'
#' @description This function will attempt to estimate the Bernoulli prob parameter
#' given some vector of values `.x`. The function will return a list output by default,
#' and  if the parameter `.auto_gen_empirical` is set to `TRUE` then the empirical
#' data given to the parameter `.x` will be run through the `tidy_empirical()`
#' function and combined with the estimated Bernoulli data.
#'
#' @param .x The vector of data to be passed to the function. Must be non-negative
#' integers.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' tb <- tidy_bernoulli(.prob = .1) |> pull(y)
#' output <- util_bernoulli_param_estimate(tb)
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

util_bernoulli_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

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

  if (!all(x_term == trunc(x_term)) || any(x_term < 0) || any(x_term > 1)) {
    rlang::abort(
      message = "All values of 'x' must be non-negative integers between 0 and 1 inclusive..",
      use_cli_format = TRUE
    )
  }

  if (n < 2) {
    rlang::abort(
      message = "You must supply at least two data points for this function.",
      use_cli_format = TRUE
    )
  }

  # Parameters ----
  prob <- m

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_bernoulli(.n = n, .prob = round(m, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Bernoulli",
    samp_size = n,
    min = minx,
    max = maxx,
    mean = m,
    variance = m * (1 - m),
    sum_x = sum_x,
    prob = m
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "bernoulli"
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
