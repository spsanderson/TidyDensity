#' Estimate Pareto Parameters
#'
#' @family Parameter Estimation
#' @family Pareto
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the Pareto shape and scale
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated Pareto data.
#'
#' Two different methods of shape parameters are supplied:
#' -  LSE
#' -  MLE
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
#' x <- mtcars[["mpg"]]
#' output <- util_pareto1_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' set.seed(123)
#' t <- tidy_pareto1(.n = 100, .shape = 1.5, .min = 1)[["y"]]
#' util_pareto1_param_estimate(t)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @name util_pareto1_param_estimate
NULL

#' @export
#' @rdname util_pareto1_param_estimate

util_pareto1_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

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
      message = "'.x' must contain at least two non-missing distinct values. All values of '.x' must be positive.",
      use_cli_format = TRUE
    )
  }

  # Get params ----
  # LSE
  ppc <- 0.375
  fhat <- stats::ppoints(n, a = ppc)
  lse_coef <- stats::lm(log(1 - fhat) ~ log(sort(x_term)))$coefficients
  lse_shape <- -lse_coef[[2]]
  lse_min <- exp(lse_coef[[1]] / lse_shape)

  # MLE
  mle_min <- min(x_term)
  mle_shape <- n / sum(log(x_term / mle_min))

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td_lse <- tidy_pareto1(.n = n, .shape = round(lse_shape, 3), .min = round(lse_min, 3))
    td_mle <- tidy_pareto1(.n = n, .shape = round(mle_shape, 3), .min = round(mle_min, 3))
    combined_tbl <- tidy_combine_distributions(te, td_lse, td_mle)
  }

  ret <- dplyr::tibble(
    dist_type = rep("Pareto", 2),
    samp_size = rep(n, 2),
    min = rep(minx, 2),
    max = rep(maxx, 2),
    method = c("LSE", "MLE"),
    est_shape = c(lse_shape, mle_shape),
    est_min = c(lse_min, mle_min)
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "pareto"
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
