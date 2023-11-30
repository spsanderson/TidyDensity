#' Estimate Triangular Parameters
#'
#' @family Parameter Estimation
#' @family Triangular
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the triangular min, mode, and max
#' parameters given some vector of values.
#'
#' @description This function will attempt to estimate the triangular min, mode, and max
#' parameters given some vector of values.
#'
#' The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated beta data.
#'
#' @param .x The vector of data to be passed to the function. Must be numeric, and
#' all values must be 0 <= x <= 1
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' x <- mtcars$mpg
#' output <- util_triangular_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl |>
#'   tidy_combined_autoplot()
#'
#' params <- tidy_triangular()$y |>
#'   util_triangular_param_estimate()
#' params$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @name util_triangular_param_estimate
NULL
#'
#' @export
#' @rdname util_triangular_param_estimate

util_triangular_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

    # Tidyeval ----
    x_term <- as.numeric(.x)
    minx <- min(x_term)
    maxx <- max(x_term)
    n <- length(x_term)

    # Checks ----
    if (n < 3) {
        rlang::abort(
            message = "The data must have at least three (3) unique data points.",
            use_cli_format = TRUE
        )
    }

    if (!is.numeric(x_term)) {
        rlang::abort(
            "The '.x' parameter must be numeric."
        )
    }

    # Get params ----
    a <- min(x_term)
    c <- max(x_term)
    b <- 3*mean(x_term) - max(x_term) - min(x_term)


    # Return Tibble ----
    if (.auto_gen_empirical) {
        te <- tidy_empirical(.x = x_term)
        td <- tidy_triangular(.n = n, .min = round(a, 3), .mode = round(b, 3), .max = round(c, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = "Triangular",
        samp_size = n,
        min = minx,
        max = maxx,
        mode = c,
        method = "Basic"
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "triangular"
    attr(ret, "x_term") <- .x
    attr(ret, "n") <- n

    if (.auto_gen_empirical) {
        output <- list(
            combined_data_tbl = combined_tbl,
            parameter_tbl     = ret
        )
    } else {
        output <- list(
            parameter_tbl = ret
        )
    }

    return(output)
}
