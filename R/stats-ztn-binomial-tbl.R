#' Distribution Statistics for Zero-Truncated Negative Binomial
#'
#' @family Binomial
#' @family Negative Binomial
#' @family Distribution Statistics
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function computes statistics for a zero-truncated negative
#' binomial distribution.
#'
#' @description Computes distribution statistics for a zero-truncated negative
#' binomial distribution.
#'
#' @param .data The data from a zero-truncated negative binomial distribution.
#'
#' @examples
#' library(dplyr)
#'
#' tidy_zero_truncated_negative_binomial(.size = 1, .prob = 0.1) |>
#'  util_zero_truncated_negative_binomial_stats_tbl() |>
#'  glimpse()
#'
#'
#' @return A tibble with distribution statistics.
#'
#' @name util_zero_truncated_negative_binomial_stats_tbl
NULL

#' @export
#' @rdname util_zero_truncated_negative_binomial_stats_tbl

util_zero_truncated_negative_binomial_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_zero_truncated_negative_binomial") {
    rlang::abort(
      message = "You must use 'tidy_zero_truncated_negative_binomial()'",
      use_cli_format = TRUE
    )
  }

  # Extract parameters from data
  data_tbl <- dplyr::as_tibble(.data)
  atb <- attributes(data_tbl)
  r <- atb$.size
  p <- atb$.prob

  # Compute statistics
  mean_val <- (p * r) / (1 - p)
  mode_val <- ifelse(r > 1, floor((p * (r - 1)) / (1 - p)), 0)
  var_val <- (p * r) / ((1 - p)^2)
  sd_val <- sqrt(var_val)
  skewness_val <- (1 + p) / sqrt(p * r)
  kurtosis_val <- 6 / r + ((1 - p)^2) / (p * r)

  # Create tibble of distribution statistics
  ret <- dplyr::tibble(
    tidy_function = atb$tibble_type,
    function_call = atb$dist_with_params,
    distribution = dist_type_extractor(atb$tibble_type),
    distribution_type = atb$distribution_family_type,
    points = atb$.n,
    simulations = atb$.num_sims,
    mean = mean_val,
    mode_lower = mode_val,
    range = "1 to Inf",
    std_dv = sd_val,
    coeff_var = var_val / mean_val,
    skewness = skewness_val,
    kurtosis = kurtosis_val,
    computed_std_skew = tidy_skewness_vec(data_tbl$y),
    computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
    ci_lo = ci_lo(data_tbl$y),
    ci_hi = ci_hi(data_tbl$y)
  )

  # Return the tibble with distribution statistics
  return(ret)
}
