#' Distribution Statistics
#'
#' @family Binomial
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
#' tidy_binomial() |>
#'   util_binomial_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_binomial_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_binomial") {
    rlang::abort(
      message = "You must use 'tidy_binomial()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  n <- atb$.size
  p <- atb$.prob

  stat_mean <- n * p
  stat_mode <- c(p * (n + 1) - 1, p * (n + 1))
  stat_sd <- sqrt((p * n) / ((p + n)^2 * (p + n + 1)))
  stat_skewness <- (1 - 2 * p) / sqrt((n * p) * (1 - p))
  stat_kurtosis <- 3 - 6 / n + 1 / ((n * p) * (1 - p))
  stat_coef_var <- sqrt((1 - p) / (n * p))

  # Data Tibble
  ret <- dplyr::tibble(
    tidy_function = atb$tibble_type,
    function_call = atb$dist_with_params,
    distribution = dist_type_extractor(atb$tibble_type),
    distribution_type = atb$distribution_family_type,
    points = atb$.n,
    simulations = atb$.num_sims,
    mean = stat_mean,
    mode_lower = stat_mode[[1]],
    mode_upper = stat_mode[[2]],
    range = paste0("0 to ", n),
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
