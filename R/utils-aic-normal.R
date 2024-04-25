#' Calculate Akaike Information Criterion (AIC) for Normal Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a normal distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a normal distribution from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a normal distribution.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' data <- rnorm(30)
#' util_normal_aic(data)
#'
#' @return
#' The AIC value calculated based on the fitted normal distribution to the provided data.
#'
#' @name util_normal_aic
#'
#' @export
#' @rdname util_normal_aic
util_normal_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Get parameters
  pe <- TidyDensity::util_normal_param_estimate(x)$parameter_tbl |> utils::head(1)

  # Negative log-likelihood function for normal distribution
  neg_log_lik_norm <- function(par, data) {
    mu <- par[1]
    sigma <- par[2]
    n <- length(data)
    -sum(stats::dnorm(data, mean = mu, sd = sigma, log = TRUE))
  }

  # Fit normal distribution to population data (rnorm)
  fit_norm <- stats::optim(
    c(pe$mu, pe$stan_dev),
    neg_log_lik_norm,
    data = x
  )

  # Extract log-likelihoods and number of parameters
  logLik_norm <- -fit_norm$value
  k_norm <- 2  # Number of parameters for normal distribution (mu and sigma)

  # Calculate AIC
  AIC_norm <- 2 * k_norm - 2 * logLik_norm

  # Return
  return(AIC_norm)
}
