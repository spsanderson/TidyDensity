#' Estimate Generalized Beta Parameters
#'
#' @family Parameter Estimation
#' @family Generalized Beta
#'
#' @details This function will attempt to estimate the generalized Beta shape1, shape2, shape3, and rate
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated generalized Beta data.
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
#' set.seed(123)
#' x <- tidy_generalized_beta(100, .shape1 = 2, .shape2 = 3,
#' .shape3 = 4, .rate = 5)[["y"]]
#' output <- util_generalized_beta_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @export
#'

util_generalized_beta_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)

  # Checks ----
  if (!is.vector(x_term, mode = "numeric") || is.factor(x_term)) {
    rlang::abort(
      message = "'.x' must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  if (n < 2) {
    rlang::abort(
      message = "'.x' must contain at least two non-missing distinct values. All values of '.x' must be positive.",
      use_cli_format = TRUE
    )
  }

  # Negative log-likelihood function for generalized Beta distribution
  genbeta_lik <- function(params, data) {
    shape1 <- params[1]
    shape2 <- params[2]
    shape3 <- params[3]
    rate <- params[4]
    -sum(actuar::dgenbeta(data, shape1 = shape1, shape2 = shape2,
                          shape3 = shape3, rate = rate, log = TRUE))
  }

  # Initial parameter guesses
  initial_params <- c(shape1 = 1, shape2 = 1, shape3 = 1, rate = 1)

  # Optimize to minimize the negative log-likelihood
  opt_result <- stats::optim(
    par = initial_params,
    fn = genbeta_lik,
    data = x_term
  )

  shape1 <- opt_result$par[["shape1"]]
  shape2 <- opt_result$par[["shape2"]]
  shape3 <- opt_result$par[["shape3"]]
  rate <- opt_result$par[["rate"]]

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_generalized_beta(.n = n, .shape1 = round(shape1, 3), .shape2 = round(shape2, 3), .shape3 = round(shape3, 3), .rate = round(rate, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Generalized Beta",
    samp_size = n,
    min = min(x_term),
    max = max(x_term),
    mean = mean(x_term),
    shape1 = shape1,
    shape2 = shape2,
    shape3 = shape3,
    rate = rate
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "generalized_beta"
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
