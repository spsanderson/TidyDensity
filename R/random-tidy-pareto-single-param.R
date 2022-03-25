#' Tidy Randomly Generated Pareto Single Parameter Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Pareto
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://openacttexts.github.io/Loss-Data-Analytics/C-SummaryDistributions.html}
#'
#' @details This function uses the underlying `actuar::rpareto1()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [actuar::rpareto1()]
#'
#' @description This function will generate `n` random points from a single parameter
#' pareto distribution with a user provided, `.shape`, `.min`, and number of
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
#' @param .shape Must be positive.
#' @param .min The lower bound of the support of the distribution.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_pareto1()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_pareto1 <- function(.n = 50, .shape = 1, .min = 1, .num_sims = 1) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  shape <- as.numeric(.shape)
  min <- as.numeric(.min)

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

  if (!is.numeric(shape) | !is.numeric(min)) {
    rlang::abort(
      "The parameters of .shape and .min must be of class numeric and greater than 0."
    )
  }

  if (shape <= 0) {
    rlang::abort("The parameter of .size must be greater than 0.")
  }

  if (min <= 0) {
    rlang::abort("The parameter of .min must be greater than 0")
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  df <- dplyr::tibble(sim_number = as.factor(x)) %>%
    dplyr::group_by(sim_number) %>%
    dplyr::mutate(x = list(1:n)) %>%
    dplyr::mutate(y = list(actuar::rpareto1(n = n, shape = shape, min = min))) %>%
    dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
      purrr::set_names("dx", "dy") %>%
      dplyr::as_tibble())) %>%
    dplyr::mutate(p = list(actuar::ppareto1(ps, shape = shape, min = min))) %>%
    dplyr::mutate(q = list(actuar::qpareto1(qs, shape = shape, min = min))) %>%
    tidyr::unnest(cols = c(x, y, d, p, q)) %>%
    dplyr::ungroup()

  param_grid <- dplyr::tibble(.shape, .min)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "continuous"
  attr(df, ".shape") <- .shape
  attr(df, ".min") <- .min
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, "tibble_type") <- "tidy_pareto_single_parameter"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Single Param Pareto",
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
