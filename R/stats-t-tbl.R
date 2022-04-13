#' Distribution Statistics
#'
#' @family T Distribution
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
#' tidy_cauchy() %>%
#'   util_cauchy_stats_tbl()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_t_stats_tbl <- function(.data){

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))){
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_t"){
        rlang::abort(
            message = "You must use 'tidy_t()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)

    stat_mean   <- 0
    stat_median <- 0
    stat_mode   <- 0
    stat_sd     <- ifelse(atb$.df > 2, sqrt( (atb$.df / (atb$.df - 1)) ), "undefined")
    stat_coef_var <- "undefined"
    stat_skewness <- 0
    stat_kurtosis <- ifelse(atb$.df > 4, (3*(atb$.df - 2) / (atb$.df - 4)), "undefined")

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
