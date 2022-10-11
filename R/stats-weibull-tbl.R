#' Distribution Statistics
#'
#' @family Weibull
#' @family Distribution Statistics
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will take in a tibble and returns the statistics
#' of the given type of `tidy_` distribution. It is required that data be
#' passed from a `tidy_` distribution function.
#'
#' @description Returns distribution statistics in a tibble.
#'
#' @param .data The data being passed from a `tidy_` distribution function.
#'
#' @examples
#' library(dplyr)
#'
#' tidy_weibull() %>%
#'   util_weibull_stats_tbl() %>%
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_weibull_stats_tbl <- function(.data) {

  # Immediate check for tidy_ distribution function
  if (!"tibble_type" %in% names(attributes(.data))) {
    rlang::abort(
      message = "You must pass data from the 'tidy_dist' function.",
      use_cli_format = TRUE
    )
  }

  if (attributes(.data)$tibble_type != "tidy_weibull") {
    rlang::abort(
      message = "You must use 'tidy_weibull()'",
      use_cli_format = TRUE
    )
  }

  # Data
  data_tbl <- dplyr::as_tibble(.data)

  atb <- attributes(data_tbl)
  t <- atb$.shape
  q <- atb$.scale

  SqErr <- function(par, Mean, Var) {
    t <- par[[1]]
    q <- par[[2]]
    Mu <- q * gamma(1 + 1 / t)
    SigSq <- q^2 * gamma(1 + 2 / t)
    ParVar <- SigSq - Mu^2
    return((Mu - Mean)^2 + (ParVar - Var)^2)
  }

  A <- nloptr::nloptr(c(t, q), SqErr,
    Mean = mean(data_tbl$y), Var = var(data_tbl$y),
    opts = list(
      algorithm = "NLOPT_LN_NELDERMEAD",
      maxeval = 1e5, ftol = 1e-12
    )
  )

  stat_mean <- mean(stats::rweibull(1e5, A$solution[[1]], scale = A$solution[[2]]))
  stat_median <- stats::median(survival::Surv(data_tbl$y))$quantile[[1]]
  stat_mode <- t * (1 - (1 / q))^(1 / q)
  stat_sd <- sqrt(A$solution[[2]])
  stat_coef_var <- A$solution[[2]]

  # Data Tibble
  ret <- dplyr::tibble(
    tidy_function = atb$tibble_type,
    function_call = atb$dist_with_params,
    distribution = dist_type_extractor(atb$tibble_type),
    distribution_type = atb$distribution_family_type,
    points = atb$.n,
    simulations = atb$.num_sims,
    mean = stat_mean,
    median = stat_median,
    mode = stat_mode,
    range = paste0("0 to Inf"),
    std_dv = stat_sd,
    coeff_var = stat_coef_var,
    computed_std_skew = tidy_skewness_vec(data_tbl$y),
    computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
    ci_lo = ci_lo(data_tbl$y),
    ci_hi = ci_hi(data_tbl$y)
  )

  # Return
  return(ret)
}
