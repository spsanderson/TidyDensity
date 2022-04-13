#' Distribution Statistics
#'
#' @family Binomaial
#' @family Negative Binomial
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
#' tidy_negative_binomial() %>%
#'   util_negative_binomial_stats_tbl()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_negative_binomial_stats_tbl <- function(.data){

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))){
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_negative_binomial"){
        rlang::abort(
            message = "You must use 'tidy_negative_binomial()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)
    r <- atb$.size
    p <- atb$.prob

    stat_mean   <- (p*r)/(1 - p)
    stat_mode   <- ifelse(r > 1, floor((p*(r-1))/(1 - p)), 0)
    stat_coef_var <- (p*r)/((1 - p)^2)
    stat_sd <- sqrt(stat_coef_var)
    stat_skewness <- (1 + p)/sqrt(p*r)
    stat_kurtosis <- 6/r + ((1-p)^2)/(p*r)

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
        computed_std_kurt = tidy_kurtosis_vec(data_tbl$y)
    )

    # Return
    return(ret)

}
