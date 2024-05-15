#' Distribution Statistics
#'
#' @family Generalized Pareto
#' @family Distribution Statistics
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will take in a tibble and return the statistics
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
#' tidy_generalized_pareto() |>
#'   util_generalized_pareto_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @name util_generalized_pareto_stats_tbl
NULL
#' @export
#' @rdname util_generalized_pareto_stats_tbl
util_generalized_pareto_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_generalized_pareto") {
    rlang::abort(
      message = "You must use 'tidy_generalized_pareto()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  shape1 <- atb$.shape1
  shape2 <- atb$.shape2
  rate <- atb$.rate
  scale <- 1 / rate

  stat_mean <- ifelse(shape1 <= 1, Inf, scale * shape1 / (shape1 - 1))
  stat_mode <- scale * (shape1 - 1) / shape1
  stat_median <- scale * actuar::qgenpareto(0.5, shape1 = shape1, shape2 = shape2, scale = scale)
  stat_var <- ifelse(shape1 <= 2, Inf, (scale^2 * shape1) / ((shape1 - 1)^2 * (shape1 - 2)))
  stat_skewness <- ifelse(shape1 <= 3, "undefined", 2 * (1 + shape1) / (shape1 - 3) * sqrt((shape1 - 2) / shape1))
  stat_kurtosis <- ifelse(shape1 <= 4, "undefined", 6 * (shape1^3 + shape1^2 - 6 * shape1 - 2) / (shape1 * (shape1 - 3) * (shape1 - 4)))

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
    coeff_var = sqrt(stat_var) / stat_mean,
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
