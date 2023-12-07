#' Tidy Randomly Generated Binomial Distribution Tibble
#'
#' @family Discrete Distribution
#' @family Binomial
#' @family Zero Truncated Negative Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://openacttexts.github.io/Loss-Data-Analytics/ChapSummaryDistributions.html}
#'
#' @details This function uses the underlying `actuar::rztnbinom()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [actuar::rztnbinom()]
#'
#' @description This function will generate `n` random points from a zero truncated binomial
#' distribution with a user provided, `.size`, `.prob`, and number of
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
#' @param .size Number of trials, zero or more.
#' @param .prob Probability of success on each trial 0 <= prob <= 1.
#' @param .num_sims The number of randomly generated simulations you want.
#' @param .return_tibble A logical value indicating whether to return the result
#' as a tibble. Default is TRUE.
#'
#' @examples
#' tidy_zero_truncated_negative_binomial()
#'
#' @return
#' A tibble of randomly generated data.
#'
#' @name tidy_zero_truncated_negative_binomial
NULL

#' @export
#' @rdname tidy_zero_truncated_negative_binomial

tidy_zero_truncated_negative_binomial <- function(.n = 50, .size = 0, .prob = 1,
                                                  .num_sims = 1, .return_tibble = TRUE) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  size <- as.numeric(.size)
  prob <- as.numeric(.prob)
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

  if (!is.numeric(size) | !is.numeric(prob)) {
    rlang::abort(
      "The parameters of .size and .prob must be of class numeric and greater than 0."
    )
  }

  if (size < 0) {
    rlang::abort("The parameter of .size must be greater than or equal to 0.")
  }

  if (prob > 1 | prob < 0) {
    rlang::abort("The parameter of .prob must be 0 <= .prob <= 1")
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  # Create a data.table with one row per simulation
  df <- data.table::CJ(sim_number = factor(1:num_sims), x = 1:n)

  # Group the data by sim_number and add columns for x and y
  df[, y := actuar::rztnbinom(n = n, size = size, prob = prob)]

  # Compute the density of the y values and add columns for dx and dy
  df[, c("dx", "dy") := density(y, n = n)[c("x", "y")], by = sim_number]

  # Compute the p-values for the y values and add a column for p
  df[, p := actuar::pztnbinom(y, size = size, prob = prob)]

  # Compute the q-values for the p-values and add a column for q
  df[, q := actuar::qztnbinom(p, size = size, prob = prob)]

  if(.return_tibble){
    df <- dplyr::as_tibble(df)
  } else {
    data.table::setkey(df, NULL)
  }

  # Create a tibble with the parameters used
  param_grid <- dplyr::tibble(.size, .prob)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "discrete"
  attr(df, ".size") <- .size
  attr(df, ".prob") <- .prob
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, ".ret_tbl") <- .return_tibble
  attr(df, "tibble_type") <- "tidy_zero_truncated_negative_binomial"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Zero Truncated Negative Binomial",
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

