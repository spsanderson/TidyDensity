#' Distribution Statistics
#'
#' @family Triangular
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
#' tidy_triangular() |>
#'   util_triangular_stats_tbl() |>
#'   glimpse()
#'
#' @return
#' A tibble
#'
#' @name util_triangular_stats_tbl
NULL
#' @export
#' @rdname util_triangular_stats_tbl

util_triangular_stats_tbl <- function(.data) {

    # Immediate check for tidy_ distribution function
    if (!"tibble_type" %in% names(attributes(.data))) {
        rlang::abort(
            message = "You must pass data from the 'tidy_dist' function.",
            use_cli_format = TRUE
        )
    }

    if (attributes(.data)$tibble_type != "tidy_triangular") {
        rlang::abort(
            message = "You must use 'tidy_chisquare()'",
            use_cli_format = TRUE
        )
    }

    # Data
    data_tbl <- dplyr::as_tibble(.data)

    atb <- attributes(data_tbl)

    a <- atb$.min
    b <- atb$.mode
    c <- atb$.max

    stat_mean <- (a + b + c) / 3
    stat_median <- if (c >= (a+b)/2) {
        (a + (sqrt((b-a)*(c-a))/2))
    } else {
        (b - (sqrt((b-1)*(b-c))/2))
    }
    stat_mode <- c
    stat_range <- range(data_tbl$y)
    stat_variance <- ((a^2) + (b^2) + (c^2) - (a*b) - (a*c) - (b*c)) / 18
    stat_skewness <- ((sqrt(2) * (a + b - (2*c))) * ((2*a) - b - c) * (a - 2*b +c)) / 5*(a^2 + b^2 + c^2 - a*b - a*c - b*c)^(3/2)
    stat_kurtosis <- -(3/5)
    stat_entropy <- 0.5 * log((b-a)/2)

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
        range_low = stat_range[[1]],
        range_high = stat_range[[2]],
        variance = stat_variance,
        skewness = stat_skewness,
        kurtosis = stat_kurtosis,
        entropy = stat_entropy,
        computed_std_skew = tidy_skewness_vec(data_tbl$y),
        computed_std_kurt = tidy_kurtosis_vec(data_tbl$y),
        ci_lo = ci_lo(data_tbl$y),
        ci_hi = ci_hi(data_tbl$y)
    )

    # Return
    return(ret)
}
