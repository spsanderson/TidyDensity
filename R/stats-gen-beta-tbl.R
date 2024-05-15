#' Distribution Statistics
#'
#' @family Generalized Beta
#' @family Distribution Statistics
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
#' set.seed(123)
#' tidy_generalized_beta() |>
#'   util_generalized_beta_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @export
#' @rdname util_generalized_beta_stats_tbl
util_generalized_beta_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_generalized_beta") {
    rlang::abort(
      message = "You must use 'tidy_generalized_beta()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  shape1 <- atb$.shape1
  shape2 <- atb$.shape2
  shape3 <- atb$.shape3
  rate <- atb$.rate
  scale <- 1 / rate

  # Generalized Beta statistics calculation
  stat_mean <- ifelse(shape2 > 1, shape1 / (shape2 - 1), "undefined")
  stat_mode <- ifelse((shape1 > 1) & (shape2 > 2), (shape1 - 1) / (shape2 - 2), "undefined")
  stat_var <- ifelse(shape2 > 2, (shape1 * shape2) / ((shape2 - 1)^2 * (shape2 - 2)), "undefined")
  stat_sd <- ifelse(stat_var == "undefined", "undefined", sqrt(stat_var))
  stat_skewness <- ifelse(shape2 > 3, (2 * (shape2 - 2 * shape1) * sqrt(shape2 - 2)) / ((shape2 - 3) * sqrt(shape1 * (shape1 + shape2))), "undefined")
  stat_kurtosis <- ifelse(shape2 > 4, 3 + (6 * (shape2^3 - 2 * shape2^2 * (shape1 - 1) + shape1^2 * (shape1 + 1))) / (shape1 * (shape1 + 1) * (shape2 - 3) * (shape2 - 4)), "undefined")

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
    range = paste0("0 to Inf"),
    std_dv = stat_sd,
    coeff_var = ifelse(stat_var == "undefined", "undefined", sqrt(stat_var) / stat_mean),
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
