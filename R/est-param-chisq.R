#' Estimate Chisquare Parameters
#'
#' @family Parameter Estimation
#' @family Chisquare
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will see if the given vector `.x` is a numeric vector.
#' It will attempt to estimate the prob parameter of a Chisquare distribution.
#' The function first performs tidyeval on the input data to ensure it's a
#' numeric vector. It then checks if there are at least two data points, as this
#' is a requirement for parameter estimation.
#'
#' The estimation of the chi-square distribution parameters is performed using
#' maximum likelihood estimation (MLE) implemented with the `bbmle` package.
#' The negative log-likelihood function is minimized to obtain the estimates for
#' the degrees of freedom (\code{doff}) and the non-centrality parameter (\code{ncp}).
#' Initial values for the optimization are set based on the sample variance and
#' mean, but these can be adjusted if necessary.
#'
#' If the estimation fails or encounters an error, the function returns \code{NA}
#' for both \code{doff} and \code{ncp}.
#'
#' Finally, the function returns a tibble containing the following information:
#' \describe{
#'   \item{dist_type}{The type of distribution, which is "Chisquare" in this case.}
#'   \item{samp_size}{The sample size, i.e., the number of data points in the input vector.}
#'   \item{min}{The minimum value of the data points.}
#'   \item{max}{The maximum value of the data points.}
#'   \item{mean}{The mean of the data points.}
#'   \item{degrees_of_freedom}{The estimated degrees of freedom (\code{doff}) for the chi-square distribution.}
#'   \item{ncp}{The estimated non-centrality parameter (\code{ncp}) for the chi-square distribution.}
#' }
#'
#' Additionally, if the argument \code{.auto_gen_empirical} is set to \code{TRUE}
#' (which is the default behavior), the function also returns a combined tibble
#' containing both empirical and chi-square distribution data, obtained by
#' calling \code{tidy_empirical} and \code{tidy_chisquare}, respectively.
#'
#' @description This function will attempt to estimate the Chisquare prob parameter
#' given some vector of values `.x`. The function will return a list output by default,
#' and  if the parameter `.auto_gen_empirical` is set to `TRUE` then the empirical
#' data given to the parameter `.x` will be run through the `tidy_empirical()`
#' function and combined with the estimated Chisquare data.
#'
#' @param .x The vector of data to be passed to the function. Must be non-negative
#' integers.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' tc <- tidy_chisquare(.n = 500, .df = 6, .ncp = 1) |> pull(y)
#' output <- util_chisquare_param_estimate(tc)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @name util_chisquare_param_estimate
NULL

#' @export
#' @rdname util_chisquare_param_estimate

util_chisquare_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)
  minx <- min(as.numeric(x_term))
  maxx <- max(as.numeric(x_term))

  # Checks ----
  if (!is.vector(x_term, mode = "numeric")) {
    rlang::abort(
      message = "The '.x' term must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  if (n < 2) {
    rlang::abort(
      message = "You must supply at least two data points for this function.",
      use_cli_format = TRUE
    )
  }

  # Parameters ----
  # estimate_chisq_params <- function(data) {
  #   # Negative log-likelihood function
  #   negLogLik <- function(df, ncp) {
  #     -sum(stats::dchisq(data, df = df, ncp = ncp, log = TRUE))
  #   }
  #
  #   # Initial values (adjust based on your data if necessary)
  #   start_vals <- list(df = trunc(var(data)/2), ncp = trunc(mean(data)))
  #
  #   # MLE using bbmle
  #   mle_fit <- bbmle::mle2(negLogLik, start = start_vals)
  #   # Return estimated parameters as a named vector
  #   df <- dplyr::tibble(
  #     est_df = bbmle::coef(mle_fit)[1],
  #     est_ncp = bbmle::coef(mle_fit)[2]
  #   )
  #   return(df)
  # }
  #
  # safe_estimates <- {
  #   purrr::possibly(
  #     estimate_chisq_params,
  #     otherwise = NA_real_,
  #     quiet = TRUE
  #   )
  # }
  #
  # estimates <- safe_estimates(x_term)
  # Define negative log-likelihood function
  neg_log_likelihood <- function(params) {
    df <- params[1]
    ncp <- params[2]
    sum_densities <- sum(stats::dchisq(x_term, df = df, ncp = ncp, log = TRUE))
    return(-sum_densities)
  }

  # Initial guess for parameters
  initial_params <- c(trunc(var(x_term)/2), trunc(mean(x_term)))

  # Optimize parameters using optim() function
  opt_result <- stats::optim(par = initial_params, fn = neg_log_likelihood)

  # Extract estimated parameters
  doff <- opt_result$par[1]
  ncp <- opt_result$par[2]

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    tc <- tidy_chisquare(.n = n, .df = round(doff, 3), .ncp = round(ncp, 3))
    combined_tbl <- tidy_combine_distributions(te, tc)
  }

  ret <- dplyr::tibble(
    dist_type = "Chisquare",
    samp_size = n,
    min = minx,
    max = maxx,
    mean = mean(x_term),
    dof = doff,
    ncp = ncp
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "chisquare"
  attr(ret, "x_term") <- .x
  attr(ret, "n") <- n

  if (.auto_gen_empirical) {
    output <- list(
      combined_data_tbl = combined_tbl,
      parameter_tbl     = ret
    )
  } else {
    output <- list(
      parameter_tbl = ret
    )
  }

  return(output)
}
