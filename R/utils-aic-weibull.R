#' Calculate Akaike Information Criterion (AIC) for Weibull Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a Weibull
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape and scale parameters of a Weibull distribution
#' from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a Weibull distribution.
#'
#' @details
#' This function fits a Weibull distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape and scale parameters
#' of the Weibull distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the shape and scale parameters of the Weibull
#' distribution.
#'
#' Optimization method: The function uses the optim function for optimization.
#' You might explore different optimization methods within optim for potentially
#' better performance.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's recommended
#' to also assess the goodness-of-fit of the chosen model using visualization
#' and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rweibull(100, shape = 2, scale = 1)
#' util_weibull_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted Weibull distribution to the provided data.
#'
#' @name util_weibull_aic
#'
#' @export
#' @rdname util_weibull_aic
util_weibull_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for Weibull distribution
  neg_log_lik_weibull <- function(par, data) {
    shape <- par[1]
    scale <- par[2]
    n <- length(data)
    -sum(stats::dweibull(data, shape = shape, scale = scale, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  pe <- TidyDensity::util_weibull_param_estimate(x)$parameter_tbl

  # Fit Weibull distribution using optim
  fit_weibull <- stats::optim(
    c(pe$shape, pe$scale),
    neg_log_lik_weibull,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_weibull <- -fit_weibull$value
  k_weibull <- 2 # Number of parameters for Weibull distribution (shape and scale)

  # Calculate AIC
  AIC_weibull <- 2 * k_weibull - 2 * logLik_weibull

  # Return AIC
  return(AIC_weibull)
}
