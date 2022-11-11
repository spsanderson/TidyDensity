#' Tidy Randomly Generated F Distribution Tibble
#'
#' @family Continuous Distribution
#' @family F Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://www.itl.nist.gov/div898/handbook/eda/section3/eda3665.htm}
#'
#' @details This function uses the underlying `stats::rf()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rf()]
#'
#' @description This function will generate `n` random points from a rf
#' distribution with a user provided, `df1`,`df2`, and `ncp`, and number of random
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
#' @param .df1 Degrees of freedom, Inf is allowed.
#' @param .df2 Degrees of freedom, Inf is allowed.
#' @param .ncp Non-centrality parameter.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_f()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_f <- function(.n = 50, .df1 = 1, .df2 = 1, .ncp = 0, .num_sims = 1) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  df1 <- as.numeric(.df1)
  df2 <- as.numeric(.df2)
  ncp <- as.numeric(.ncp)

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

  if (!is.numeric(df1) | !is.numeric(df2) | !is.numeric(ncp) |
    df1 <= 0 | df2 <= 0 | ncp < 0) {
    rlang::abort(
      "The parameters of '.df1', '.df2', and '.ncp' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc. .ncp must be equal to or greater
            than 0. .df1 and .df2 must be greater than 0."
    )
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  df <- dplyr::tibble(sim_number = as.factor(x)) %>%
    dplyr::group_by(sim_number) %>%
    dplyr::mutate(x = list(1:n)) %>%
    dplyr::mutate(y = list(stats::rf(n = n, df1 = df1, df2 = df2, ncp = ncp))) %>%
    dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
      purrr::set_names("dx", "dy") %>%
      dplyr::as_tibble())) %>%
    dplyr::mutate(p = list(stats::pf(unlist(y), df1 = df1, df2 = df2, ncp = ncp))) %>%
    dplyr::mutate(q = list(stats::qf(unlist(p), df1 = df1, df2 = df2, ncp = ncp))) %>%
    tidyr::unnest(cols = c(x, y, d, p, q)) %>%
    dplyr::ungroup()

  param_grid <- dplyr::tibble(.df1, .df2, .ncp)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "continuous"
  attr(df, ".df1") <- .df1
  attr(df, ".df2") <- .df2
  attr(df, ".ncp") <- .ncp
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, "tibble_type") <- "tidy_f"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "F Distribution",
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
