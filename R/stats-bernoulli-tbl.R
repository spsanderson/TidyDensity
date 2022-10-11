#' Distribution Statistics
#'
#' @family Bernoulli
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
#' tidy_bernoulli() %>%
#'   util_bernoulli_stats_tbl() %>%
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_bernoulli_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_bernoulli") {
    rlang::abort(
      message = "You must use 'tidy_bernoulli()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  p <- atb$.prob
  q <- 1 - p


  stat_mean <- p
  stat_mode <- if (p < .5) {
    "0"
  } else if (p == .5) {
    "[0,1]"
  } else {
    "1"
  }
  stat_median <- stat_mode
  stat_skewness <- (q - p) / (sqrt(p * q))
  stat_kurtosis <- (1 - 6 * p * q) / (p * q)
  stat_coef_var <- p * q
  stat_mad <- 0.5
  stat_entropy <- (-q * log(q)) - (p * log(p))
  stat_fisher_information <- 1 / (stat_coef_var)

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
    coeff_var = stat_coef_var,
    skewness = stat_skewness,
    kurtosis = stat_kurtosis,
    mad = stat_mad,
    entropy = stat_entropy,
    fisher_information = stat_fisher_information,
    computed_std_skew = tidy_skewness_vec(data_tbl$y),
    computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
    ci_lo = ci_lo(data_tbl$y),
    ci_hi = ci_hi(data_tbl$y)
  )

  # Return
  return(ret)
}
