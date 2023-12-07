#' Generate Tidy Data from Triangular Distribution
#'
#' @family Continuous Distribution
#' @family Triangular
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description This function generates tidy data from the triangular distribution.
#'
#' @details The function takes parameters for the triangular distribution
#' (minimum, maximum, mode), the number of x values (`n`), the number of
#' simulations (`num_sims`), and an option to return the result as a tibble
#' (`return_tibble`). It performs various checks on the input parameters to ensure
#' validity. The result is a data frame or tibble with tidy data for
#' further analysis.
#'
#' @param .n The number of x values for each simulation.
#' @param .min The minimum value of the triangular distribution.
#' @param .max The maximum value of the triangular distribution.
#' @param .mode The mode (peak) value of the triangular distribution.
#' @param .num_sims The number of simulations to perform.
#' @param .return_tibble A logical value indicating whether to return the result
#' as a tibble. Default is TRUE.
#'
#' @examples
#' tidy_triangular(.return_tibble = TRUE)
#'
#' @return
#' A tibble of randomly generated data.
#'
#' @name tidy_triangular
NULL

#' @export
#' @rdname tidy_triangular


tidy_triangular <- function(.n = 50, .min = 0, .max = 1,
                            .mode = 1/2, .num_sims = 1, .return_tibble = TRUE){

    # Arguments
    n <- as.integer(.n)
    num_sims <- as.integer(.num_sims)
    mn <- as.numeric(.min)
    mx <- as.numeric(.max)
    md <- as.numeric(.mode)
    ret_tbl <- as.logical(.return_tibble)

    # Checks ----
    if (!is.integer(n) | n < 0) {
        rlang::abort(
            message = "The parameters '.n' must be of class integer. Please pass a whole
            number like 50 or 100. It must be greater than 0.",
            use_cli_format = TRUE
        )
    }

    if (!is.integer(num_sims) | num_sims < 0) {
        rlang::abort(
            message = "The parameter `.num_sims' must be of class integer. Please pass a
            whole number like 50 or 100. It must be greater than 0.",
            use_cli_format = TRUE
        )
    }

    if (mn > mx){
        rlang::abort(
            message = "The parameters .min and .max must satisfy .min < .max",
            use_cli_format = TRUE
        )
    }

    if (md < mn || md > mx){
        rlang::abort(
            message = "The parameters must follow .min <= .mode <= .max",
            use_cli_format = TRUE
        )
    }

    # Create a data.table with one row per simulation
    df <- data.table::CJ(sim_number = factor(1:num_sims), x = 1:n)

    # Group the data by sim_number and add columns for x and y
    df[, y := EnvStats::rtri(n = .N, min = mn, max = mx, mode = md)]

    # Compute the density of the y values and add columns for dx and dy
    df[, c("dx", "dy") := density(y, n = n)[c("x", "y")], by = sim_number]

    # Compute the p-values for the y values and add a column for p
    df[, p := EnvStats::ptri(y, min = mn, max = mx, mode = md)]

    # Compute the q-values for the p-values and add a column for q
    df[, q := EnvStats::qtri(p, min = mn, max = mx, mode = md)]

    if(.return_tibble){
        df <- dplyr::as_tibble(df)
    } else {
        data.table::setkey(df, NULL)
    }

    # Create tibble of parameter grid
    param_grid <- dplyr::tibble(mn, mx, md)

    # Attach descriptive attributes to tibble
    attr(df, "distribution_family_type") <- "continuous"
    attr(df, ".min") <- .min
    attr(df, ".max") <- .max
    attr(df, ".mode") <- .mode
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, ".ret_tbl") <- .return_tibble
    attr(df, "tibble_type") <- "tidy_triangular"
    attr(df, "param_grid") <- param_grid
    attr(df, "param_grid_txt") <- paste0(
        "c(",
        paste(param_grid[, names(param_grid)], collapse = ", "),
        ")"
    )
    attr(df, "dist_with_params") <- paste0(
        "Triangular",
        " ",
        paste0(
            "c(",
            paste(param_grid[, names(param_grid)], collapse = ", "),
            ")"
        )
    )

    return(df)
}
