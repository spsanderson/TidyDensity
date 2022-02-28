#' Tidy Distribution Summary Statistics Tibble
#'
#' @family Summary Statistics
#' @family Table Data
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function takes in a `tidy_` distribution table and
#' will return a tibble of the following information:
#' -  `sim_number`
#' -  `mean_val`
#' -  `median_val`
#' -  `std_val`
#' -  `min_val`
#' -  `max_val`
#' -  `skewness`
#' -  `kurtosis`
#' -  `range`
#' -  `iqr`
#' -  `variance`
#'
#' The kurtosis and skewness come from the package `healthyR.ai`
#'
#' @description This function returns a summary statistics tibble. It will use the
#' y column from the `tidy_` distribution function.
#'
#' @param .data The data that is going to be passed from a a `tidy_` distribution
#' function.
#' @param ... This is the grouping variable that gets passed to [dplyr::group_by()]
#' and [dplyr::select()].
#'
#' @examples
#' library(dplyr)
#'
#' tn <- tidy_normal(.num_sims = 5)
#' tb <- tidy_beta(.num_sims = 5)
#'
#' tidy_distribution_summary_tbl(tn)
#' tidy_distribution_summary_tbl(tn, sim_number)
#'
#' data_tbl <- tidy_combine_distributions(tn, tb)
#'
#' tidy_distribution_summary_tbl(data_tbl)
#' tidy_distribution_summary_tbl(data_tbl, dist_type)
#'
#' @return
#' A summary stats tibble
#'
#' @export
#'

tidy_distribution_summary_tbl <- function(.data, ...) {

  # Get the data attributes
  atb <- attributes(.data)

  if (!"tibble_type" %in% names(atb)) {
    rlang::abort("The data passed must come from a `tidy_` distribution function.")
  }

  data_tbl <- dplyr::as_tibble(.data)

  summary_tbl <- data_tbl %>%
    dplyr::group_by(...) %>%
    dplyr::select(..., y) %>%
    dplyr::summarise(
      mean_val = mean(y, na.rm = TRUE),
      median_val = stats::median(y, na.rm = TRUE),
      std_val = sd(y, na.rm = TRUE),
      min_val = min(y),
      max_val = max(y),
      skewness = tidy_skewness_vec(y),
      kurtosis = tidy_kurtosis_vec(y),
      range = tidy_range_statistic(y),
      iqr = stats::IQR(y),
      variance = stats::var(y)
    ) %>%
    dplyr::ungroup()

  return(summary_tbl)
}
