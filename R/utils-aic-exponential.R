#' Calculate Akaike Information Criterion (AIC) for Exponential Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for an exponential distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the rate parameter of an exponential distribution from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to an exponential distribution.
#'
#' @details
#' This function fits an exponential distribution to the provided data using maximum likelihood estimation. It estimates the rate parameter
#' of the exponential distribution using maximum likelihood estimation. Then, it calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the reciprocal of the mean of the data as the initial estimate for the rate parameter.
#'
#' Optimization method: The function uses the optim function for optimization. You might explore different optimization methods within
#' optim for potentially better performance.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's recommended to also assess the goodness-of-fit of the chosen
#' model using visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rexp(30)
#' util_exponential_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted exponential distribution to the provided data.
#'
#' @name util_exponential_aic
NULL

#' @export
#' @rdname util_exponential_aic
util_exponential_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for exponential distribution
  neg_log_lik_exponential <- function(par, data) {
    rate <- par[1]
    n <- length(data)
    -sum(stats::dexp(data, rate = rate, log = TRUE))
  }

  # Get initial parameter estimate: reciprocal of the mean of the data
  pe <- TidyDensity::util_exponential_param_estimate(x)$parameter_tbl

  # Fit exponential distribution using optim
  fit_exponential <- stats::optim(
    pe$rate,
    neg_log_lik_exponential,
    data = x,
    method = "Brent",
    lower = 0.0001,
    upper = 1000
  )

  # Extract log-likelihood and number of parameters
  logLik_exponential <- -fit_exponential$value
  k_exponential <- 1 # Number of parameters for exponential distribution (rate)

  # Calculate AIC
  AIC_exponential <- 2 * k_exponential - 2 * logLik_exponential

  # Return AIC
  return(AIC_exponential)
}
