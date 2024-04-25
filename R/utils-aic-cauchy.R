#' Calculate Akaike Information Criterion (AIC) for Cauchy Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a Cauchy
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a Cauchy distribution from the
#' provided data using maximum likelihood estimation, and then calculates the
#' AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a Cauchy
#' distribution.
#'
#' @details
#' This function fits a Cauchy distribution to the provided data using maximum
#' likelihood estimation. It first estimates the initial parameters of the
#' Cauchy distribution using the method of moments. Then, it optimizes the
#' negative log-likelihood function using the provided data and the initial
#' parameter estimates. Finally, it calculates the AIC value based on the
#' fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' for the initial location and scale parameters of the Cauchy distribution.
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
#' x <- rcauchy(30)
#' util_cauchy_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted Cauchy distribution to the
#' provided data.
#'
#' @name util_cauchy_aic
NULL

#' @export
#' @rdname util_cauchy_aic
util_cauchy_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for Cauchy distribution
  neg_log_lik_cauchy <- function(par, data) {
    location <- par[1]
    scale <- par[2]
    n <- length(data)
    -sum(stats::dcauchy(data, location = location, scale = scale, log = TRUE))
  }

  # Get initial parameter estimates (you might need to adjust this depending on your data)
  # Here we use method of moments estimates as a starting point
  pe <- TidyDensity::util_cauchy_param_estimate(x)$parameter_tbl

  # Fit Cauchy distribution using optim
  fit_cauchy <- stats::optim(
    c(pe$location, pe$scale),
    neg_log_lik_cauchy,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_cauchy <- -fit_cauchy$value
  k_cauchy <- 2 # Number of parameters for Cauchy distribution (location and scale)

  # Calculate AIC
  AIC_cauchy <- 2 * k_cauchy - 2 * logLik_cauchy

  # Return AIC
  return(AIC_cauchy)
}
