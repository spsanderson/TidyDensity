#' Tidy Random Walk
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Monte Carlo simulations were first formally designed in the 1940’s
#' while developing nuclear weapons, and since have been heavily used in various
#' fields to use randomness solve problems that are potentially deterministic in
#' nature. In finance, Monte Carlo simulations can be a useful tool to give a
#' sense of how assets with certain characteristics might behave in the future.
#' While there are more complex and sophisticated financial forecasting methods
#' such as ARIMA (Auto-Regressive Integrated Moving Average) and GARCH
#' (Generalised Auto-Regressive Conditional Heteroskedasticity) which attempt to
#' model not only the randomness but underlying macro factors such as seasonality
#' and volatility clustering, Monte Carlo random walks work surprisingly well in
#' illustrating market volatility as long as the results are not taken too
#' seriously.
#'
#' @description Takes in the data from a `tidy_` distribution function and applies
#' a random walk calculation of either `cum_prod` or `cum_sum` to `y`.
#'
#' @param .data The data that is being passed from a `tidy_` distribution
#' function.
#' @param .initial_value The default is 0, this can be set to whatever you want.
#' @param .sample This is a boolean value TRUE/FALSE. The default is FALSE. If
#' set to TRUE then the `y` value from the `tidy_` distribution function is
#' sampled.
#' @param .replace This is a boolean value TRUE/FALSE. The default is FALSE. If
#' set to TRUE AND `.sample` is set to TRUE then the replace parameter of the
#' sample function will be set to TRUE.
#' @param .value_type This can take one of three different values for now. These
#' are the following:
#' -  "cum_prod" - This will take the cumprod of y
#' -  "cum_sum" - This will take the cumsum of y
#'
#' @examples
#' tidy_normal(.sd = .1, .num_sims = 25) %>%
#'   tidy_random_walk()
#'
#' @return
#' An ungrouped tibble.
#'
#' @export
#'

tidy_random_walk <- function(.data, .initial_value = 0, .sample = FALSE,
                             .replace = FALSE, .value_type = "cum_prod") {

  # Tidyeval ----
  initial_value <- as.numeric(.initial_value)
  samp <- as.logical(.sample)
  rlace <- as.logical(.replace)
  value_type <- as.character(.value_type)

  # Get data attributes ----
  atb <- attributes(.data)

  # Checks ----
  if (!"tibble_type" %in% names(atb)) {
    rlang::abort("Function expects to take in data from a 'tidy_' distribution
                     function.")
  }

  if (initial_value < 0) {
    rlang::abort("The .intial_value must be greater than or equal to zero.")
  }

  if (!value_type %in% c("cum_prod", "cum_sum")) {
    rlang::abort("You chose an unsupported .value_type. Please chose from:
                     'cum_prod', 'cum_sum'.")
  }

  # Data ----
  df <- dplyr::as_tibble(.data)

  # Manipulation
  if (value_type == "cum_prod" & samp == FALSE) {
    ifelse(initial_value == 0, iv <- 1, iv <- initial_value)

    dfw <- df %>%
      dplyr::group_by(sim_number) %>%
      dplyr::mutate(random_walk_value = iv * cumprod(1 + y))

    if (initial_value == 0) {
      dfw <- dfw %>%
        dplyr::mutate(random_walk_value = random_walk_value - 1)
    }

    dfw <- dfw %>% dplyr::ungroup()
  }

  if (value_type == "cum_prod" & samp == TRUE) {
    ifelse(initial_value == 0, iv <- 1, iv <- initial_value)

    dfw <- df %>%
      dplyr::group_by(sim_number) %>%
      dplyr::mutate(random_walk_value = iv * cumprod(1 + sample(y, replace = rlace)))

    if (initial_value == 0) {
      dfw <- dfw %>%
        dplyr::mutate(random_walk_value = random_walk_value - 1)
    }

    dfw <- dfw %>% dplyr::ungroup()
  }

  if (value_type == "cum_sum" & samp == FALSE) {
    dfw <- df %>%
      dplyr::group_by(sim_number) %>%
      dplyr::mutate(random_walk_value = initial_value + cumsum(y)) %>%
      dplyr::ungroup()
  }

  if (value_type == "cum_sum" & samp == TRUE) {
    dfw <- df %>%
      dplyr::group_by(sim_number) %>%
      dplyr::mutate(random_walk_value = initial_value + cumsum(sample(y, replace = rlace))) %>%
      dplyr::ungroup()
  }

  # Attributes ----
  attr(dfw, ".initial_value") <- .initial_value
  attr(dfw, ".sample") <- .sample
  attr(dfw, ".replace") <- .replace
  attr(dfw, ".value_type") <- .value_type
  attr(dfw, "tibble_type") <- "tidy_random_walk"
  attr(dfw, "dist_type") <- atb$tibble_type
  attr(dfw, "all") <- atb

  # Return ----
  return(dfw)
}
