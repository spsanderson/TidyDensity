#' Estimate Binomial Parameters
#'
#' @family Parameter Estimation
#' @family Binomial
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the binomial p_hat and size
#' parameters given some vector of values.
#'
#' @description This function will check to see if some given vector `.x` is
#' either a numeric vector or a factor vector with at least two levels then it
#' will cause an error and the function will abort. The function will return a
#' list output by default, and  if the parameter `.auto_gen_empirical` is set to
#' `TRUE` then the empirical data given to the parameter `.x` will be run through
#' the `tidy_empirical()` function and combined with the estimated binomial data.
#'
#' @param .x The vector of data to be passed to the function. Must be numeric, and
#' all values must be 0 <= x <= 1
#' @param .size Number of trials, zero or more.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' tb <- rbinom(50, 1, .1)
#' output <- util_binomial_param_estimate(tb)
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

util_binomial_param_estimate <- function(.x, .size = NULL, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- .x
  n <- length(x_term)
  minx <- min(as.numeric(x_term))
  maxx <- max(as.numeric(x_term))
  m <- mean(as.numeric(x_term))
  s2 <- var(as.numeric(x_term))
  size <- .size

  # Checks ----
  if (!is.vector(x_term) && !is.factor(x_term)) {
    rlang::abort(
      message = "'.x' must be either a numeric or factor vector.",
      use_cli_format = TRUE
    )
  }

  if (is.factor(x_term) && length(levels(x_term)) < 2) {
    rlang::abort(
      message = "When '.x' is a factor it must have at least two levels.",
      use_cli_format = TRUE
    )
  }

  if (!is.factor(x_term) && !is.numeric(x_term)) {
    rlang::abort(
      message = "'.x' must be either a numeric or factor vector.",
      use_cli_format = TRUE
    )
  }

  # If size is NULL
  if (is.null(size)) {
    x <- as.numeric(x_term)

    if (is.factor(x_term)) {
      x <- x - 1 # makes the factor vector equal to the actual x vector provided.
    }

    size <- length(x)

    if (size == 0) {
      rlang::abort(
        message = "'.x' must contain at least one non-missing value.",
        use_cli_format = TRUE
      )
    }

    if (!all(x == 0 | x == 1)) {
      rlang::abort(
        message = "If '.size' is not supplied and '.x' is numeric,
                all non-missing values of '.x' must be 0 or 1.",
        use_cli_format = TRUE
      )
    }

    prob <- mean(x)
  } else {
    if (n != 1 || !is.numeric(x_term) ||
      !is.finite(x_term) || x_term != trunc(x_term) ||
      x_term < 0) {
      rlang::abort(
        message = "'.x' must be a single non-negative integer when
                    '.size' is not NULL",
        use_cli_format = TRUE
      )
    }
    if (length(size) != 1 || !is.numeric(size) || !is.finite(size) || size < x) {
      rlang::abort(
        message = "'.size' must be a positive integer at least as large as '.x'."
      )
    }

    prob <- x_term / size
  }

  # Return Tibble ----
  if (.auto_gen_empirical) {
    if (is.factor(x_term)) {
      xx <- x
    } else {
      xx <- x_term
    }
    te <- tidy_empirical(.x = xx)
    td <- tidy_binomial(.n = n, .size = size, .prob = round(prob, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = "Binomial",
    samp_size = n,
    min = minx,
    max = maxx,
    mean = m,
    variance = s2,
    method = "EnvStats_MME",
    prob = prob,
    size = size,
    shape_ratio = prob / size
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "binomial"
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
