#' Calculate Akaike Information Criterion (AIC) for Log-Normal Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a log-normal distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the meanlog and sdlog parameters of a log-normal
#' distribution from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a log-normal distribution.
#'
#' @details
#' This function fits a log-normal distribution to the provided data using maximum
#' likelihood estimation. It estimates the meanlog and sdlog parameters
#' of the log-normal distribution using maximum likelihood estimation. Then, it
#' calculates the AIC value based on the fitted distribution.
#'
#' Initial parameter estimates: The function uses the method of moments estimates
#' as starting points for the meanlog and sdlog parameters of the log-normal
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
#' x <- rlnorm(100, meanlog = 0, sdlog = 1)
#' util_lognormal_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted log-normal distribution to the provided data.
#'
#' @name util_lognormal_aic
#'
#' @export
#' @rdname util_lognormal_aic
util_lognormal_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for log-normal distribution
  neg_log_lik_lognormal <- function(par, data) {
    meanlog <- par[1]
    sdlog <- par[2]
    n <- length(data)
    -sum(stats::dlnorm(data, meanlog = meanlog, sdlog = sdlog, log = TRUE))
  }

  # Get initial parameter estimates: method of moments
  m1 <- mean(log(x))
  m2 <- mean(log(x)^2)
  meanlog_est <- m1
  sdlog_est <- sqrt(m2 - m1^2)

  # Fit log-normal distribution using optim
  fit_lognormal <- stats::optim(
    c(meanlog_est, sdlog_est),
    neg_log_lik_lognormal,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_lognormal <- -fit_lognormal$value
  k_lognormal <- 2 # Number of parameters for log-normal distribution (meanlog and sdlog)

  # Calculate AIC
  AIC_lognormal <- 2 * k_lognormal - 2 * logLik_lognormal

  # Return AIC
  return(AIC_lognormal)
}
