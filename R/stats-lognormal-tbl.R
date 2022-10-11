#' Distribution Statistics
#'
#' @family Lognormal
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
#' tidy_lognormal() %>%
#'   util_lognormal_stats_tbl() %>%
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_lognormal_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_lognormal") {
    rlang::abort(
      message = "You must use 'tidy_lognormal()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)

  exp_sigma <- exp(1)^(atb$.sdlog^2)
  stat_mean <- exp(1)^(0.5 * (atb$.sdlog^2))
  stat_median <- 1
  stat_mode <- (1 / exp_sigma)
  stat_sd <- sqrt(exp_sigma * (exp_sigma - 1))
  stat_skewness <- ((exp_sigma) + 2) * sqrt(exp_sigma - 1)
  stat_kurtosis <- (exp_sigma)^4 + (2 * ((exp_sigma)^3)) + 3 * (exp_sigma)^2 - 3
  stat_coef_var <- sqrt(exp_sigma - 1)

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
    skewness = stat_skewness,
    kurtosis = stat_kurtosis,
    computed_std_skew = tidy_skewness_vec(data_tbl$y),
    computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
    ci_lo = ci_lo(data_tbl$y),
    ci_hi = ci_hi(data_tbl$y)
  )

  # Return
  return(ret)
}
