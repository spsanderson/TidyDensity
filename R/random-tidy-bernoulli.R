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
#'
#' @examples
#' tidy_bernoulli()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_bernoulli <- function(.n = 50, .prob = 0.1, .num_sims = 1) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  pr <- as.numeric(.prob)

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

  x <- seq(1, num_sims, 1) %>% as.integer()

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  df <- dplyr::tibble(sim_number = as.factor(x)) %>%
    dplyr::group_by(sim_number) %>%
    dplyr::mutate(x = list(1:n)) %>%
    dplyr::mutate(y = list(stats::rbinom(n = n, size = 1, prob = pr))) %>%
    dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
      purrr::set_names("dx", "dy") %>%
      dplyr::as_tibble())) %>%
    dplyr::mutate(p = list(stats::pbinom(unlist(y), size = 1, prob = pr))) %>%
    dplyr::mutate(q = list(stats::qbinom(unlist(p), size = 1, prob = pr))) %>%
    tidyr::unnest(cols = c(x, y, d, p, q)) %>%
    dplyr::ungroup()

  param_grid <- dplyr::tibble(.prob)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "discrete"
  attr(df, ".prob") <- .prob
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, "tibble_type") <- "tidy_bernoulli"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
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

  # Return final result as function output
  return(df)
}
