#' Estimate Inverse Pareto Parameters
#'
#' @family Parameter Estimation
#' @family Inverse Pareto
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the inverse Pareto shape and scale
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated inverse Pareto data.
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
#' x <- tidy_inverse_pareto(.n = 100, .shape = 2, .scale = 1)[["y"]]
#' output <- util_inverse_pareto_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_inverse_pareto_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  minx <- min(x_term)
  maxx <- max(x_term)
  n <- length(x_term)
  unique_terms <- length(unique(x_term))

  # Checks ----
  if (!is.vector(x_term, mode = "numeric") || is.factor(x_term)) {
    rlang::abort(
      message = "'.x' must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  if (n < 2 || any(x_term <= 0) || unique_terms < 2) {
    rlang::abort(
      message = "'.x' must contain at least two non-missing distinct values.
      All values of '.x' must be positive.",
      use_cli_format = TRUE
    )
  }

  # Negative log-likelihood function for inverse Pareto distribution
  neg_log_lik_invpareto <- function(params, data) {
    shape <- params[1]
    scale <- params[2]
    -sum(actuar::dinvpareto(data, shape = shape, scale = scale, log = TRUE))
  }

  # Initial parameter guesses
  initial_params <- c(shape = 1, scale = min(x_term))

  # Optimize to minimize the negative log-likelihood
  opt_result <- stats::optim(
    par = initial_params,
    fn = neg_log_lik_invpareto,
    data = x_term,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5)
  )

  invpareto_shape <- opt_result$par[1]
  invpareto_scale <- opt_result$par[2]

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_inverse_pareto(
      .n = n,
      .shape = round(invpareto_shape, 3),
      .scale = round(invpareto_scale, 3)
    )
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Inverse Pareto",
    samp_size = n,
    min = minx,
    max = maxx,
    method = "MLE",
    shape = invpareto_shape,
    scale = invpareto_scale,
    shape_ratio = invpareto_shape / invpareto_scale
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "inverse_pareto"
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
