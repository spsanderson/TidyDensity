#' Tidy Randomly Generated Inverse Gaussian Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Gaussian
#' @family Inverse Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function uses the underlying `actuar::rinvgauss()`. For
#' more information please see [rinvgauss()]
#'
#' @description This function will generate `n` random points from an Inverse Gaussian
#' distribution with a user provided, `.mean`, `.shape`, `.dispersion`The function
#' returns a tibble with the simulation number column the x column which corresponds
#' to the n randomly generated points.
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
#' @param .mean Must be strictly positive.
#' @param .shape Must be strictly positive.
#' @param .dispersion An alternative way to specify the `.shape`.
#' @param .num_sims The number of randomly generated simulations you want.
#' @param .return_tibble A logical value indicating whether to return the result
#' as a tibble. Default is TRUE.
#'
#' @examples
#' tidy_inverse_normal()
#'
#' @return
#' A tibble of randomly generated data.
#'
#' @name tidy_inverse_normal
NULL

#' @export
#' @rdname tidy_inverse_normal

tidy_inverse_normal <- function(.n = 50, .mean = 1, .shape = 1, .dispersion = 1 / .shape,
                                .num_sims = 1, .return_tibble = TRUE) {

  # Tidyeval ----
  n <- as.integer(.n)
  num_sims <- as.integer(.num_sims)
  mu <- as.numeric(.mean)
  shape <- as.numeric(.shape)
  dispers <- as.numeric(.dispersion)
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

  if (!is.numeric(mu) | !is.numeric(shape) | !is.numeric(dispers)) {
    rlang::abort(
      "The parameters of '.mean', '.shape', and '.dispersion' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
    )
  }

  if (mu <= 0 | shape <= 0 | dispers <= 0) {
    rlang::abort(
      "The parameters of '.mean', '.shape', and '.disperson' must be strictly
            positive."
    )
  }

  x <- seq(1, num_sims, 1)

  # ps <- seq(-n, n - 1, 2)
  qs <- seq(0, 1, (1 / (n - 1)))
  ps <- qs

  # Create a data.table with one row per simulation
  df <- data.table::CJ(sim_number = factor(1:num_sims), x = 1:n)

  # Group the data by sim_number and add columns for x and y
  df[, y := actuar::rinvgauss(n = .N, mean = mu, shape = shape, dispersion = dispers)]

  # Compute the density of the y values and add columns for dx and dy
  df[, c("dx", "dy") := density(y, n = n)[c("x", "y")], by = sim_number]

  # Compute the p-values for the y values and add a column for p
  df[, p := actuar::pinvgauss(y, mean = mu, shape = shape, dispersion = dispers)]

  # Compute the q-values for the p-values and add a column for q
  df[, q := actuar::qinvgauss(p, mean = mu, shape = shape, dispersion = dispers)]

  if(.return_tibble){
    df <- dplyr::as_tibble(df)
  } else {
    data.table::setkey(df, NULL)
  }

  # Create a tibble with the parameter grid
  param_grid <- dplyr::tibble(.mean, .shape, .dispersion)

  # Attach descriptive attributes to tibble
  attr(df, "distribution_family_type") <- "continuous"
  attr(df, ".mean") <- .mean
  attr(df, ".shape") <- .shape
  attr(df, ".dispersion") <- .dispersion
  attr(df, ".n") <- .n
  attr(df, ".num_sims") <- .num_sims
  attr(df, ".ret_tbl") <- .return_tibble
  attr(df, "tibble_type") <- "tidy_inverse_gaussian"
  attr(df, "ps") <- ps
  attr(df, "qs") <- qs
  attr(df, "param_grid") <- param_grid
  attr(df, "param_grid_txt") <- paste0(
    "c(",
    paste(param_grid[, names(param_grid)], collapse = ", "),
    ")"
  )
  attr(df, "dist_with_params") <- paste0(
    "Inverse Gaussian",
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
