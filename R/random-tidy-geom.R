#' Tidy Randomly Generated Geometric Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Geometric
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Geometric_distribution}
#'
#' @details This function uses the underlying `stats::rgeom()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rgeom()]
#'
#' @description This function will generate `n` random points from a geometric
#' distribution with a user provided, `.prob`, and number of
#' random simulations to be produced. The function returns a tibble with the
#' simulation number column the x column which corresponds to the n randomly
#' generated points, the `d_`, `p_` and `q_` data points as well.
#'
#' The data is returned un-grouped.
#'
#' The columns that are output are:
#'
#' -  `sim_number` The current simulation number.
#' -  `x` The current value of `n` for the current simulation.
#' -  `y` The randomly generated data point.
#' -  `dx` The `x` value from the [stats::density()] function.
#' -  `dy` The `y` value from the [stats::density()] function.
#' -  `p` The values from the resulting p_ function of the distribution family.
#' -  `q` The values from the resulting q_ function of the distribution family.
#'
#' @param .n The number of randomly generated points you want.
#' @param .prob A probability of success in each trial 0 < prob <= 1.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_geometric()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_geometric <- function(.n = 50, .prob = 1, .num_sims = 1) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  prob <- as.numeric(.prob)

  # Checks ----
  if (!is.integer(n) | n < 0) {
    rlang::abort(
      "The parameters '.n' must be of class integer. Please pass a whole
            number like 50 or 100. It must be greater than 0."
    )
  }

  if (!is.integer(num_sims) | num_sims < 0) {
    rlang::abort(
      "The parameter `.num_sims' must be of class integer. Please pass a
            whole number like 50 or 100. It must be greater than 0."
    )
  }

  if (!is.numeric(prob) | prob < 0 | prob > 1) {
    rlang::abort(
      "The parameter of rate must be of class numeric and 0 < .prob <= 1 must be
            satisfied."
    )
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  df <- dplyr::tibble(sim_number = as.factor(x)) %>%
    dplyr::group_by(sim_number) %>%
    dplyr::mutate(x = list(1:n)) %>%
    dplyr::mutate(y = list(stats::rgeom(n = n, prob = prob))) %>%
    dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
      purrr::set_names("dx", "dy") %>%
      dplyr::as_tibble())) %>%
    dplyr::mutate(p = list(stats::pgeom(unlist(y), prob = prob))) %>%
    dplyr::mutate(q = list(stats::qgeom(unlist(p), prob = prob))) %>%
    tidyr::unnest(cols = c(x, y, d, p, q)) %>%
    dplyr::ungroup()

  param_grid <- dplyr::tibble(.prob)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "discrete"
  attr(df, ".prob") <- .prob
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, "tibble_type") <- "tidy_geometric"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Geometric",
    " ",
    paste0(
      "c(",
      paste(param_grid[, names(param_grid)], collapse = ", "),
      ")"
    )
  )

  # Return final result as function output
  return(df)
}
