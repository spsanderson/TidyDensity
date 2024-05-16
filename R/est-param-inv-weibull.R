#' Estimate Inverse Weibull Parameters
#'
#' @family Parameter Estimation
#' @family Inverse Weibull
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the inverse Weibull shape and rate
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated inverse Weibull data.
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
#' x <- tidy_inverse_weibull(100, .shape = 2, .scale = 1)[["y"]]
#' output <- util_inverse_weibull_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @name util_inverse_weibull_param_estimate
NULL
#' @export
#' @rdname util_inverse_weibull_param_estimate

util_inverse_weibull_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  minx <- min(x_term)
  maxx <- max(x_term)
  n <- length(x_term)
  unique_terms <- length(unique(x_term))

  # Checks ----
  if (!is.numeric(.x)) {
    rlang::abort(
      message = "The '.x' parameter must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  # Negative log-likelihood function ----
  neg_log_lik <- function(params, data) {
    shape <- params[1]
    scale <- params[2]
    -sum(actuar::dinvweibull(data, shape = shape, scale = scale, log = TRUE))
  }

  # Initial parameter guesses
  initial_params <- c(shape = 1, scale = 1)

  # Optimize to minimize the negative log-likelihood
  opt_result <- stats::optim(
    par = initial_params,
    fn = neg_log_lik,
    data = x_term,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5)
  )

  iw_shape <- opt_result$par[1]
  iw_scale <- opt_result$par[2]
  iw_rate <- 1 / iw_scale

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_inverse_weibull(.n = n, .shape = round(iw_shape, 3), .rate = round(iw_rate, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Inverse Weibull",
    samp_size = n,
    min = minx,
    max = maxx,
    method = "MLE",
    shape = iw_shape,
    scale = iw_scale,
    rate = iw_rate
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "inverse_weibull"
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
