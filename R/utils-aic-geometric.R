#' Calculate Akaike Information Criterion (AIC) for Geometric Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a geometric
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the probability parameter of a geometric distribution
#' from the provided data and then calculates the AIC value based on the fitted
#' distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a geometric distribution.
#'
#' @details
#' This function fits a geometric distribution to the provided data. It estimates
#' the probability parameter of the geometric distribution from the data. Then,
#' it calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimate
#' as a starting point for the probability parameter of the geometric distribution.
#'
#' Optimization method: Since the parameter is directly calculated from the data,
#' no optimization is needed.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rgeom(100, prob = 0.2)
#' util_geometric_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted geometric distribution to the provided data.
#'
#' @name util_geometric_aic
NULL

#' @export
#' @rdname util_geometric_aic
util_geometric_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Estimate probability parameter
  prob <- 1 / mean(x)

  # Calculate AIC
  k_geometric <- 1 # Number of parameters for geometric distribution (prob)
  logLik_geometric <- sum(stats::dgeom(x, prob = prob, log = TRUE))
  AIC_geometric <- 2 * k_geometric - 2 * logLik_geometric

  # Return AIC
  return(AIC_geometric)
}
