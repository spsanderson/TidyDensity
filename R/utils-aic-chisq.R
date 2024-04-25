#' Calculate Akaike Information Criterion (AIC) for Chi-Square Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a chi-square distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a chi-square distribution from the provided data using maximum likelihood estimation,
#' and then calculates the AIC value based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a chi-square distribution.
#'
#' @examples
#' # Example 1: Calculate AIC for a sample dataset
#' set.seed(123)
#' x <- rchisq(30, df = 3)
#' util_chisq_aic(x)
#'
#' @return
#' The AIC value calculated based on the fitted chi-square distribution to the provided data.
#'
#' @name util_chisq_aic
#'
#' @export
#' @rdname util_chisq_aic
util_chisq_aic <- function(.x) {
  # Tidyeval
  x <- as.numeric(.x)

  # Get parameters
  pe <- TidyDensity::util_chisquare_param_estimate(x)$parameter_tbl |> utils::head(1)

  # Negative log-likelihood function for chi-square distribution
  neg_log_lik_chisq <- function(par, data) {
    df <- par[1]
    ncp <- par[2]
    n <- length(data)
    -sum(stats::dchisq(data, df = df, ncp = ncp, log = TRUE))
  }

  # Fit chi-square distribution to sample data (rchisq)
  fit_chisq <- stats::optim(
    c(pe$dof, pe$ncp),
    neg_log_lik_chisq,
    data = x
  )

  # Extract log-likelihood and number of params
  logLik_chisq <- -fit_chisq$value
  k_chisq <- 2  # Number of parameters for chi-square distribution (degrees of freedom or df)

  # Calculate AIC
  AIC_chisq <- 2 * k_chisq - 2 * logLik_chisq

  # Return
  return(AIC_chisq)
}
