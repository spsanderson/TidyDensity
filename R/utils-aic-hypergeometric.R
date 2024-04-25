#' Calculate Akaike Information Criterion (AIC) for Hypergeometric Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a
#' hypergeometric distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters m, n, and k of a hypergeometric distribution
#' from the provided data and then calculates the AIC value based on the fitted
#' distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a hypergeometric
#' distribution.
#'
#' @details
#' This function fits a hypergeometric distribution to the provided data. It
#' estimates the parameters m, n, and k of the hypergeometric distribution from
#' the data. Then, it calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function does not estimate parameters; they
#' are directly calculated from the data.
#'
#' Optimization method: Since the parameters are directly calculated from the
#' data, no optimization is needed.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rhyper(100, m = 10, n = 10, k = 5)
#' util_hypergeometric_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted hypergeometric distribution to the provided data.
#'
#' @name util_hypergeometric_aic
NULL

#' @export
#' @rdname util_hypergeometric_aic
util_hypergeometric_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Estimate parameters m, n, and k
  N <- length(x)
  k <- max(x)
  n <- N
  m <- N - k

  # Calculate AIC
  k_hypergeometric <- 3 # Number of parameters for hypergeometric distribution (m, n, and k)
  logLik_hypergeometric <- sum(stats::dhyper(x, m = m, n = n, k = k, log = TRUE))
  AIC_hypergeometric <- 2 * k_hypergeometric - 2 * logLik_hypergeometric

  # Return AIC
  return(AIC_hypergeometric)
}
