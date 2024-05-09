#' Calculate Akaike Information Criterion (AIC) for F Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for an F
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a F distribution from the provided
#' data using maximum likelihood estimation, and then calculates the AIC value
#' based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to an F
#' distribution.
#'
#' @return The AIC value calculated based on the fitted F distribution to the
#' provided data.
#'
#' @details
#' This function fits an F distribution to the input data using maximum
#' likelihood estimation and then computes the Akaike Information Criterion (AIC)
#' based on the fitted distribution.
#'
#' @examples
#' # Generate F-distributed data
#' set.seed(123)
#' x <- rf(100, df1 = 5, df2 = 10, ncp = 1)
#'
#' # Calculate AIC for the generated data
#' util_f_aic(x)
#'
#' @seealso
#' \code{\link[stats]{rf}} for generating F-distributed data,
#' \code{\link[stats]{optim}} for optimization.
#'
#' @name util_f_aic
NULL

#' @export
#' @rdname util_f_aic

util_f_aic <- function(.x) {
  # Tidyeval
  x_term <- as.numeric(.x)

  # Get initial parameter estimates
  pe <- TidyDensity::util_f_param_estimate(x_term)$parameter_tbl |>
    dplyr::filter(method == "MLE")

  # Negative log-likelihood function for the F-distribution
  nll <- function(params) {
    df1 <- params[1]
    df2 <- params[2]
    ncp <- params[3]
    if (df1 <= 0 || df2 <= 0 || ncp <= 0) return(Inf) # return Inf if params are not valid
    -sum(stats::df(x_term, df1, df2, ncp, log = TRUE))
  }

  # Initial parameter guesses
  start_params <- c(df1 = 1, df2 = 1, ncp = 0)

  # Use optim to minimize the negative log-likelihood
  fit_f <- stats::optim(start_params, nll, method = "L-BFGS-B",
                        lower = c(1e-6, 1e-6, 1e-6))

  # Extract log-likelihood and number of parameters
  logLik_f <- -fit_f$value
  k_f <- 3 # Number of parameters for F distribution (df1, df2, ncp)

  # Calculate AIC
  AIC_f <- 2 * k_f - 2 * logLik_f

  # Return AIC
  return(AIC_f)
}
