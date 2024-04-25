#' Calculate Akaike Information Criterion (AIC) for Uniform Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a uniform
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the min and max parameters of a uniform distribution
#' from the provided data and then calculates the AIC value based on the fitted
#' distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a uniform distribution.
#'
#' @details
#' This function fits a uniform distribution to the provided data. It estimates
#' the min and max parameters of the uniform distribution from the range of the data.
#' Then, it calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the minimum and maximum values
#' of the data as starting points for the min and max parameters of the uniform
#' distribution.
#'
#' Optimization method: Since the parameters are directly calculated from the
#' data, no optimization is needed.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison,
#' it's recommended to also assess the goodness-of-fit of the chosen
#' model using visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- runif(30)
#' util_uniform_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted uniform distribution to the provided data.
#'
#' @name util_uniform_aic
NULL

#' @export
#' @rdname util_uniform_aic
util_uniform_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Estimate min and max parameters
  min_val <- min(x)
  max_val <- max(x)

  # Calculate AIC
  k_uniform <- 2 # Number of parameters for uniform distribution (min and max)
  logLik_uniform <- -length(x) * log(max_val - min_val)
  AIC_uniform <- 2 * k_uniform - 2 * logLik_uniform

  # Return AIC
  return(AIC_uniform)
}
