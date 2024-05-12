#' Calculate Akaike Information Criterion (AIC) for Triangular Distribution
#'
#' This function calculates the Akaike Information Criterion (AIC) for a
#' triangular distribution fitted to the provided data.
#'
#' @family Utility
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function estimates the parameters of a triangular distribution
#' (min, max, and mode) from the provided data and calculates the AIC value
#' based on the fitted distribution.
#'
#' @details
#' The function operates in several steps:
#' 1. **Parameter Estimation**: The function extracts the minimum, maximum, and
#' mode values from the data via the `TidyDensity::util_triangular_param_estimate`
#' function. It returns these initial parameters as the starting point for
#' optimization.
#' 2. **Negative Log-Likelihood Calculation**: A custom function calculates the
#' negative log-likelihood using the `EnvStats::dtri` function to obtain density
#' values for each data point. The densities are logged manually to simulate the
#' behavior of a `log` parameter.
#' 3. **Parameter Validation**: During optimization, the function checks that the
#' constraints `min <= mode <= max` are met, and returns an infinite loss if not.
#' 4. **Optimization**: The optimization process utilizes the "SANN"
#' (Simulated Annealing) method to minimize the negative log-likelihood and find
#' optimal parameter values.
#' 5. **AIC Calculation**: The Akaike Information Criterion (AIC) is calculated
#' using the optimized negative log-likelihood and the total number of parameters
#' (3).
#'
#' @param .x A numeric vector containing the data to be fitted to a triangular
#' distribution.
#'
#' @examples
#' # Example: Calculate AIC for a sample dataset
#' set.seed(123)
#' data <- tidy_triangular(.min = 0, .max = 1, .mode = 1/2)$y
#' util_triangular_aic(data)
#'
#' @return
#' The AIC value calculated based on the fitted triangular distribution to the provided data.
#'
#' @name util_triangular_aic
NULL

#' @export
#' @rdname util_triangular_aic
util_triangular_aic <- function(.x) {
  # Convert the input to numeric
  x <- as.numeric(.x)

  # Estimate triangular distribution parameters: min, max, and mode
  pe <- TidyDensity::util_triangular_param_estimate(x)$parameter_tbl
  min_val <- pe$min
  max_val <- pe$max
  mode_val <- pe$mode

  # Ensure the initial guesses respect the constraints min <= mode <= max
  initial_par <- c(min_val, max_val, mode_val)

  # Negative log-likelihood function for triangular distribution
  neg_log_lik_tri <- function(par, data) {
    min_val <- par[1]
    max_val <- par[2] + 1e-6  # Add a small value to avoid numerical issues
    mode_val <- par[3]

    # Validate the parameter constraints
    if (min_val > mode_val || mode_val > max_val) {
      return(Inf)  # Invalid parameter combination returns an infinite loss
    }

    # Calculate the density using dtri and then take the log manually
    density_vals <- EnvStats::dtri(data, min = min_val, max = max_val, mode = mode_val)
    log_density_vals <- log(density_vals)

    # Sum the negative log-density values
    -sum(log_density_vals, na.rm = TRUE)
  }

  # Fit triangular distribution to the data
  fit_tri <- stats::optim(
    par = initial_par,
    fn = neg_log_lik_tri,
    data = x,
    method = "SANN"
  )

  # Extract log-likelihoods and number of parameters
  logLik_tri <- -fit_tri$value
  k_tri <- 3  # Number of parameters for the triangular distribution (min, max, and mode)

  # Calculate AIC
  AIC_tri <- 2 * k_tri - 2 * logLik_tri

  # Return the calculated AIC value
  return(AIC_tri)
}
