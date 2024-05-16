#' Calculate Akaike Information Criterion (AIC) for Zero-Truncated Binomial Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a
#' zero-truncated binomial (ZTB) distribution fitted to the provided data.
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters (`size` and `prob`) of a ZTB
#' distribution from the provided data using maximum likelihood estimation
#' (via the `optim()` function), and then calculates the AIC value based on the
#' fitted distribution.
#'
#' @param .x A numeric vector containing the data (non-zero counts) to be
#'   fitted to a ZTB distribution.
#'
#' @details
#' **Initial parameter estimates:** The choice of initial values for `size`
#' and `prob` can impact the convergence of the optimization. Consider using
#' prior knowledge or method of moments estimates to obtain reasonable starting
#' values.
#'
#' **Optimization method:** The default optimization method used is
#' "L-BFGS-B," which allows for box constraints to keep the parameters within
#' valid bounds. You might explore other optimization methods available in
#' `optim()` for potentially better performance or different constraint
#' requirements.
#'
#' **Data requirements:** The input data `.x` should consist of non-zero counts,
#' as the ZTB distribution does not include zero values. Additionally, the
#' values in `.x` should be less than or equal to the estimated `size` parameter.
#'
#' **Goodness-of-fit:** While AIC is a useful metric for model comparison, it's
#' recommended to also assess the goodness-of-fit of the chosen ZTB model using
#' visualization (e.g., probability plots, histograms) and other statistical
#' tests (e.g., chi-square goodness-of-fit test) to ensure it adequately
#' describes the data.
#'
#' @examples
#'
#' # Example data
#' set.seed(123)
#' x <- tidy_zero_truncated_binomial(30, .size = 10, .prob = 0.4)[["y"]]
#'
#' # Calculate AIC
#' util_zero_truncated_binomial_aic(x)
#'
#' @return The AIC value calculated based on the fitted ZTB distribution to
#'   the provided data.
#'
#' @name util_zero_truncated_binomial_aic
NULL

#' @export
#' @rdname util_zero_truncated_binomial_aic

util_zero_truncated_binomial_aic <- function(.x) {
  # Check if actuar library is installed
  if (!requireNamespace("actuar", quietly = TRUE)) {
    stop("The 'actuar' package is needed for this function. Please install it with: install.packages('actuar')")
  }

  # Tidyeval
  x <- as.numeric(.x)

  # Negative log-likelihood function for zero-truncated binomial distribution
  neg_log_lik_rztbinom <- function(params, data) {
    size <- params[1]
    prob <- params[2]
    n <- length(data)
    -sum(actuar::dztbinom(data, size = size, prob = prob, log = TRUE))
  }

  # Initial parameter guesses (adjust if needed)
  pe <- util_zero_truncated_binomial_param_estimate(x)$parameter_tbl

  # Fit zero-truncated binomial distribution to data
  fit_rztbinom <- stats::optim(
    par = c(size = round(pe$size, 3), prob = round(pe$prob, 3)),
    fn = neg_log_lik_rztbinom,
    data = x
  ) |>
    suppressWarnings()

  # Extract log-likelihood and number of parameters
  logLik_rztbinom <- round(-fit_rztbinom$value, 4)
  k_rztnbinom <- 2  # Number of parameters (size and prob)

  # Calculate AIC
  AIC_rztbinom <- 2 * k_rztnbinom - 2 * logLik_rztbinom

  # Return AIC value
  return(AIC_rztbinom)
}
