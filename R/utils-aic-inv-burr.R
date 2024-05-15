#' Calculate Akaike Information Criterion (AIC) for Inverse Burr Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for an inverse Burr
#' distribution fitted to the provided data.
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape1, shape2, and rate parameters of an inverse Burr distribution
#' from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to an inverse Burr distribution.
#'
#' @details
#' This function fits an inverse Burr distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape1, shape2, and rate parameters
#' of the inverse Burr distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the shape1, shape2, and rate parameters of the inverse Burr distribution.
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
#' x <- tidy_inverse_burr(100, .shape1 = 2, .shape2 = 3, .scale = 1)[["y"]]
#' util_inverse_burr_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted inverse Burr distribution to the provided data.
#'
#' @name util_inverse_burr_aic
NULL

#' @export
#' @rdname util_inverse_burr_aic
util_inverse_burr_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for inverse Burr distribution
  neg_log_lik_invburr <- function(par, data) {
    shape1 <- par[1]
    shape2 <- par[2]
    scale <- par[3]
    -sum(actuar::dinvburr(data, shape1 = shape1, shape2 = shape2, scale = scale, log = TRUE))
  }

  # Initial parameter estimates
  initial_params <- c(shape1 = 1, shape2 = 1, scale = 1)

  # Fit inverse Burr distribution using optim
  fit_invburr <- stats::optim(
    par = initial_params,
    fn = neg_log_lik_invburr,
    data = x,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5, 1e-5)
  )

  # Extract log-likelihood and number of parameters
  logLik_invburr <- -fit_invburr$value
  k_invburr <- 3 # Number of parameters for inverse Burr distribution (shape1, shape2, and scale)

  # Calculate AIC
  AIC_invburr <- 2 * k_invburr - 2 * logLik_invburr

  # Return AIC
  return(AIC_invburr)
}
