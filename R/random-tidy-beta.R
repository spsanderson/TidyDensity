#' Tidy Randomly Generated Beta Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Beta
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://statisticsglobe.com/beta-distribution-in-r-dbeta-pbeta-qbeta-rbeta}
#' @seealso \url{https://en.wikipedia.org/wiki/Beta_distribution}
#'
#' @details This function uses the underlying `stats::rbeta()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rbeta()]
#'
#' @description This function will generate `n` random points from a beta
#' distribution with a user provided, `.shape1`, `.shape2`, `.ncp` or `non-centrality parameter`,
#' and number of random simulations to be produced. The function returns a tibble with the
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
#' @param .shape1 A non-negative parameter of the Beta distribution.
#' @param .shape2 A non-negative parameter of the Beta distribution.
#' @param .ncp The `non-centrality parameter` of the Beta distribution.
#' @param .num_sims The number of randomly generated simulations you want.
#' @param .return_tibble A logical value indicating whether to return the result
#' as a tibble. Default is TRUE.
#'
#' @examples
#' tidy_beta()
#'
#' @return
#' A tibble of randomly generated data.
#' @name tidy_beta
NULL

#' @export
#' @rdname tidy_beta

tidy_beta <- function(.n = 50, .shape1 = 1, .shape2 = 1, .ncp = 0, .num_sims = 1,
                      .return_tibble = TRUE) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  shape1 <- as.numeric(.shape1)
  shape2 <- as.numeric(.shape2)
  ncp <- as.numeric(.ncp)
  ret_tbl <- as.logical(.return_tibble)

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

  if (!is.numeric(shape1) | !is.numeric(shape2) | !is.numeric(ncp) |
    shape1 < 0 | shape2 < 0 | ncp < 0) {
    rlang::abort(
      "The parameters of '.shape1', '.shape2', and 'ncp' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc. and must be greater than 0."
    )
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  # Create a data.table with one row per simulation
  df <- data.table::CJ(sim_number = factor(1:num_sims), x = 1:n)

  # Group the data by sim_number and add columns for x and y
  df[, y := stats::rbeta(n = .N, shape1 = shape1, shape2 = shape2, ncp = ncp)]

  # Compute the density of the y values and add columns for dx and dy
  df[, c("dx", "dy") := density(y, n = n)[c("x", "y")], by = sim_number]

  # Compute the p-values for the y values and add a column for p
  df[, p := stats::pbeta(y, shape1 = shape1, shape2 = shape2, ncp = ncp)]

  # Compute the q-values for the p-values and add a column for q
  df[, q := stats::qbeta(p, shape1 = shape1, shape2 = shape2, ncp = ncp)]

  if(.return_tibble){
    df <- dplyr::as_tibble(df)
  } else {
    data.table::setkey(df, NULL)
  }

  param_grid <- dplyr::tibble(.shape1, .shape2, .ncp)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "continuous"
  attr(df, ".shape1") <- .shape1
  attr(df, ".shape2") <- .shape2
  attr(df, ".ncp") <- .ncp
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, ".ret_tbl") <- .return_tibble
  attr(df, "tibble_type") <- "tidy_beta"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Beta",
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
