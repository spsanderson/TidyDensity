#' Distribution Statistics
#'
#' @family Beta
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
#' tidy_beta() |>
#'   util_beta_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_beta_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_beta") {
    rlang::abort(
      message = "You must use 'tidy_beta()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  p <- atb$.shape1
  q <- atb$.shape2

  stat_mean <- p / (p + q)
  stat_mode <- ifelse((p > 1) & (q > 1), ((p - 1) / (p + q - 2)), "undefined")
  stat_sd <- sqrt((p * q) / ((p + q)^2 * (p + q + 1)))
  stat_skewness <- ((2 * (q - p)) * sqrt(p + q + 1)) / ((p + q + 2) * sqrt(p * q))
  stat_coef_var <- sqrt(q / (p * (p + q + 1)))

  # Data Tibble
  ret <- dplyr::tibble(
    tidy_function = atb$tibble_type,
    function_call = atb$dist_with_params,
    distribution = dist_type_extractor(atb$tibble_type),
    distribution_type = atb$distribution_family_type,
    points = atb$.n,
    simulations = atb$.num_sims,
    mean = stat_mean,
    mode = stat_mode,
    range = paste0("0 to 1"),
    std_dv = stat_sd,
    coeff_var = stat_coef_var,
    skewness = stat_skewness,
    kurtosis = NA,
    computed_std_skew = tidy_skewness_vec(data_tbl$y),
    computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
    ci_lo = ci_lo(data_tbl$y),
    ci_hi = ci_hi(data_tbl$y)
  )

  # Return
  return(ret)
}
