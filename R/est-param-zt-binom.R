#' Estimate Zero Truncated Binomial Parameters
#'
#' @family Parameter Estimation
#' @family Binomial
#' @family Zero Truncated Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the zero truncated
#' binomial size and prob parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated binomial data.
#'
#' One method of estimating the parameters is done via:
#' -  MLE via \code{\link[stats]{optim}} function.
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
#' x <- as.integer(mtcars$mpg)
#' output <- util_zero_truncated_binomial_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' set.seed(123)
#' t <- tidy_zero_truncated_binomial(100, 10, .1)[["y"]]
#' util_zero_truncated_binomial_param_estimate(t)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @name util_zero_truncated_binomial_param_estimate
NULL

#' @export
#' @rdname util_zero_truncated_binomial_param_estimate

util_zero_truncated_binomial_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Check if actuar library is installed
  if (!requireNamespace("actuar", quietly = TRUE)) {
    stop("The 'actuar' package is needed for this function. Please install it with: install.packages('actuar')")
  }

  # Tidyeval ----
  x_term <- as.numeric(.x)
  sum_x <- sum(x_term, na.rm = TRUE)
  minx <- min(x_term)
  maxx <- max(x_term)
  m <- mean(x_term, na.rm = TRUE)
  n <- length(x_term)

  # Negative log-likelihood function for zero-truncated binomial distribution
  nll_func <- function(par) {
    n <- par[1]
    p <- par[2]
    if (n <= 0 || p <= 0 || p >= 1) {
      return(-Inf)
    }
    -sum(actuar::dztbinom(x_term, size = n, prob = p, log = TRUE))
  }

  # Initial parameter guesses
  initial_params <- c(size = max(x_term), prob = 0.5)  # Adjust based on your data

  # Optimization using optim()
  optim_result <- stats::optim(
    par = initial_params,
    fn = nll_func
  ) |>
    suppressWarnings()

  # Extract estimated parameters
  mle_size <- optim_result$par[1]
  mle_prob <- optim_result$par[2]
  mle_msg  <- optim_result$message

  # Create output tibble
  ret <- dplyr::tibble(
    dist_type = "Zero-Truncated Binomial",
    samp_size = n,
    min = minx,
    max = maxx,
    mean = m,
    method = "MLE_Optim",
    size = mle_size,
    prob = mle_prob,
    message = mle_msg
  )

  # Attach attributes
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "zero_truncated_binomial"
  attr(ret, "x_term") <- .x
  attr(ret, "n") <- n

  if (.auto_gen_empirical) {
    # Generate empirical data
    # Assuming tidy_empirical and tidy_combine_distributions functions exist
    te <- tidy_empirical(.x = .x)
    td <- tidy_zero_truncated_binomial(
      .n = n,
      .size = round(mle_size, 3),
      .prob = round(mle_prob, 3)
    )
    combined_tbl <- tidy_combine_distributions(te, td)

    output <- list(
      combined_data_tbl = combined_tbl,
      parameter_tbl = ret
    )
  } else {
    output <- list(
      parameter_tbl = ret
    )
  }

  return(output)
}
