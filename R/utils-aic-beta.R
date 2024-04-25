#' Calculate Akaike Information Criterion (AIC) for Beta Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a beta
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a beta distribution from the provided
#' data using maximum likelihood estimation, and then calculates the AIC value
#' based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a beta
#' distribution.
#'
#' @details
#' Initial parameter estimates: The choice of initial values can impact the
#' convergence of the optimization.
#'
#' Optimization method: You might explore different optimization methods within
#' optim for potentially better performance.
#' Data transformation: Depending on your data, you may need to apply
#' transformations (e.g., scaling to `[0,1]` interval) before fitting the beta
#' distribution.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rbeta(30, 1, 1)
#' util_beta_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted beta distribution to the
#' provided data.
#'
#' @name util_beta_aic
NULL

#' @export
#' @rdname util_beta_aic
util_beta_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Scale data to [0, 1] if not already in that range
  if (any(x < 0) || any(x > 1)) {
    x <- (x - min(x)) / (max(x) - min(x))
  }

  # Get parameters
  pe <- TidyDensity::util_beta_param_estimate(x)$parameter_tbl |>
    subset(method == "EnvStats_MME")

  # Negative log-likelihood function for beta distribution
  neg_log_lik_beta <- function(par, data) {
    shape1 <- par[1]
    shape2 <- par[2]
    ncp <- par[3]
    n <- length(data)
    -sum(stats::dbeta(data, shape1, shape2, ncp, log = TRUE))
  }

  # Fit beta distribution using optim
  fit_beta <- stats::optim(
    c(round(pe$shape1, 0), round(pe$shape2, 0), 0),
    neg_log_lik_beta,
    data = x
  )

  # Extract log-likelihood and number of parameters
  logLik_beta <- -fit_beta$value
  k_beta <- 3 # Number of parameters for beta distribution (shape1, shape2, ncp)

  # Calculate AIC
  AIC_beta <- 2 * k_beta - 2 * logLik_beta

  # Return AIC
  return(AIC_beta)
}
