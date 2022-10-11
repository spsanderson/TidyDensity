#' Distribution Statistics
#'
#' @family Geometric
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
#' tidy_geometric() %>%
#'   util_geometric_stats_tbl() %>%
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_geometric_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_geometric") {
    rlang::abort(
      message = "You must use 'tidy_geometric()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  p <- atb$.prob

  stat_mean <- (1 - p) / p
  stat_mode <- data_tbl %>%
    dplyr::filter(p == max(p)) %>%
    dplyr::pull(y) %>%
    max()
  stat_sd <- sqrt((1 - p) / p)
  stat_skewness <- (2 - p) / sqrt(1 - p)
  stat_kurtosis <- 6 + ((p * p) / (1 - p))
  stat_coef_var <- (1 - p) / (p * p)

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
