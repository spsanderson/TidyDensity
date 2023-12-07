#' Tidy Randomly Generated Lognormal Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Lognormal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://www.itl.nist.gov/div898/handbook/eda/section3/eda3669.htm}
#'
#' @details This function uses the underlying `stats::rlnorm()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rlnorm()]
#'
#' @description This function will generate `n` random points from a lognormal
#' distribution with a user provided, `.meanlog`, `.sdlog`, and number of
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
#' @param .meanlog Mean of the distribution on the log scale with default 0
#' @param .sdlog Standard deviation of the distribution on the log scale with default 1
#' @param .num_sims The number of randomly generated simulations you want.
#' @param .return_tibble A logical value indicating whether to return the result
#' as a tibble. Default is TRUE.
#'
#' @examples
#' tidy_lognormal()
#'
#' @return
#' A tibble of randomly generated data.
#'
#' @name tidy_lognormal
NULL

#' @export
#' @rdname tidy_lognormal

tidy_lognormal <- function(.n = 50, .meanlog = 0, .sdlog = 1, .num_sims = 1,
                           .return_tibble = TRUE) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  meanlog <- as.numeric(.meanlog)
  sdlog <- as.numeric(.sdlog)
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

  if (!is.numeric(meanlog) | !is.numeric(sdlog)) {
    rlang::abort(
      "The parameter of rate must be of class numeric and greater than 0."
    )
  }

  if (sdlog < 0) {
    rlang::abort("The parameter of .sdlog must be greater than or equal to 0.")
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  # Create a data.table with one row per simulation
  df <- data.table::CJ(sim_number = factor(1:num_sims), x = 1:n)

  # Group the data by sim_number and add columns for x and y
  df[, y := stats::rlnorm(n = .N, meanlog = meanlog, sdlog = sdlog)]

  # Compute the density of the y values and add columns for dx and dy
  df[, c("dx", "dy") := density(y, n = n)[c("x", "y")], by = sim_number]

  # Compute the p-values for the y values and add a column for p
  df[, p := stats::plnorm(y, meanlog = meanlog, sdlog = sdlog)]

  # Compute the q-values for the p-values and add a column for q
  df[, q := stats::qlnorm(p, meanlog = meanlog, sdlog = sdlog)]

  if(.return_tibble){
    df <- dplyr::as_tibble(df)
  } else {
    data.table::setkey(df, NULL)
  }

  # Create a tibble with the parameter grid
  param_grid <- dplyr::tibble(.meanlog, .sdlog)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "continuous"
  attr(df, ".meanlog") <- .meanlog
  attr(df, ".sdlog") <- .sdlog
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, ".ret_tbl") <- .return_tibble
  attr(df, "tibble_type") <- "tidy_lognormal"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Lognormal",
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
