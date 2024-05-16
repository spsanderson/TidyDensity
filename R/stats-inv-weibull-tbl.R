#' Distribution Statistics
#'
#' @family Inverse Weibull
#' @family Distribution Statistics
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will take in a tibble and returns the statistics
#' of the given type of `tidy_` distribution. It is required that data be
#' passed from a `tidy_` distribution function.
#'
#' @description Returns distribution statistics in a tibble.
#'
#' @param .data The data being passed from a `tidy_` distribution function.
#'
#' @examples
#' library(dplyr)
#'
#' set.seed(123)
#' tidy_inverse_weibull() |>
#'   util_inverse_weibull_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @name util_inverse_weibull_stats_tbl
NULL
#' @export
#' @rdname util_inverse_weibull_stats_tbl

util_inverse_weibull_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_inverse_weibull") {
    rlang::abort(
      message = "You must use 'tidy_inverse_weibull()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  t <- atb$.shape
  q <- atb$.scale

  # Negative log-likelihood function ----
  neg_log_lik <- function(params, data) {
    shape <- params[1]
    scale <- params[2]
    -sum(actuar::dinvweibull(data, shape = shape, scale = scale, log = TRUE))
  }

  # Initial parameter guesses
  initial_params <- c(shape = t, scale = q)

  # Optimize to minimize the negative log-likelihood
  opt_result <- stats::optim(
    par = initial_params,
    fn = neg_log_lik,
    data = data_tbl$y,
    method = "L-BFGS-B",
    lower = c(1e-5, 1e-5)
  )

  iw_shape <- opt_result$par[1]
  iw_scale <- opt_result$par[2]
  iw_rate <- 1 / iw_scale

  # Compute statistics
  stat_mean <- mean(actuar::rinvweibull(1e5, shape = iw_shape, scale = iw_scale))
  stat_median <- stats::quantile(data_tbl$y, 0.5)
  stat_mode <- iw_scale * (1 - 1 / iw_shape)^(1 / iw_shape)
  stat_sd <- sqrt(var(actuar::rinvweibull(1e5, shape = iw_shape, scale = iw_scale)))
  stat_coef_var <- stat_sd / stat_mean

  # Data Tibble
  ret <- dplyr::tibble(
    tidy_function = atb$tibble_type,
    function_call = atb$dist_with_params,
    distribution = dist_type_extractor(atb$tibble_type),
    distribution_type = atb$distribution_family_type,
    points = atb$.n,
    simulations = atb$.num_sims,
    mean = stat_mean,
    median = stat_median,
    mode = stat_mode,
    range = paste0("0 to Inf"),
    std_dv = stat_sd,
    coeff_var = stat_coef_var,
    computed_std_skew = tidy_skewness_vec(data_tbl$y),
    computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
    ci_lo = ci_lo(data_tbl$y),
    ci_hi = ci_hi(data_tbl$y)
  )

  # Return
  return(ret)
}
