#' Estimate Gamma Parameters
#'
#' @family Parameter Estimation
#' @family Gamma
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will see if the given vector `.x` is a numeric vector.
#'
#' @description This function will attempt to estimate the gamma shape and scale
#' parameters given some vector of values. The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated gamma data.
#'
#' @param .x The vector of data to be passed to the function. Must be numeric.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' tg <- tidy_gamma(.shape = 1, .scale = .3) |> pull(y)
#' output <- util_gamma_param_estimate(tg)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_gamma_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)
  minx <- min(as.numeric(x_term))
  maxx <- max(as.numeric(x_term))
  m <- mean(as.numeric(x_term))
  s <- sqrt((n - 1) / n) * stats::sd(x_term)

  # Checks ----
  if (!is.numeric(x_term)) {
    rlang::abort(
      message = "The '.x' term must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  if (!is.vector(x_term)) {
    rlang::abort(
      message = "The '.x' term must be a numeric vecotr.",
      use_cli_format = TRUE
    )
  }

  if (n < 2 || any(x_term < 0) || length(unique(x_term)) < 2) {
    rlang::abort(
      message = "The numeric vector '.x' must contain at least two unique values
            greater than 0",
      use_cli_format = TRUE
    )
  }

  # Parameters ----
  # NIST
  nist_shape <- (m / s)^2
  nist_scale <- (s^2) / m

  # EnvStats
  es_mmu_shape <- (m / (sqrt(n / (n - 1)) * s))^2
  es_mmu_scale <- m / nist_shape

  es_bcmle_shape <- ((n - 3) / n) * nist_shape + (2 / (3 * n))
  es_bcmle_scale <- m / nist_shape

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_gamma(.n = n, .shape = round(nist_shape, 3), .scale = round(nist_scale, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = rep("Gamma", 3),
    samp_size = rep(n, 3),
    min = rep(minx, 3),
    max = rep(maxx, 3),
    mean = rep(m, 3),
    variance = rep(s, 3),
    method = c("NIST_MME", "EnvStats_MMUE", "EnvStats_BCMLE"),
    shape = c(nist_shape, es_mmu_shape, es_bcmle_shape),
    scale = c(nist_scale, es_mmu_scale, es_bcmle_scale),
    shape_ratio = c(
      nist_shape / nist_scale, es_mmu_shape / es_mmu_scale,
      es_bcmle_shape / es_bcmle_scale
    )
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "gamma"
  attr(ret, "x_term") <- .x
  attr(ret, "n") <- n

  if (.auto_gen_empirical) {
    output <- list(
      combined_data_tbl = combined_tbl,
      parameter_tbl     = ret
    )
  } else {
    output <- list(
      parameter_tbl = ret
    )
  }

  return(output)
}
