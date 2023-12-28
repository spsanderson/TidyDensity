#' Estimate Geometric Parameters
#'
#' @family Parameter Estimation
#' @family Geometric
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will see if the given vector `.x` is a numeric vector.
#' It will attempt to estimate the prob parameter of a geometric distribution.
#'
#' @description This function will attempt to estimate the geometric prob parameter
#' given some vector of values `.x`. The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated geometric data.
#'
#' @param .x The vector of data to be passed to the function. Must be non-negative
#' integers.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' tg <- tidy_geometric(.prob = .1) |> pull(y)
#' output <- util_geometric_param_estimate(tg)
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

util_geometric_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  n <- length(x_term)
  minx <- min(as.numeric(x_term))
  maxx <- max(as.numeric(x_term))
  m <- mean(as.numeric(x_term))
  s <- var(x_term)
  sum_x <- sum(x_term)

  # Checks ----
  if (!is.vector(x_term, mode = "numeric")) {
    rlang::abort(
      message = "The '.x' term must be a numeric vector.",
      use_cli_format = TRUE
    )
  }

  if (!all(x_term == trunc(x_term)) || any(x_term < 0)) {
    rlang::abort(
      message = "All values of 'x' must be non-negative integers.",
      use_cli_format = TRUE
    )
  }

  if (n < 2) {
    rlang::abort(
      message = "You must supply at least two data points for this function.
            If you only have one then use [EnvStats::egeom()]",
      use_cli_format = TRUE
    )
  }

  # Parameters ----
  # EnvStats
  es_mme_prob <- n / (n + sum_x)
  es_mvue_prob <- (n - 1) / (n + sum_x - 1)

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_geometric(.n = n, .prob = round(es_mme_prob, 3))
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = rep("Geometric", 2),
    samp_size = rep(n, 2),
    min = rep(minx, 2),
    max = rep(maxx, 2),
    mean = rep(m, 2),
    variance = rep(s, 2),
    sum_x = rep(sum_x, 2),
    method = c("EnvStats_MME", "EnvStats_MVUE"),
    shape = c(es_mme_prob, es_mvue_prob)
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "geometric"
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
