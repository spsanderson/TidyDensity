#' Estimate Inverse Burr Parameters
#'
#' @family Parameter Estimation
#' @family Inverse Burr
#'
#' @details This function will see if the given vector `.x` is a numeric vector.
#' It will attempt to estimate the shape1, shape2, and rate parameters of an inverse
#' Burr distribution.
#'
#' @description This function will attempt to estimate the inverse Burr shape1, shape2, and rate parameters
#' given some vector of values `.x`. The function will return a list output by default,
#' and if the parameter `.auto_gen_empirical` is set to `TRUE` then the empirical
#' data given to the parameter `.x` will be run through the `tidy_empirical()`
#' function and combined with the estimated inverse Burr data.
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
#' set.seed(123)
#' tb <- tidy_burr(.shape1 = 1, .shape2 = 2, .rate = .3) |> pull(y)
#' output <- util_inverse_burr_param_estimate(tb)
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

util_inverse_burr_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)

  # Checks ----
  if (!is.vector(x_term, mode = "numeric")) {
    rlang::abort(
      message = "The '.x' term must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  if (any(x_term < 0)) {
    rlang::abort(
      message = "All values of '.x' must be non-negative integers greater than 0.",
      use_cli_format = TRUE
    )
  }

  if (n < 2) {
    rlang::abort(
      message = "You must supply at least two data points for this function.",
      use_cli_format = TRUE
    )
  }

  # Negative log-likelihood function for inverse Burr distribution
  invburr_lik <- function(params, data) {
    shape1 <- params[1]
    shape2 <- params[2]
    scale <- params[3]
    -sum(actuar::dinvburr(data, shape1 = shape1, shape2 = shape2, scale = scale, log = TRUE))
  }

  # Initial parameter guesses
  initial_params <- c(shape1 = 1, shape2 = 1, scale = 1)

  # Optimize to minimize the negative log-likelihood
  opt_result <- stats::optim(
    par = initial_params,
    fn = invburr_lik,
    data = x_term,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5, 1e-5)
  )

  shape1 <- opt_result$par[1]
  shape2 <- opt_result$par[2]
  scale <- opt_result$par[3]
  rate <- 1 / scale

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_burr(.n = n, .shape1 = round(shape1, 3), .shape2 = round(shape2, 3), .rate = round(rate, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Inverse Burr",
    samp_size = n,
    min = min(x_term),
    max = max(x_term),
    mean = mean(x_term),
    shape1 = shape1,
    shape2 = shape2,
    rate = rate,
    scale = scale
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "inverse_burr"
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
