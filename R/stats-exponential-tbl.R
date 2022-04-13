#' Distribution Statistics
#'
#' @family Exponential
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
#' tidy_exponential() %>%
#'   util_exponential_stats_tbl()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_exponential_stats_tbl <- function(.data){

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))){
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_exponential"){
        rlang::abort(
            message = "You must use 'tidy_exponential()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)

    stat_mean   <- atb$.rate
    stat_median <- atb$.rate * log(2)
    stat_mode   <- atb$.rate
    stat_sd     <- atb$.rate
    stat_coef_var <- 1
    stat_skewness <- 2
    stat_kurtosis <- 9

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
        range = paste0(mean, " to Inf"),
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
