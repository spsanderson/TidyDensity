#' Calculate Akaike Information Criterion (AIC) for Pareto Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a Pareto distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape and scale parameters of a Pareto distribution
#' from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a Pareto distribution.
#'
#' @details
#' This function fits a Pareto distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape and scale parameters
#' of the Pareto distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the shape and scale parameters of the Pareto distribution.
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
#' x <- TidyDensity::tidy_pareto()$y
#' util_pareto_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted Pareto distribution to the provided data.
#'
#' @name util_pareto_aic
NULL

#' @export
#' @rdname util_pareto_aic
util_pareto_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for Pareto distribution
  neg_log_lik_pareto <- function(par, data) {
    shape <- par[1]
    scale <- par[2]
    n <- length(data)
    -sum(actuar::dpareto(data, shape = shape, scale = scale, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  pe <- TidyDensity::util_pareto_param_estimate(x)$parameter_tbl |>
    subset(method == "MLE")

  # Fit Pareto distribution using optim
  fit_pareto <- stats::optim(
    c(pe$shape, pe$scale),
    neg_log_lik_pareto,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_pareto <- -fit_pareto$value
  k_pareto <- 2 # Number of parameters for Pareto distribution (shape and scale)

  # Calculate AIC
  AIC_pareto <- 2 * k_pareto - 2 * logLik_pareto

  # Return AIC
  return(AIC_pareto)
}
