#' Tidy Randomly Generated Binomial Distribution Tibble
#'
#' @family Discrete Distribution
#' @family Binomial
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://www.itl.nist.gov/div898/handbook/eda/section3/eda366i.htm}
#'
#' @details This function uses the underlying `stats::rbinom()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rbinom()]
#'
#' @description This function will generate `n` random points from a binomial
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
#' @param .prob Probability of success on each trial.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_binomial()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_binomial <- function(.n = 50, .size = 0, .prob = 1, .num_sims = 1) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  size <- as.numeric(.size)
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

  df <- dplyr::tibble(sim_number = as.factor(x)) %>%
    dplyr::group_by(sim_number) %>%
    dplyr::mutate(x = list(1:n)) %>%
    dplyr::mutate(y = list(stats::rbinom(n = n, size = size, prob = prob))) %>%
    dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
      purrr::set_names("dx", "dy") %>%
      dplyr::as_tibble())) %>%
    dplyr::mutate(p = list(stats::pbinom(ps, size = size, prob = prob))) %>%
    dplyr::mutate(q = list(stats::qbinom(tidy_scale_zero_one_vec(unlist(y)), size = size, prob = prob))) %>%
    tidyr::unnest(cols = c(x, y, d, p, q)) %>%
    dplyr::ungroup()

  param_grid <- dplyr::tibble(.size, .prob)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "discrete"
  attr(df, ".size") <- .size
  attr(df, ".prob") <- .prob
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, "tibble_type") <- "tidy_binomial"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Binomial",
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
