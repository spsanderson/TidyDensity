#' Estimate Logistic Parameters
#'
#' @family Parameter Estimation
#' @family Logistic
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the logistic location and scale
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated logistic data.
#'
#' Three different methods of shape parameters are supplied:
#' -  MLE
#' -  MME
#' -  MMUE
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
#' output <- util_logistic_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' t <- rlogis(50, 2.5, 1.4)
#' util_logistic_param_estimate(t)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_logistic_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

  # Tidyeval ----
  x_term <- as.numeric(.x)
  minx <- min(x_term)
  maxx <- max(x_term)
  n <- length(x_term)
  unique_terms <- length(unique(x_term))
  location <- mean(x_term, na.rm = TRUE)
  scale <- (sqrt((n - 1) / n) * sd(x_term) * sqrt(3)) / pi

  # Checks ----
  if (n < 2 || unique_terms < 2) {
    rlang::abort(
      message = "The data must have at least two (2) unique data points.",
      use_cli_format = TRUE
    )
  }

  # Get params ----
  # EnvStats
  es_mme_location <- location
  es_mme_scale <- scale

  es_mmue_location <- location
  es_mmue_scale <- (sd(x_term) * sqrt(3)) / pi

  # MLE
  mle_fx <- function(theta, y) {
    a <- theta[1]
    b <- theta[2]
    c <- (y - 1) / b
    sum(c + log(b) + 2 * log(1 + exp(-c)))
  }

  mle_params <- stats::nlminb(
    start = c(location, scale),
    objective = mle_fx,
    lower = c(-Inf, .Machine$double.eps), y = x_term
  )$par

  names(mle_params) <- c("es_mle_location", "es_mle_scale")

  es_mle_location <- mle_params[[1]]
  es_mle_scale <- mle_params[[2]]

  # Return Tibble ----
  if (.auto_gen_empirical) {
    te <- tidy_empirical(.x = x_term)
    td <- tidy_logistic(
      .n = n, .location = round(es_mme_location, 3),
      .scale = round(es_mme_scale, 3)
    )
    combined_tbl <- tidy_combine_distributions(te, td)
  }

  ret <- dplyr::tibble(
    dist_type = rep("Logistic", 3),
    samp_size = rep(n, 3),
    min = rep(minx, 3),
    max = rep(maxx, 3),
    mean = rep(location, 3),
    basic_scale = rep(scale, 3),
    method = c("EnvStats_MME", "EnvStats_MMUE", "EnvStats_MLE"),
    location = c(es_mme_location, es_mmue_location, es_mle_location),
    scale = c(es_mme_scale, es_mmue_scale, es_mle_scale),
    shape_ratio = c(
      es_mme_location / es_mme_scale, es_mmue_location / es_mmue_scale,
      es_mle_location / es_mle_scale
    )
  )

  # Return ----
  attr(ret, "tibble_type") <- "parameter_estimation"
  attr(ret, "family") <- "logistic"
  attr(ret, "x_term") <- .x
  attr(ret, "n") <- n
  attr(ret, "base_location") <- location
  attr(ret, "base_scale") <- scale

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
