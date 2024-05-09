#' Estimate Zero Truncated Poisson Parameters
#'
#' @family Parameter Estimation
#' @family Poisson
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#'
#' This function estimates the parameter lambda of a Zero-Truncated Poisson distribution
#' based on a vector of non-negative integer values `.x`. The Zero-Truncated Poisson
#' distribution is a discrete probability distribution that models the number of events
#' occurring in a fixed interval of time, given that at least one event has occurred.
#'
#' The estimation is performed by minimizing the negative log-likelihood of the observed
#' data `.x` under the Zero-Truncated Poisson model. The negative log-likelihood function
#' used for optimization is defined as:
#'
#' \deqn{-\sum_{i=1}^{n} \log(P(X_i = x_i \mid X_i > 0, \lambda))}{,}
#'
#' where \( X_i \) are the observed values in `.x` and `lambda` is the parameter
#' of the Zero-Truncated Poisson distribution.
#'
#' The optimization process uses the `optim` function to find the value of `lambda`
#' that minimizes this negative log-likelihood. The chosen optimization method is Brent's
#' method (`method = "Brent"`) within a specified interval `[0, max(.x)]`.
#'
#' If `.auto_gen_empirical` is set to `TRUE`, the function will generate empirical data
#' statistics using `tidy_empirical()` for the input data `.x` and then combine this
#' empirical data with the estimated Zero-Truncated Poisson distribution using
#' `tidy_combine_distributions()`. This combined data can be accessed via the
#' `$combined_data_tbl` element of the function output.
#'
#' The function returns a tibble containing the estimated parameter `lambda` along
#' with other summary statistics of the input data (sample size, minimum, maximum).
#'
#' @description This function will attempt to estimate the Zero Truncated Poisson
#' lambda parameter given some vector of values `.x`. The function will return a
#' tibble output, and if the parameter `.auto_gen_empirical` is set to `TRUE`
#' then the empirical data given to the parameter `.x` will be run through the
#' `tidy_empirical()` function and combined with the estimated Zero Truncated
#' Poisson data.
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
#' tc <- tidy_zero_truncated_poisson() |> pull(y)
#' output <- util_zero_truncated_poisson_param_estimate(tc)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @name util_zero_truncated_poisson_param_estimate
NULL

#' @export
#' @rdname util_zero_truncated_poisson_param_estimate

util_zero_truncated_poisson_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  minx <- min(x_term)
  maxx <- max(x_term)
  n <- length(x_term)

  # Define negative log-likelihood function
  neg_loglik <- function(lambda, data) {
    -sum(log(actuar::dztpois(x_term, lambda = lambda)))
  }

  # Optimize to find lambda that minimizes negative log-likelihood
  optim_result <- stats::optim(par = 1, fn = neg_loglik, data = x_term,
                               method = "Brent",
                               lower = 0, upper = max(x_term))

  # Extract estimated lambda
  lambda_est <- optim_result$par

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_zero_truncated_poisson(.n = n, .lambda = round(lambda_est, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  # Return Tibble
  ret <- dplyr::tibble(
    dist_type = "Zero Truncated Poisson",
    samp_size = n,
    min = minx,
    max = maxx,
    lambda = lambda_est
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "zero truncated poisson"
  attr(ret, "x_term") <- x_term
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
