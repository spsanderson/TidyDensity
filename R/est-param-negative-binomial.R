#' Estimate Negative Binomial Parameters
#'
#' @family Parameter Estimation
#' @family Binomial
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the negative binomial size and prob
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated negative binomial data.
#'
#' Two different methods of shape parameters are supplied:
#' -  MLE/MME
#' -  MMUE
#'
#' @param .x The vector of data to be passed to the function.
#' @param .size The size parameter.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' x <- as.integer(mtcars$mpg)
#' output <- util_negative_binomial_param_estimate(x, .size = 1)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' t <- rnbinom(50, 1, .1)
#' util_negative_binomial_param_estimate(t, .size = 1)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_negative_binomial_param_estimate <- function(.x, .size,
                                                  .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  sum_x <- sum(x_term, na.rm = TRUE)
  minx <- min(x_term)
  maxx <- max(x_term)
  m <- mean(x_term, na.rm = TRUE)
  n <- length(x_term)
  unique_terms <- length(unique(x_term))
  size <- .size
  size_length <- length(size)
  pass <- (n == size_length) || (size_length == 1)

  # Checks ----
  if (!is.vector(x_term, mode = "numeric") || is.factor(x_term) ||
    !is.vector(size, mode = "numeric") || is.factor(size)) {
    rlang::abort(
      message = "'.x' and '.size' must be numeric vectors.",
      use_cli_format = TRUE
    )
  }

  if (!pass) {
    rlang::abort(
      message = "The length of '.size' must be 1 or the same as the length of '.x'.",
      use_cli_format = TRUE
    )
  }

  if (n > size_length) {
    size <- rep(size, n)
  }

  if (n < 1) {
    rlang::abort(
      message = "'.x' and '.size' must contain at least one non-missing pari of values.",
      use_cli_format = TRUE
    )
  }

  if (!all(x_term == trunc(x_term)) || any(x_term < 0) || !all(size == trunc(size)) ||
    any(size < 1)) {
    rlang::abort(
      message = "All values of '.x' must be non-negative integers, and all values
      of '.size' must be positive integers.",
      use_cli_format = TRUE
    )
  }

  # Get params ----
  # EnvStats
  size <- sum(size)

  es_mme_size <- size
  es_mme_prob <- size / (size + sum_x)

  es_mvue_size <- size
  es_mvue_prob <- (size - 1) / (size + sum_x - 1)

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_negative_binomial(
      .n = n, .size = round(es_mme_size, 3),
      .prob = round(es_mme_prob, 3)
    )
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = rep("Negative Binomial", 2),
    samp_size = rep(n, 2),
    min = rep(minx, 2),
    max = rep(maxx, 2),
    mean = rep(m, 2),
    method = c("EnvStats_MME_MLE", "EnvStats_MMUE"),
    size = c(es_mme_size, es_mvue_size),
    prob = c(es_mme_prob, es_mvue_prob),
    shape_ratio = c(es_mme_size / es_mme_prob, es_mvue_size / es_mvue_prob)
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "negative_binomial"
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
