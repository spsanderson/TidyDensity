#' Distribution Statistics
#'
#' @family Pareto
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
#' tidy_pareto() %>%
#'   util_pareto_stats_tbl() %>%
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_pareto_stats_tbl <- function(.data){

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))){
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_pareto"){
        rlang::abort(
            message = "You must use 'tidy_pareto()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)
    xm <- atb$.scale
    alpha <- atb$.shape

    stat_mean   <- ifelse(alpha <= 1, alpha, (alpha * xm)/(alpha - 1))
    stat_mode   <- xm
    stat_coef_var <- ifelse(alpha <= 2, alpha, ((xm^2)*alpha)/((alpha - 1)^2 * (alpha - 2)))
    stat_sd <- sqrt(stat_coef_var)
    stat_skewness <- ifelse(alpha <= 3, "undefined", (2*(1 + alpha))/(alpha - 3) * sqrt((alpha - 2)/alpha))
    stat_kurtosis <- ifelse(alpha <= 4, "undefined", (6*(alpha^3 + alpha^2 - 6*alpha - 2))/(alpha * (alpha - 3) * (alpha - 4)))

    # Data Tibble
    ret <- dplyr::tibble(
        tidy_function = atb$tibble_type,
        function_call = atb$dist_with_params,
        distribution = atb$tibble_type %>%
            stringr::str_remove("tidy_") %>%
            stringr::str_to_title(),
        distribution_type = atb$distribution_family_type,
        points = atb$.n,
        simulations = atb$.num_sims,
        mean = stat_mean,
        mode_lower = stat_mode,
        range = paste0("0 to Inf"),
        std_dv = stat_sd,
        coeff_var = stat_coef_var,
        skewness = stat_skewness,
        kurtosis = stat_kurtosis,
        computed_std_skew = tidy_skewness_vec(data_tbl$y),
        computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
        ci_lo = ci_lo(data_tbl$y),
        ci_hi = ci_hi(data_tbl$y)
    )

    # Return
    return(ret)

}
