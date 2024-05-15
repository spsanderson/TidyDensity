#' Distribution Statistics
#'
#' @family Inverse Burr
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
#' tidy_inverse_burr() |>
#'   util_inverse_burr_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @name util_inverse_burr_stats_tbl
NULL

#' @export
#' @rdname util_inverse_burr_stats_tbl

util_inverse_burr_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_inverse_burr") {
    rlang::abort(
      message = "You must use 'tidy_inverse_burr()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  s1 <- atb$.shape1
  s2 <- atb$.shape2
  r  <- atb$.rate
  sc <- 1/r

  stat_mean <- ifelse(s1 <= 1, Inf, sc * gamma(1 - 1/s1) * gamma(s2 + 1/s1) / gamma(s2))
  stat_mode <- sc * ((s2 - 1)/(s1 * s2 + 1))^(1/s2)
  stat_median <- sc * actuar::qinvburr(0.5, shape1 = s1, shape2 = s2, scale = sc)
  stat_var <- ifelse(s1 <= 2, Inf, sc^2 * (gamma(1 - 2/s1) * gamma(s2 + 2/s1) / gamma(s2) - (gamma(1 - 1/s1) * gamma(s2 + 1/s1) / gamma(s2))^2))
  stat_skewness <- ifelse(s1 <= 3, "undefined", (2 * (gamma(1 - 1/s1)^3 * gamma(s2 + 1/s1)^3 - 3 * gamma(1 - 1/s1) * gamma(1 - 2/s1) * gamma(s2 + 1/s1) * gamma(s2 + 2/s1) + gamma(1 - 3/s1) * gamma(s2 + 3/s1)) / (gamma(1 - 1/s1) * gamma(s2 + 1/s1) - gamma(1 - 2/s1) * gamma(s2 + 2/s1))^(3/2)))
  stat_kurtosis <- ifelse(s1 <= 4, "undefined", (gamma(1 - 4/s1) * gamma(s2 + 4/s1) - 4 * gamma(1 - 3/s1) * gamma(s2 + 3/s1) * gamma(1 - 1/s1) * gamma(s2 + 1/s1) + 6 * gamma(1 - 2/s1) * gamma(s2 + 2/s1) * gamma(1 - 1/s1)^2 * gamma(s2 + 1/s1)^2 - 3 * gamma(1 - 2/s1)^2 * gamma(s2 + 2/s1)^2) / (gamma(1 - 1/s1) * gamma(s2 + 1/s1) - gamma(1 - 2/s1) * gamma(s2 + 2/s1))^2)

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
    median = stat_median,
    coeff_var = sqrt(stat_var)/stat_mean,
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
