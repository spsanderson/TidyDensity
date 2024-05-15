#' Distribution Statistics for Paralogistic Distribution
#'
#' @family Paralogistic
#' @family Distribution Statistics
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
#' tidy_paralogistic(.n = 50, .shape = 5, .rate = 6) |>
#'   util_paralogistic_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @name util_paralogistic_stats_tbl
NULL

#' @export
#' @rdname util_paralogistic_stats_tbl

util_paralogistic_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_paralogistic") {
    rlang::abort(
      message = "You must use 'tidy_paralogistic()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  shape <- atb$.shape
  rate <- atb$.rate

  stat_mean <- ifelse(shape > 1, rate / (shape - 1), Inf)
  stat_mode <- rate / (shape + 1)
  stat_coef_var <- ifelse(shape > 2, sqrt((shape) / ((shape - 2))), Inf)
  stat_sd <- ifelse(shape > 2, sqrt((rate^2) * shape / ((shape - 1)^2 * (shape - 2))), Inf)
  stat_skewness <- ifelse(shape > 3, 2 * (2 * shape - 1) / (shape - 3) * sqrt((shape - 2) / shape), "undefined")
  stat_kurtosis <- ifelse(shape > 4, 6 * (shape^3 + shape^2 - 6 * shape - 2) / (shape * (shape - 3) * (shape - 4)), "undefined")

  # Data Tibble
  ret <- dplyr::tibble(
    tidy_function = atb$tibble_type,
    function_call = atb$dist_with_params,
    distribution = "Paralogistic",
    distribution_type = "Continuous",
    points = atb$.n,
    simulations = atb$.num_sims,
    mean = stat_mean,
    mode_lower = stat_mode,
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
