#' Estimate Paralogistic Parameters
#'
#' @family Parameter Estimation
#' @family Paralogistic
#'
#' @details This function will attempt to estimate the paralogistic shape and rate
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated paralogistic data.
#'
#' The method of parameter estimation is:
#' -  MLE
#'
#' @param .x The vector of data to be passed to the function.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' x <- mtcars$mpg
#' output <- util_paralogistic_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' t <- tidy_paralogistic(50, 2.5, 1.4)[["y"]]
#' util_paralogistic_param_estimate(t)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_paralogistic_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  minx <- min(x_term)
  maxx <- max(x_term)
  n <- length(x_term)
  unique_terms <- length(unique(x_term))

  # Checks ----
  if (n < 2 || unique_terms < 2) {
    rlang::abort(
      message = "The data must have at least two (2) unique data points.",
      use_cli_format = TRUE
    )
  }

  # Get initial parameter estimates
  mean_x <- mean(x_term, na.rm = TRUE)
  var_x <- var(x_term, na.rm = TRUE)
  shape_mme <- 2 * mean_x^2 / (var_x - mean_x^2)
  rate_mme <- 2 * mean_x / (var_x - mean_x^2)
  # shape_mmue <- 2 * mean_x^2 / (var_x * (n - 1) / n - mean_x^2) |> abs()
  # rate_mmue <- 2 * mean_x / (var_x * (n - 1) / n - mean_x^2) |> abs()

  # MLE
  neg_log_lik_paralogis <- function(par, data) {
    shape <- par[1]
    rate <- par[2]
    -sum(actuar::dparalogis(data, shape = shape, rate = rate, log = TRUE))
  }

  mle_params <- stats::optim(
    c(shape_mme, rate_mme),
    neg_log_lik_paralogis,
    data = x_term,
    method = "L-BFGS-B",
    lower = c(1e-10, 1e-10)
  )$par

  shape_mle <- mle_params[[1]]
  rate_mle <- mle_params[[2]]

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    # td_mme <- tidy_paralogistic(
    #   .n = n, .shape = round(shape_mme, 3),
    #   .rate = round(rate_mme, 3)
    # )
    td_mle <- tidy_paralogistic(
      .n = n, .shape = round(shape_mle, 3),
      .rate = round(rate_mle, 3)
    )
    # td_mmue <- tidy_paralogistic(
    #   .n = n, .shape = round(shape_mmue, 3),
    #   .rate = round(rate_mmue, 3)
    # )
    combined_tbl <- tidy_combine_distributions(te, td_mle)
  }

  ret <- dplyr::tibble(
    dist_type = "Paralogistic",
    samp_size = n,
    min = minx,
    max = maxx,
    mean = mean_x,
    var = var_x,
    method = "MLE",
    shape = shape_mle,
    rate = rate_mle,
    shape_rate_ratio = c(shape_mle / rate_mle)
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "paralogistic"
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
