#' Tidy Randomly Generated Gaussian Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Gaussian
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function uses the underlying `stats::rnorm()`, `stats::pnorm()`,
#' and `stats::qnorm()` functions to generate data from the given parameters. For
#' more information please see [stats::rnorm()]
#'
#' @description This function will generate `n` random points from a Gaussian
#' distribution with a user provided, `.mean`, `.sd` - standard deviation and number of
#' random simulations to be produced. The function returns a tibble with the
#' simulation number column the x column which corresponds to the n randomly
#' generated points, the `dnorm`, `pnorm` and `qnorm` data points as well.
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
#' @param .mean The mean of the randomly generated data.
#' @param .sd The standard deviation of the randomly generated data.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_normal()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_normal <- function(.n = 50, .mean = 0, .sd = 1, .num_sims = 1) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  mu <- as.numeric(.mean)
  std <- as.numeric(.sd)

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

  if (!is.numeric(mu)) {
    rlang::abort(
      "The parameters of '.mean' and '.sd' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
    )
  }

  if (!is.numeric(std)) {
    rlang::abort(
      "The parameters of '.mean' and '.sd' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
    )
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  df <- dplyr::tibble(sim_number = as.factor(x)) %>%
    dplyr::group_by(sim_number) %>%
    dplyr::mutate(x = list(1:n)) %>%
    dplyr::mutate(y = list(stats::rnorm(n, mu, std))) %>%
    dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
      purrr::set_names("dx", "dy") %>%
      dplyr::as_tibble())) %>%
    dplyr::mutate(p = list(stats::pnorm(unlist(y), mu, std))) %>%
    dplyr::mutate(q = list(stats::qnorm(unlist(p), mu, std))) %>%
    # dplyr::mutate(p = list(stats::pnorm(ps, mu, std))) %>%
    # dplyr::mutate(q = list(stats::qnorm(tidy_scale_zero_one_vec(unlist(y)), mu, std))) %>%
    tidyr::unnest(cols = c(x, y, d, p, q)) %>%
    dplyr::ungroup()

  param_grid <- dplyr::tibble(.mean, .sd)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "continuous"
  attr(df, ".mean") <- .mean
  attr(df, ".sd") <- .sd
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, "tibble_type") <- "tidy_gaussian"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Gaussian",
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
