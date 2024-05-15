#' Calculate Akaike Information Criterion (AIC) for Inverse Pareto Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for an inverse Pareto distribution fitted to the provided data.
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape and scale parameters of an inverse Pareto distribution
#' from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to an inverse Pareto distribution.
#'
#' @details
#' This function fits an inverse Pareto distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape and scale parameters
#' of the inverse Pareto distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the shape and scale parameters of the inverse Pareto distribution.
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
#' x <- tidy_inverse_pareto(.n = 100, .shape = 2, .scale = 1)[["y"]]
#' util_inverse_pareto_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted inverse Pareto distribution to
#' the provided data.
#'
#' @name util_inverse_pareto_aic
NULL

#' @export
#' @rdname util_inverse_pareto_aic
util_inverse_pareto_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for inverse Pareto distribution
  neg_log_lik_invpareto <- function(par, data) {
    shape <- par[1]
    scale <- par[2]
    -sum(actuar::dinvpareto(data, shape = shape, scale = scale, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  pe <- TidyDensity::util_inverse_pareto_param_estimate(x)$parameter_tbl
  shape <- pe$shape
  scale <- pe$scale
  initial_params <- c(shape = 1, scale = min(x))

  # Fit inverse Pareto distribution using optim
  fit_invpareto <- stats::optim(
    par = initial_params,
    fn = neg_log_lik_invpareto,
    data = x,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5)
  )

  # Extract log-likelihood and number of parameters
  logLik_invpareto <- -fit_invpareto$value
  k_invpareto <- 2 # Number of parameters for inverse Pareto distribution (shape and scale)

  # Calculate AIC
  AIC_invpareto <- 2 * k_invpareto - 2 * logLik_invpareto

  # Return AIC
  return(AIC_invpareto)
}
