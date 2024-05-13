#' Calculate Akaike Information Criterion (AIC) for t Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a t
#' distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a t distribution from the provided
#' data using maximum likelihood estimation, and then calculates the AIC value
#' based on the fitted distribution.
#'
#' @param .x A numeric vector containing the data to be fitted to a t
#' distribution.
#'
#' @return The AIC value calculated based on the fitted t distribution to the
#' provided data.
#'
#' @details
#' This function fits a t distribution to the input data using maximum
#' likelihood estimation and then computes the Akaike Information Criterion (AIC)
#' based on the fitted distribution.
#'
#' @examples
#' # Generate t-distributed data
#' set.seed(123)
#' x <- rt(100, df = 5, ncp = 0.5)
#'
#' # Calculate AIC for the generated data
#' util_t_aic(x)
#'
#' @seealso
#' \code{\link[stats]{rt}} for generating t-distributed data,
#' \code{\link[stats]{optim}} for optimization.
#'
#' @name util_t_aic
NULL

#' @export
#' @rdname util_t_aic

util_t_aic <- function(.x) {
  # Tidyeval
  x_term <- as.numeric(.x)

  # Assume we have a utility function that estimates t-distribution parameters
  # util_t_param_estimate needs to be defined as in previous example
  pe <- util_t_param_estimate(x_term)$parameter_tbl |>
    dplyr::filter(method == "MLE")

  # Negative log-likelihood function for the t-distribution
  nll <- function(params) {
    df <- params[1]
    ncp <- params[2]
    if (df <= 0) return(Inf) # return Inf if params are not valid
    -sum(stats::dt(x_term, df, ncp, log = TRUE))
  }

  # Use optim to minimize the negative log-likelihood
  # Starting parameters from the parameter estimation function's MLE output
  start_params <- c(df = pe$df_est, ncp = pe$ncp_est) # Using MLE results for initial values

  fit_t <- stats::optim(start_params, nll, method = "CG") |>
    suppressWarnings()

  # Extract log-likelihood and number of parameters
  logLik_t <- -fit_t$value
  k_t <- 2 # Number of parameters for t distribution (df, ncp)

  # Calculate AIC
  AIC_t <- 2 * k_t - 2 * logLik_t

  # Return AIC
  return(AIC_t)
}
