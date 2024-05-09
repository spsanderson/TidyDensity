#' Estimate F Distribution Parameters
#'
#' @family Parameter Estimation
#' @family F Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the F distribution parameters
#' given some vector of values produced by `rf()`. The estimation method
#' is from the NIST Engineering Statistics Handbook.
#'
#' @param .x The vector of data to be passed to the function, where the data
#' comes from the `rf()` function.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' set.seed(123)
#' x <- rf(100, df1 = 5, df2 = 10, ncp = 1)
#' output <- util_f_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_f_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)
  minx <- min(as.numeric(x_term))
  maxx <- max(as.numeric(x_term))
  m <- mean(as.numeric(x_term))
  s <- var(x_term)

  # Checks ----
  if (!inherits(x_term, "numeric")) {
    rlang::abort(
      message = "The '.x' parameter must be numeric.",
      use_cli_format = TRUE
    )
  }

  # NIST MME ----
  m1 <- mean(x_term)
  m2 <- mean(x_term^2)
  m3 <- mean(x_term^3)
  m4 <- mean(x_term^4)

  b1 <- (m3 - m1 * m2) / (m2 - m1^2)
  b2 <- (m4 - 4 * m1 * m3 + 6 * m1^2 * m2 - 3 * m1^4) / (m2 - m1^2)^2

  df1_mme <- 2 * (2 * b2 - 3 * b1 - 6) / (b1 + 6)
  df2_mme <- 4 + 2 * b1 * df1_mme / (df1_mme - 2)
  ncp_mme <- (df1_mme * m1 - df1_mme + 2) / df2_mme

  # Round
  df1_mme <- ifelse(round(df1_mme, 3) <= 0, abs(round(df1_mme, 3)), round(df1_mme, 3))
  df2_mme <- ifelse(round(df2_mme, 3) <= 0, abs(round(df2_mme, 3)), round(df2_mme, 3))
  ncp_mme <- ifelse(round(ncp_mme, 3) <= 0, abs(round(ncp_mme, 3)), round(ncp_mme, 3))

  # Negative Log Likelihood ----
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
  optim_res <- stats::optim(start_params, nll, method = "L-BFGS-B",
                            lower = c(1e-6, 1e-6, 1e-6))

  # Return the estimated parameters
  optim_df1 <- round(optim_res$par[[1]], 3)
  optim_df2 <- round(optim_res$par[[2]], 3)
  optim_ncp <- round(optim_res$par[[3]], 3)

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td_mme <- tidy_f(.n = n,
                     .df1 = df1_mme, .df2 = df2_mme, .ncp = ncp_mme)
    td_optim <- tidy_f(.n = n,
                       .df1 = optim_df1, .df2 = optim_df2, .ncp = optim_ncp)
    combined_tbl <- tidy_combine_distributions(te, td_mme, td_optim)
  }

  ret <- dplyr::tibble(
    dist_type = rep("F Distribution", 2),
    samp_size = rep(n, 2),
    min       = minx,
    max       = maxx,
    mean      = m,
    variance  = s,
    method    = c("MME", "MLE"),
    df1_est   = c(df1_mme, optim_df1),
    df2_est   = c(df2_mme, optim_df2),
    ncp_est   = c(ncp_mme, optim_ncp)
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "f_distribution"
  attr(ret, "x_term") <- .x
  attr(ret, "n") <- length(x_term)

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
