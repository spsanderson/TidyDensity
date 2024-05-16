#' Calculate Akaike Information Criterion (AIC) for Negative Binomial Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a negative binomial distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters size (r) and probability (prob) of a
#' negative binomial distribution from the provided data and then calculates
#' the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a negative
#' binomial distribution.
#'
#' @details
#' This function fits a negative binomial distribution to the provided data.
#' It estimates the parameters size (r) and probability (prob) of the negative
#' binomial distribution from the data. Then, it calculates the AIC value based
#' on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimate
#' as a starting point for the size (r) parameter of the negative binomial distribution,
#' and the probability (prob) is estimated based on the mean and variance of the data.
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
#' data <- rnbinom(n = 100, size = 5, mu = 10)
#' util_negative_binomial_aic(data)
#'
#' @return
#' The AIC value calculated based on the fitted negative binomial distribution to the provided data.
#'
#' @name util_negative_binomial_aic
NULL

#' @export
#' @rdname util_negative_binomial_aic
util_negative_binomial_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Estimate size (r) parameter using method of moments
  m <- mean(x)
  v <- var(x)
  r <- m^2 / (v - m)

  # Estimate probability (prob) parameter
  prob <- r / (r + m)

  # Calculate AIC
  k_negative_binomial <- 2 # Number of parameters for negative binomial distribution (r and prob)
  logLik_negative_binomial <- sum(stats::dnbinom(x, size = r, prob = prob, log = TRUE))
  AIC_negative_binomial <- 2 * k_negative_binomial - 2 * logLik_negative_binomial

  # Return AIC
  return(AIC_negative_binomial)
}
