#' Calculate Akaike Information Criterion (AIC) for zero-truncated poisson Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a zero-truncated poisson distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a zero-truncated poisson distribution from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a zero-truncated poisson distribution.
#'
#' @examples
#' library(actuar)
#'
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rztpois(30, lambda = 3)
#' util_zero_truncated_poisson_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted zero-truncated poisson distribution to the provided data.
#'
#' @name util_zero_truncated_poisson_aic
NULL

#' @export
#' @rdname util_zero_truncated_poisson_aic

util_zero_truncated_poisson_aic <- function(.x) {
  # Validate input
  if (!is.numeric(.x) || any(!is.na(.x) & .x != as.integer(.x)) || any(.x < 0)) {
    stop("Input data (.x) must be a numeric vector of non-negative integers.")
  }

  x <- as.numeric(.x)

  # Get initial parameter estimates using TidyDensity package (if available)
  pe <- TidyDensity::util_zero_truncated_poisson_param_estimate(x)$parameter_tbl

  # Negative log-likelihood function for zero-truncated poisson distribution
  nll <- function(par, data) {
    lambda <- par[1]
    -sum(actuar::dztpois(data, lambda = lambda, log = TRUE))
  }

  # Fit zero-truncated poisson distribution to sample data (optimization)
  fit_ztp<- stats::optim(
    pe$lambda,
    nll,
    data = x,
    method = "Brent",
    lower = 0,
    upper = 1000
  )

  # Extract log-likelihood and number of parameters
  logLik_ztp<- -fit_ztp$value
  k_ztp <- length(pe)  # Number of parameters for zero-truncated poisson distribution (degrees of freedom and ncp)

  # Calculate AIC
  AIC_ztp <- 2 * k_ztp - 2 * logLik_ztp

  # Return AIC value
  return(AIC_ztp)
}
