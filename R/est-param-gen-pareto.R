#' Estimate Generalized Pareto Parameters
#'
#' @family Parameter Estimation
#' @family Generalized Pareto
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the generalized Pareto shape1, shape2, and rate
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated generalized Pareto data.
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
#' x <- tidy_generalized_pareto(100, .shape1 = 1, .shape2 = 2, .scale = 3)[["y"]]
#' output <- util_generalized_pareto_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @name util_generalized_pareto_param_estimate
NULL

#' @export
#' @rdname util_generalized_pareto_param_estimate

util_generalized_pareto_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

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

  if (n < 2 || any(x_term <= 0)) {
    rlang::abort(
      message = "'.x' must contain at least two non-missing distinct values. All values of '.x' must be positive.",
      use_cli_format = TRUE
    )
  }

  # Negative log-likelihood function for generalized Pareto distribution
  genpareto_lik <- function(params, data) {
    shape1 <- params[1]
    shape2 <- params[2]
    scale <- params[3]
    -sum(actuar::dgenpareto(data, shape1 = shape1, shape2 = shape2, scale = scale, log = TRUE))
  }

  # Initial parameter guesses
  initial_params <- c(shape1 = 1, shape2 = 1, scale = 1)

  # Optimize to minimize the negative log-likelihood
  opt_result <- stats::optim(
    par = initial_params,
    fn = genpareto_lik,
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
    td <- tidy_generalized_pareto(
      .n = n,
      .shape1 = round(shape1, 3),
      .shape2 = round(shape2, 3),
      .rate = round(rate, 3)
    )
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Generalized Pareto",
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
  attr(ret, "family") <- "generalized_pareto"
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
