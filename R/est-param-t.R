#' Estimate t Distribution Parameters
#'
#' @family Parameter Estimation
#' @family t Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the t distribution parameters
#' given some vector of values produced by `rt()`. The estimation method
#' uses both method of moments and maximum likelihood estimation.
#'
#' @param .x The vector of data to be passed to the function, where the data
#' comes from the `rt()` function.
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
#' x <- rt(100, df = 10, ncp = 0.5)
#' output <- util_t_param_estimate(x)
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

util_t_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)

  # Checks ----
  if (!inherits(x_term, "numeric")) {
    rlang::abort(
      message = "The '.x' parameter must be numeric.",
      use_cli_format = TRUE
    )
  }

  # Method of Moments Estimation ----
  m <- mean(x_term)
  s <- sd(x_term)
  df_mme <- n * s^2 / (n-1)

  # Initial parameter guesses for MLE
  start_params <- c(df = df_mme, ncp = m)

  # Negative Log Likelihood Function for the t-distribution
  nll <- function(params) {
    df <- params[1]
    ncp <- params[2]
    if (df <= 0) return(Inf) # Ensure df is positive
    -sum(stats::dt(x_term, df, ncp, log = TRUE))
  }

  # Minimize Negative Log Likelihood
  optim_res <- stats::optim(start_params, nll, method = "CG") |>
    suppressWarnings()

  # Estimated Parameters
  optim_df <- round(optim_res$par[1], 3) |> unname()
  optim_ncp <- round(optim_res$par[2], 3) |> unname()

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td_mme <- tidy_t(.n = n, .df = round(df_mme, 3), .ncp = round(m, 3))
    td_optim <- tidy_t(.n = n, .df = round(optim_df, 3), .ncp = round(optim_ncp, 3))
    combined_tbl <- tidy_combine_distributions(te, td_mme, td_optim)
  }

  ret <- dplyr::tibble(
    dist_type = rep("T Distribution", 2),
    samp_size = rep(n, 2),
    mean      = m,
    variance  = s^2,
    method    = c("MME", "MLE"),
    df_est    = c(df_mme, optim_df),
    ncp_est   = c(m, optim_ncp)
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "t_distribution"
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
