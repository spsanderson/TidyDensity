#' Calculate Akaike Information Criterion (AIC) for Binomial Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a binomial
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the size and probability parameters of a binomial
#' distribution from the provided data and then calculates the AIC value based on
#' the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a binomial distribution.
#'
#' @details
#' This function fits a binomial distribution to the provided data. It estimates
#' the size and probability parameters of the binomial distribution from the data.
#' Then, it calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the size and probability parameters of the binomial distribution.
#'
#' Optimization method: Since the parameters are directly calculated from the data,
#' no optimization is needed.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rbinom(30, size = 10, prob = 0.2)
#' util_binomial_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted binomial distribution to the provided data.
#'
#' @name util_binomial_aic
NULL

#' @export
#' @rdname util_binomial_aic
util_binomial_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Estimate size and probability parameters
  # Total number of trials
  size <- length(x)
  sum_of_ones <- sum(x[x == 1])
  prob <- sum_of_ones / size

  # Calculate AIC
  k_binomial <- 2 # Number of parameters for binomial distribution (size and prob)
  logLik_binomial <- sum(stats::dbinom(x, size = size, prob = prob, log = TRUE))
  AIC_binomial <- 2 * k_binomial - 2 * logLik_binomial

  # Return AIC
  return(AIC_binomial)
}
