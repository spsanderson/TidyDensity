#' Tidy Randomly Generated Bernoulli Distribution Tibble
#'
#' @family Discrete Distribution
#' @family Bernoulli
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Bernoulli_distribution}
#'
#' @details This function uses the `rbinom()`, and its underlying
#' `p`, `d`, and `q` functions. The _Bernoulli_ distribution is a special case
#' of the _Binomial_ distribution with `size = 1` hence this is why the `binom`
#' functions are used and set to size = 1.
#'
#' @description This function will generate `n` random points from a Bernoulli
#' distribution with a user provided, `.prob`, and number of random simulations
#' to be produced. The function returns a tibble with the simulation number
#' column the x column which corresponds to the n randomly generated points,
#' the `d_`, `p_` and `q_` data points as well.
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
#' @param .prob The probability of success/failure.
#' @param .num_sims The number of randomly generated simulations you want.
#' @param .return_tibble A logical value indicating whether to return the result
#' as a tibble. Default is TRUE.
#'
#' @examples
#' tidy_bernoulli()
#' @return
#' A tibble of randomly generated data.
#' @name tidy_bernoulli
NULL

#' @export
#' @rdname tidy_bernoulli

tidy_bernoulli <- function(.n = 50, .prob = 0.1, .num_sims = 1, .return_tibble = TRUE) {

  # Arguments
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  pr <- as.numeric(.prob)
  ret_tbl <- as.logical(.return_tibble)

  # Checks ----
  if (!is.integer(n) | n < 0) {
    rlang::abort(
      message = "The parameters '.n' must be of class integer. Please pass a whole
            number like 50 or 100. It must be greater than 0.",
      use_cli_format = TRUE
    )
  }

  if (!is.integer(num_sims) | num_sims < 0) {
    rlang::abort(
      message = "The parameter `.num_sims' must be of class integer. Please pass a
            whole number like 50 or 100. It must be greater than 0.",
      use_cli_format = TRUE
    )
  }

  if (pr < 0 | pr > 1) {
    rlang::abort(
      message = "The '.prob' parameter must have an argument between 0 and 1 inclusive",
      use_cli_format = TRUE
    )
  }

  # Create a data.table with one row per simulation
  df <- data.table::CJ(sim_number = factor(1:num_sims), x = 1:n)

  # Group the data by sim_number and add columns for x and y
  df[, y := stats::rbinom(n = .N, size = 1, prob = pr)]

  # Compute the density of the y values and add columns for dx and dy
  df[, c("dx", "dy") := density(y, n = n)[c("x", "y")], by = sim_number]

  # Compute the p-values for the y values and add a column for p
  df[, p := stats::pbinom(y, size = 1, prob = pr)]

  # Compute the q-values for the p-values and add a column for q
  df[, q := stats::qbinom(p, size = 1, prob = pr)]

  if(.return_tibble){
    df <- dplyr::as_tibble(df)
  } else {
    data.table::setkey(df, NULL)
  }

  param_grid <- dplyr::tibble(.prob)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "discrete"
  attr(df, ".prob") <- .prob
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, ".ret_tbl") <- .return_tibble
  attr(df, "tibble_type") <- "tidy_bernoulli"
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Bernoulli",
    " ",
    paste0(
      "c(",
      paste(param_grid[, names(param_grid)], collapse = ", "),
      ")"
    )
  )

  return(df)
}
