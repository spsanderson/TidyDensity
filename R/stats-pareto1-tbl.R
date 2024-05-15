#' Distribution Statistics for Pareto1 Distribution
#'
#' @family Pareto
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
#' tidy_pareto1() |>
#'   util_pareto1_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @name util_pareto1_stats_tbl
NULL
#' @export
#' @rdname util_pareto1_stats_tbl

util_pareto1_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_pareto_single_parameter") {
    rlang::abort(
      message = "You must use 'tidy_pareto1()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  xm <- atb$.min
  alpha <- atb$.shape

  stat_mean <- ifelse(alpha <= 1, Inf, (alpha * xm) / (alpha - 1))
  stat_mode <- xm
  stat_coef_var <- ifelse(
    alpha <= 2,
    Inf,
    sqrt((alpha) / ((alpha - 1)^2 * (alpha - 2)))
  )
  stat_sd <- ifelse(
    alpha <= 1,
    Inf,
    sqrt((alpha * xm^2) / ((alpha - 1)^2 * (alpha - 2)))
  )
  stat_skewness <- ifelse(
    alpha <= 3,
    "undefined",
    (2 * (1 + alpha)) / (alpha - 3) * sqrt((alpha - 2) / alpha)
  )
  stat_kurtosis <- ifelse(
    alpha <= 4,
    "undefined",
    (6 * (alpha^3 + alpha^2 - 6 * alpha - 2)) / (alpha * (alpha - 3) * (alpha - 4))
  )

  # Data Tibble
  ret <- dplyr::tibble(
    tidy_function = atb$tibble_type,
    function_call = atb$dist_with_params,
    distribution = "Pareto1",
    distribution_type = "Continuous",
    points = atb$.n,
    simulations = atb$.num_sims,
    mean = stat_mean,
    mode_lower = stat_mode,
    range = paste0(xm, " to Inf"),
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
