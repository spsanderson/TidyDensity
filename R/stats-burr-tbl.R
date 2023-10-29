#' Distribution Statistics
#'
#' @family Burr
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
#' tidy_burr() %>%
#'   util_burr_stats_tbl() %>%
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @name util_burr_stats_tbl
NULL

#' @export
#' @rdname util_burr_stats_tbl

util_burr_stats_tbl <- function(.data) {

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))) {
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_burr") {
        rlang::abort(
            message = "You must use 'tidy_burr()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)
    s1 <- atb$.shape1
    s2 <- atb$.shape2
    r  <- atb$.rate
    sc <- 1/r

    stat_mean <- s2 + sc * (s1 / (s1 + 1))
    stat_mode <- ((s2 - 1)/((s1*s2) + 1))^(1/s2)
    stat_median <- sc * actuar::qburr(p = 0.5, shape1 = s1, shape2 = 1)
    stat_skewness <- (4 * sqrt(6) * (s1 + 2)) / (s1 * pi ^ (3/2)*(s1 + 3))
    stat_kurtosis <- 3 * (s1^2 + 6 * s1 + 5) / (s1 * (s1 + 1)^2)
    stat_coef_var <- (-1 * stat_mean^2) + stat_mean

    # Data Tibble
    ret <- dplyr::tibble(
        tidy_function = atb$tibble_type,
        function_call = atb$dist_with_params,
        distribution = dist_type_extractor(atb$tibble_type),
        distribution_type = atb$distribution_family_type,
        points = atb$.n,
        simulations = atb$.num_sims,
        mean = stat_mean,
        mode = stat_mode,
        median = stat_median,
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
