#' Calculate Akaike Information Criterion (AIC) for Zero-Truncated Negative Binomial Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a
#' zero-truncated negative binomial (ZTNB) distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters (`size` and `prob`) of a ZTNB
#' distribution from the provided data using maximum likelihood estimation
#' (via the `optim()` function), and then calculates the AIC value based on the
#' fitted distribution.
#'
#' @param .x A numeric vector containing the data (non-zero counts) to be
#'   fitted to a ZTNB distribution.
#'
#' @details
#' **Initial parameter estimates:** The choice of initial values for `size`
#' and `prob` can impact the convergence of the optimization. Consider using
#' prior knowledge or method of moments estimates to obtain reasonable starting
#' values.
#'
#' **Optimization method:** The default optimization method used is
#' "Nelder-Mead". You might explore other optimization methods available in
#' `optim()` for potentially better performance or different constraint
#' requirements.
#'
#' **Data requirements:** The input data `.x` should consist of non-zero counts,
#' as the ZTNB distribution does not include zero values.
#'
#' **Goodness-of-fit:** While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen ZTNB model using
#' visualization (e.g., probability plots, histograms) and other statistical
#' tests (e.g., chi-square goodness-of-fit test) to ensure it adequately
#' describes the data.
#'
#' @examples
#' library(actuar)
#'
#' # Example data
#' set.seed(123)
#' x <- rztnbinom(30, size = 2, prob = 0.4)
#'
#' # Calculate AIC
#' util_zero_truncated_negative_binomial_aic(x)
#'
#' @return The AIC value calculated based on the fitted ZTNB distribution to
#'   the provided data.
#'
#' @name util_zero_truncated_negative_binomial_aic
NULL

#' @export
#' @rdname util_zero_truncated_negative_binomial_aic

util_zero_truncated_negative_binomial_aic <- function(.x) {
  # Check if actuar library is installed
  if (!requireNamespace("actuar", quietly = TRUE)) {
    stop("The 'actuar' package is needed for this function. Please install it with: install.packages('actuar')")
  }

  # Tidyeval
  x <- as.numeric(.x)

  # Get parameters
  pe <- TidyDensity::util_zero_truncated_negative_binomial_param_estimate(x)$parameter_tbl

  # Negative log-likelihood function for zero-truncated negative binomial distribution
  neg_log_lik_rztnbinom <- function(par, data) {
    size <- par[1]
    prob <- par[2]
    -sum(actuar::dztnbinom(data, size = size, prob = prob, log = TRUE))
  }

  # Fit zero-truncated negative binomial distribution to data
  fit_rztnbinom <- stats::optim(
    par = c(size = round(pe$size, 3), prob = round(pe$prob, 3)),
    fn = neg_log_lik_rztnbinom,
    data = x
  ) |>
    suppressWarnings()

  # Extract log-likelihood and number of parameters
  logLik_rztnbinom <- -fit_rztnbinom$value
  k_rztnbinom <- 2  # Number of parameters (size and prob)

  # Calculate AIC
  AIC_rztnbinom <- 2 * k_rztnbinom - 2 * logLik_rztnbinom

  # Return AIC value
  return(AIC_rztnbinom)
}
