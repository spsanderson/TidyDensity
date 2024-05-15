#' Calculate Akaike Information Criterion (AIC) for Generalized Pareto Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a generalized Pareto distribution fitted to the provided data.
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape1, shape2, and rate parameters of a generalized Pareto distribution
#' from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a generalized Pareto distribution.
#'
#' @details
#' This function fits a generalized Pareto distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape1, shape2, and rate parameters
#' of the generalized Pareto distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the shape1, shape2, and rate parameters of the generalized Pareto distribution.
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
#' x <- actuar::rgenpareto(100, shape1 = 1, shape2 = 2, scale = 3)
#' util_generalized_pareto_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted generalized Pareto distribution to the provided data.
#'
#' @name util_generalized_pareto_aic
NULL

#' @export
#' @rdname util_generalized_pareto_aic
util_generalized_pareto_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for generalized Pareto distribution
  neg_log_lik_genpareto <- function(par, data) {
    shape1 <- par[1]
    shape2 <- par[2]
    scale <- par[3]
    -sum(actuar::dgenpareto(data, shape1 = shape1, shape2 = shape2, scale = scale, log = TRUE))
  }

  # Initial parameter estimates
  pe <- TidyDensity::util_generalized_pareto_param_estimate(x)$parameter_tbl
  shape1_init <- pe$shape1
  shape2_init <- pe$shape2
  scale_init <- pe$scale
  initial_params <- c(shape1 = shape1_init, shape2 = shape2_init, scale = scale_init)

  # Fit generalized Pareto distribution using optim
  fit_genpareto <- stats::optim(
    par = initial_params,
    fn = neg_log_lik_genpareto,
    data = x,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5, 1e-5)
  )

  # Extract log-likelihood and number of parameters
  logLik_genpareto <- -fit_genpareto$value
  k_genpareto <- 3 # Number of parameters for generalized Pareto distribution (shape1, shape2, and scale)

  # Calculate AIC
  AIC_genpareto <- 2 * k_genpareto - 2 * logLik_genpareto

  # Return AIC
  return(AIC_genpareto)
}
