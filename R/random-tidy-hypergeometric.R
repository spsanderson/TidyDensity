#' Tidy Randomly Generated Hypergeometric Distribution Tibble
#'
#' @family Discrete Distribution
#' @family Hypergeometric
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Hypergeometric_distribution}
#'
#' @details This function uses the underlying `stats::rhyper()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rhyper()]
#'
#' @description This function will generate `n` random points from a hypergeometric
#' distribution with a user provided, `m`,`nn`, and `k`, and number of random
#' simulations to be produced. The function returns a tibble with the
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
#' @param .m The number of white balls in the urn
#' @param .nn The number of black balls in the urn
#' @param .k The number of balls drawn fro the urn.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_hypergeometric()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_hypergeometric <- function(.n = 50, .m = 0, .nn = 0, .k = 0, .num_sims = 1) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  m <- as.numeric(.m)
  nn <- as.numeric(.nn)
  k <- as.numeric(.k)

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

  if (!is.numeric(k) | !is.numeric(nn) | !is.numeric(m) |
    m < 0 | nn < 0 | k < 0) {
    rlang::abort(
      "The parameters of '.m', '.nn', and '.k' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc. and must be greater than or
            equal to 0."
    )
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  df <- dplyr::tibble(sim_number = as.factor(x)) %>%
    dplyr::group_by(sim_number) %>%
    dplyr::mutate(x = list(1:n)) %>%
    dplyr::mutate(y = list(stats::rhyper(nn = n, m = m, n = nn, k = k))) %>%
    dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
      purrr::set_names("dx", "dy") %>%
      dplyr::as_tibble())) %>%
    dplyr::mutate(p = list(stats::phyper(ps, m = m, n = nn, k = k))) %>%
    #dplyr::mutate(p = list(stats::phyper(unlist(x), m = m, n = nn, k = k))) %>%
    dplyr::mutate(q = list(stats::qhyper(tidy_scale_zero_one_vec(unlist(y)), m = m, n = nn, k = k))) %>%
    tidyr::unnest(cols = c(x, y, d, p, q)) %>%
    dplyr::ungroup()

  param_grid <- dplyr::tibble(.m, .nn, .k)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "discrete"
  attr(df, ".m") <- .m
  attr(df, ".nn") <- .nn
  attr(df, ".k") <- .k
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, "tibble_type") <- "tidy_hypergeometric"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Hypergeometric",
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
