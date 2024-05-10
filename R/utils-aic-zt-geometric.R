#' Calculate Akaike Information Criterion (AIC) for Zero-Truncated Geometric Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a
#' Zero-Truncated Geometric distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the probability parameter of a Zero-Truncated Geometric
#' distribution from the provided data and calculates the AIC value based on the
#' fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a Zero-Truncated
#' Geometric distribution.
#'
#' @details
#' This function fits a Zero-Truncated Geometric distribution to the provided
#' data. It estimates the probability parameter using the method of moments and
#' calculates the AIC value.
#'
#' Optimization method: Since the parameter is directly calculated from the data,
#' no optimization is needed.
#'
#' Goodness-of-fit: While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen model using
#' visualization and other statistical tests.
#'
#' @examples
#' library(actuar)
#'
#' # Example: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rztgeom(100, prob = 0.2)
#' util_zero_truncated_geometric_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted Zero-Truncated Geometric
#' distribution to the provided data.
#'
#' @name util_zero_truncated_geometric_aic
NULL

#' @export
#' @rdname util_zero_truncated_geometric_aic
util_zero_truncated_geometric_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Check input validity
  if (any(x <= 0)) {
    rlang::abort(
      message = "All values of '.x' must be positive non-zero integers.",
      use_cli_format = TRUE
    )
  }

  # Estimate the probability parameter for Zero-Truncated Geometric distribution
  prob <- TidyDensity::util_zero_truncated_geometric_param_estimate(x)$parameter_tbl |>
    dplyr::pull(prob)

  # Calculate log-likelihood for Zero-Truncated Geometric distribution
  k_ztgeom <- 1  # Number of parameters for the Zero-Truncated Geometric distribution (prob)
  logLik_ztgeom <- sum(actuar::dztgeom(x, prob = prob, log = TRUE))

  # Adjust for zero truncation (exclusion of zero)
  logLik_adjustment <- -length(x) * log(1 - actuar::dztgeom(0, prob = prob))
  logLik_ztgeom <- logLik_ztgeom + logLik_adjustment

  # Calculate AIC
  AIC_ztgeom <- 2 * k_ztgeom - 2 * logLik_ztgeom

  # Return AIC
  return(AIC_ztgeom)
}
