#' Calculate Akaike Information Criterion (AIC) for Gamma Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a gamma
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape and scale parameters of a gamma distribution
#' from the provided data using maximum likelihood estimation, and then calculates
#' the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a gamma distribution.
#'
#' @details
#' This function fits a gamma distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape and scale parameters of the
#' gamma distribution using maximum likelihood estimation. Then, it calculates
#' the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments
#' estimates as starting points for the shape and scale parameters of the
#' gamma distribution.
#'
#' Optimization method: The function uses the optim function for optimization.
#' You might explore different optimization methods within optim for potentially
#' better performance.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rgamma(30, shape = 1)
#' util_gamma_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted gamma distribution to the provided data.
#'
#' @name util_gamma_aic
NULL

#' @export
#' @rdname util_gamma_aic
util_gamma_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for gamma distribution
  neg_log_lik_gamma <- function(par, data) {
    shape <- par[1]
    scale <- par[2]
    n <- length(data)
    -sum(stats::dgamma(data, shape = shape, scale = scale, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  pe <- TidyDensity::util_gamma_param_estimate(x)$parameter_tbl |>
    subset(method == "EnvStats_MMUE")

  # Fit gamma distribution using optim
  fit_gamma <- stats::optim(
    c(pe$shape, pe$scale),
    neg_log_lik_gamma,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_gamma <- -fit_gamma$value
  k_gamma <- 2 # Number of parameters for gamma distribution (shape and scale)

  # Calculate AIC
  AIC_gamma <- 2 * k_gamma - 2 * logLik_gamma

  # Return AIC
  return(AIC_gamma)
}
