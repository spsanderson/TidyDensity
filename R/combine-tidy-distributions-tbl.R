#' Combine Multiple Tidy Distributions of Different Types
#'
#' @family Multiple Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Allows a user to generate a tibble of different `tidy_` distributions
#'
#' @description This allows a user to specify any `n` number of `tidy_`
#' distributions that can be combined into a single tibble. This is the preferred
#' method for combining multiple distributions of different types, for example
#' a Gaussian distribution and a Beta distribution.
#'
#' This generates a single tibble with an added column of dist_type that will
#' give the distribution family name and its associated parameters.
#'
#' @param ... The `...` is where you can place your different distributions
#'
#' @examples
#'
#' tn <- tidy_normal()
#' tb <- tidy_beta()
#' tc <- tidy_cauchy()
#'
#' tidy_combine_distributions(tn, tb, tc)
#'
#' ## OR
#'
#' tidy_combine_distributions(
#'   tidy_normal(),
#'   tidy_beta(),
#'   tidy_cauchy(),
#'   tidy_logistic()
#' )
#'
#' @return
#' A tibble
#'
#' @export
#'

tidy_combine_distributions <- function(...) {

  # Add distributions to a list
  dist_list <- list(...)

  dist_list <- purrr::compact(dist_list)

  # Checks ----
  if (length(dist_list) < 2) {
    rlang::abort(
      message = "You must add at least two distributions to the function",
      use_cli_format = TRUE
    )
  }

  # Get the distribution type
  dist_final_tbl <- purrr::map(
    .x = dist_list,
    .f = ~ .x |>
      dplyr::mutate(dist_type = attributes(.x)[["dist_with_params"]]) |>
      dplyr::mutate(dist_type = as.factor(dist_type))
  ) |>
    purrr::map_dfr(dplyr::as_tibble)

  attr(dist_final_tbl, "tibble_type") <- "tidy_multi_dist_combine"

  # Return ---
  return(dist_final_tbl)
}
