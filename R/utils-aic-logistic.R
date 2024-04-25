#' Calculate Akaike Information Criterion (AIC) for Logistic Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a logistic distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the location and scale parameters of a logistic
#' distribution from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a logistic distribution.
#'
#' @details
#' This function fits a logistic distribution to the provided data using maximum
#' likelihood estimation. It estimates the location and scale parameters
#' of the logistic distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the location and scale parameters of the logistic
#' distribution.
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
#' x <- rlogis(30)
#' util_logistic_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted logistic distribution to the provided data.
#'
#' @name util_logistic_aic
NULL

#' @export
#' @rdname util_logistic_aic
util_logistic_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for logistic distribution
  neg_log_lik_logistic <- function(par, data) {
    location <- par[1]
    scale <- par[2]
    n <- length(data)
    -sum(stats::dlogis(data, location = location, scale = scale, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  pe <- TidyDensity::util_logistic_param_estimate(x)$parameter_tbl |>
    subset(method == "EnvStats_MLE")

  # Fit logistic distribution using optim
  fit_logistic <- stats::optim(
    c(pe$location, pe$scale),
    neg_log_lik_logistic,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_logistic <- -fit_logistic$value
  k_logistic <- 2 # Number of parameters for logistic distribution (location and scale)

  # Calculate AIC
  AIC_logistic <- 2 * k_logistic - 2 * logLik_logistic

  # Return AIC
  return(AIC_logistic)
}
