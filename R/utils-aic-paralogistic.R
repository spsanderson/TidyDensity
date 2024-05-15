#' Calculate Akaike Information Criterion (AIC) for Paralogistic Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a paralogistic distribution fitted to the provided data.
#'
#' @family Utility
#' @family Paralogistic
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the shape and rate parameters of a paralogistic
#' distribution from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a paralogistic distribution.
#'
#' @details
#' This function fits a paralogistic distribution to the provided data using maximum
#' likelihood estimation. It estimates the shape and rate parameters
#' of the paralogistic distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the shape and rate parameters of the paralogistic
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
#' x <- tidy_paralogistic(30, .shape = 2, .rate = 1)[["y"]]
#' util_paralogistic_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted paralogistic distribution to the provided data.
#'
#' @name util_paralogistic_aic
NULL

#' @export
#' @rdname util_paralogistic_aic
util_paralogistic_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for paralogistic distribution
  neg_log_lik_paralogis <- function(par, data) {
    shape <- par[1]
    rate <- par[2]
    -sum(actuar::dparalogis(data, shape = shape, rate = rate, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  pe <- TidyDensity::util_paralogistic_param_estimate(x)$parameter_tbl |>
    subset(method == "MLE")

  # Fit paralogistic distribution using optim
  fit_paralogis <- stats::optim(
    c(pe$shape, pe$rate),
    neg_log_lik_paralogis,
    data = x,
    method = "L-BFGS-B",
    lower = c(1e-10, 1e-10)
  )

  # Extract log-likelihood and number of parameters
  logLik_paralogis <- -fit_paralogis$value
  k_paralogis <- 2 # Number of parameters for paralogistic distribution (shape and rate)

  # Calculate AIC
  AIC_paralogis <- 2 * k_paralogis - 2 * logLik_paralogis

  # Return AIC
  return(AIC_paralogis)
}
