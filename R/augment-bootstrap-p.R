#' Augment Bootstrap P
#'
#' @family Augment Function
#' @family Bootstrap
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector and will return the ecdf probability.
#'
#' @details
#' Takes a numeric vector and will return the ecdf probability of that vector.
#' This function is intended to be used on its own in order to add columns to a
#' tibble.
#'
#' @param .data The data being passed that will be augmented by the function.
#' @param .value This is passed [rlang::enquo()] to capture the vectors you want
#' to augment.
#' @param .names The default is "auto"
#'
#' @examples
#' x <- mtcars$mpg
#' tidy_bootstrap(x) |>
#'   bootstrap_unnest_tbl() |>
#'   bootstrap_p_augment(y)
#'
#' @return
#' A augmented tibble
#'
#' @export
#'

bootstrap_p_augment <- function(.data, .value, .names = "auto") {
  column_expr <- rlang::enquo(.value)

  if (rlang::quo_is_missing(column_expr)) {
    rlang::abort(
      message = "bootstrap_p_vec(.value) is missing",
      use_cli_format = TRUE
    )
  }

  col_nms <- names(tidyselect::eval_select(rlang::enquo(.value), .data))

  make_call <- function(col) {
    rlang::call2(
      "bootstrap_p_vec",
      .x = rlang::sym(col),
      .ns = "TidyDensity"
    )
  }

  grid <- expand.grid(
    col = col_nms,
    stringsAsFactors = FALSE
  )

  calls <- purrr::pmap(.l = list(grid$col), make_call)

  if (any(.names == "auto")) {
    newname <- "p"
  } else {
    newname <- as.list(.names)
  }

  calls <- purrr::set_names(calls, newname)

  ret <- dplyr::as_tibble(dplyr::mutate(.data, !!!calls))

  return(ret)
}
