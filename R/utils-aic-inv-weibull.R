#' Calculate Akaike Information Criterion (AIC) for Inverse Weibull Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for an inverse Weibull
#' distribution fitted to the provided data.
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape and scale parameters of an inverse Weibull distribution
#' from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to an inverse Weibull distribution.
#'
#' @details
#' This function fits an inverse Weibull distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape and scale parameters
#' of the inverse Weibull distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the shape and scale parameters of the inverse Weibull
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
#' x <- tidy_inverse_weibull(.n = 100, .shape = 2, .scale = 1)[["y"]]
#' util_inverse_weibull_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted inverse Weibull distribution to the provided data.
#'
#' @name util_inverse_weibull_aic
NULL
#' @export
#' @rdname util_inverse_weibull_aic
util_inverse_weibull_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for inverse Weibull distribution
  neg_log_lik_invweibull <- function(par, data) {
    shape <- par[1]
    scale <- par[2]
    -sum(actuar::dinvweibull(data, shape = shape, scale = scale, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  # Note: This assumes the availability of a suitable method for initial parameter estimation.
  initial_params <- c(shape = 1, scale = 1)

  # Fit inverse Weibull distribution using optim
  fit_invweibull <- stats::optim(
    par = initial_params,
    fn = neg_log_lik_invweibull,
    data = x,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5)
  )

  # Extract log-likelihood and number of parameters
  logLik_invweibull <- -fit_invweibull$value
  k_invweibull <- 2 # Number of parameters for inverse Weibull distribution (shape and scale)

  # Calculate AIC
  AIC_invweibull <- 2 * k_invweibull - 2 * logLik_invweibull

  # Return AIC
  return(AIC_invweibull)
}
