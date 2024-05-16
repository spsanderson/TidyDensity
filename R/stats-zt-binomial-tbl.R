#' Distribution Statistics for Zero Truncated Binomial Distribution
#'
#' @family Binomial
#' @family Distribution Statistics
#'
#' @details This function will take in a tibble and returns the statistics
#' of the given type of `tidy_` distribution. It is required that data be
#' passed from a `tidy_` distribution function.
#'
#' @description Returns distribution statistics in a tibble for Zero Truncated Binomial distribution.
#'
#' @param .data The data being passed from a `tidy_` distribution function.
#'
#' @examples
#' library(dplyr)
#'
#' set.seed(123)
#' tidy_zero_truncated_binomial(.size = 10, .prob = 0.1) |>
#'   util_zero_truncated_binomial_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_zero_truncated_binomial_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_zero_truncated_binomial") {
    rlang::abort(
      message = "You must use 'tidy_zero_truncated_binomial()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)
  x_term <- data_tbl[["y"]]

  atb <- attributes(data_tbl)
  n <- atb$.size
  p <- atb$.prob

  # Calculate the statistics for Zero Truncated Binomial distribution
  stat_mean <- mean(x_term)
  stat_var <- actuar::var(x_term, na.rm = TRUE)  # Variance of ZT Binomial
  stat_sd <- sqrt(stat_var)
  stat_mode <- floor((n + 1) * p)  # Approximation of mode for ZT Binomial
  stat_coef_var <- stat_sd / stat_mean

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
    range = paste0("1 to ", max(x_term)),  # Zero-truncated, so starts from 1
    std_dv = stat_sd,
    coeff_var = stat_coef_var,
    computed_std_skew = tidy_skewness_vec(x_term),
    computed_std_kurt = tidy_kurtosis_vec(x_term),
    ci_lo = ci_lo(x_term),
    ci_hi = ci_hi(x_term)
  )

  # Return
  return(ret)
}
