#' Calculate Akaike Information Criterion (AIC) for Generalized Beta Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a generalized Beta
#' distribution fitted to the provided data.
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape1, shape2, shape3, and rate parameters of a generalized Beta distribution
#' from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a generalized Beta distribution.
#'
#' @details
#' This function fits a generalized Beta distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape1, shape2, shape3, and rate parameters
#' of the generalized Beta distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses reasonable initial estimates
#' for the shape1, shape2, shape3, and rate parameters of the generalized Beta distribution.
#'
#' Optimization method: The function uses the optim function for optimization.
#' You might explore different optimization methods within optim for potentially
#' better performance.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- tidy_generalized_beta(100, .shape1 = 2, .shape2 = 3,
#'                           .shape3 = 4, .rate = 5)[["y"]]
#' util_generalized_beta_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted generalized Beta distribution to
#' the provided data.
#'
#' @name util_generalized_beta_aic
NULL

#' @export
#' @rdname util_generalized_beta_aic
util_generalized_beta_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for generalized Beta distribution
  neg_log_lik_genbeta <- function(par, data) {
    shape1 <- par[1]
    shape2 <- par[2]
    shape3 <- par[3]
    rate <- par[4]
    -sum(actuar::dgenbeta(data, shape1 = shape1, shape2 = shape2,
                          shape3 = shape3, rate = rate, log = TRUE))
  }

  # Initial parameter estimates
  pe <- TidyDensity::util_generalized_beta_param_estimate(x)$parameter_tbl
  shape1 <- pe$shape1
  shape2 <- pe$shape2
  shape3 <- pe$shape3
  rate <- pe$rate
  initial_params <- c(shape1 = shape1, shape2 = shape2, shape3 = shape3,
                      rate = rate)

  # Fit generalized Beta distribution using optim
  fit_genbeta <- stats::optim(
    par = initial_params,
    fn = neg_log_lik_genbeta,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_genbeta <- -fit_genbeta$value
  k_genbeta <- 4 # Number of parameters for generalized Beta distribution (shape1, shape2, shape3, and rate)

  # Calculate AIC
  AIC_genbeta <- 2 * k_genbeta - 2 * logLik_genbeta

  # Return AIC
  return(AIC_genbeta)
}
