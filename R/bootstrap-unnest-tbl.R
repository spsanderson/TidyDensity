#' Unnest Tidy Bootstrap Tibble
#'
#' @family Bootstrap
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function takes as input the output of the `tidy_bootstrap()`
#' function and returns a two column tibble. The columns are `sim_number` and `y`
#'
#' It looks for an attribute that comes from using `tidy_bootstrap()` so it will
#' not work unless the data comes from that function.
#'
#' @description Unnest the data output from `tidy_bootstrap()`.
#'
#' @param .data The data that is passed from the `tidy_bootstrap()` function.
#'
#' @examples
#' tb <- tidy_bootstrap(.x = mtcars$mpg)
#' bootstrap_unnest_tbl(tb)
#'
#' bootstrap_unnest_tbl(tb) |>
#'   tidy_distribution_summary_tbl(sim_number)
#'
#' @return
#' A tibble
#'
#' @export
#'

bootstrap_unnest_tbl <- function(.data) {

  # Checks ----
  atb <- attributes(.data)
  distribution_family_type <- atb$distribution_family_type

  if (!atb$tibble_type == "tidy_bootstrap_nested") {
    rlang::abort(
      message = "You must provide the output from the tidy_bootstrap() function.",
      use_cli_format = TRUE
    )
  }

  # Data ----
  df <- tidyr::unnest(.data, bootstrap_samples) |>
    purrr::set_names("sim_number", "y")

  # Return ----
  attr(df, ".num_sims") <- atb$.num_sims
  attr(df, "distribution_family_type") <- distribution_family_type
  attr(df, "tibble_type") <- "tidy_bootstrap"
  attr(df, "dist_with_params") <- "Empirical"

  return(df)
}
