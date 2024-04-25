#' Calculate Akaike Information Criterion (AIC) for Poisson Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a Poisson
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the lambda parameter of a Poisson distribution from the
#' provided data and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a Poisson distribution.
#'
#' @details
#' This function fits a Poisson distribution to the provided data. It estimates the
#' lambda parameter of the Poisson distribution from the data. Then, it calculates
#' the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimate
#' as a starting point for the lambda parameter of the Poisson distribution.
#'
#' Optimization method: Since the parameter is directly calculated from the data,
#' no optimization is needed.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison,
#' it's recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rpois(100, lambda = 2)
#' util_poisson_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted Poisson distribution to the provided data.
#'
#' @name util_poisson_aic
NULL

#' @export
#' @rdname util_poisson_aic
util_poisson_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Estimate lambda parameter
  lambda <- mean(x, na.rm = TRUE)

  # Calculate AIC
  k_poisson <- 1 # Number of parameters for Poisson distribution (lambda)
  logLik_poisson <- sum(stats::dpois(x, lambda = lambda, log = TRUE))
  AIC_poisson <- 2 * k_poisson - 2 * logLik_poisson

  # Return AIC
  return(AIC_poisson)
}
