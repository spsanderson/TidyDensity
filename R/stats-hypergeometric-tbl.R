#' Distribution Statistics
#'
#' @family Hypergeometric
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
#' tidy_hypergeometric() %>%
#'   util_hypergeometric_stats_tbl() %>%
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @export
#'

util_hypergeometric_stats_tbl <- function(.data){

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))){
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_hypergeometric"){
        rlang::abort(
            message = "You must use 'tidy_hypergeometric()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)
    N <- atb$.m + atb$.nn
    m <- atb$.m
    n <- atb$.nn
    k <- atb$.k

    a <- (N-1)*(N^2)
    b <- (3*m)*(N-m)*((n^2)*(-N)* + (n-2)*(N^2) + (6*n) * (N-n))
    c <- N^2
    d <- (6*n) * (N - n) + N*(N + 1)
    e <- (m*n) * (N - 3) * (N - 2) * (N - m) * (N - n)

    stat_mean   <- (m*n)/N
    stat_mode   <- c(
        ((n + 1)*(k + 1))/(N + 2) - 1,
        ((n + 1)*(k + 1))/(N + 2)
    )
    stat_sd <- sqrt(((m*n) * (N-m)*(N-n))/(N-1))/N
    stat_skewness <- (sqrt(N-1) * (N - 2*m) * (N - 2*n))/((N-2)*sqrt((m*n) * (N - m) * (N - n)))
    stat_kurtosis <- (a * (b/c - d)) / e
    stat_coef_var <- ((m*n) * (1 - (m/n)) * (N - n)) / ((N - 1)*N)

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
        mode_lower = stat_mode[[1]],
        mode_upper = stat_mode[[2]],
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
