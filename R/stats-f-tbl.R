#' Distribution Statistics
#'
#' @family F Distribution
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
#' tidy_f() %>%
#'   util_f_stats_tbl()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_f_stats_tbl <- function(.data){

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))){
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_f"){
        rlang::abort(
            message = "You must use 'tidy_f()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)

    stat_mean   <- ifelse(atb$.df2 > 2, (atb$.df2 / (atb$.df2 - 2)), "undefined")
    stat_median <- "Not computed"
    stat_mode   <- ifelse(
        atb$.df1 > 2,
        ((atb$.df2 * (atb$.df1 - 2)) / (atb$.df1 * (atb$.df2 + 2))),
        "undefined"
    )
    stat_range = "0 to Inf"
    stat_sd     <- ifelse(
        atb$.df2 > 4,
        sqrt((2 * (atb$.df2)^2 * (atb$.df1 + atb$.df2 - 2))/
                 (atb$.df1 * (atb$.df2 - 2)^2 * (atb$.df2 - 4))),
        "undefined"
    )
    stat_coef_var <- ifelse(
        atb$.df2 > 4,
        sqrt((2 * (atb$.df1 + atb$.df2 - 2)) / (atb$.df1 * (atb$.df2 - 4))),
        "undefined"
    )
    stat_skewness <- ifelse(
        atb$.df2 > 6,
        ((2 * atb$.df1 + atb$.df2 - 2) * sqrt(8 * (atb$.df2 - 4)))/
            (sqrt(atb$.df1) * (atb$.df2 - 6) * sqrt(atb$.df1 + atb$.df2 - 2)),
        "undefined"
    )
    stat_kurtosis <- "Not computed"

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
        median = stat_median,
        mode = stat_mode,
        std_dv = stat_sd,
        coeff_var = stat_coef_var,
        skewness = stat_skewness,
        kurtosis = stat_kurtosis,
        computed_std_skew = tidy_skewness_vec(data_tbl$y),
        computed_std_kurt = tidy_kurtosis_vec(data_tbl$y)
    )

    # Return
    return(ret)

}
