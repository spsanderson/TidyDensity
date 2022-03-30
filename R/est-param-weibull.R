#' Estimate Weibull Parameters
#'
#' @family Parameter Estimation
#' @family Weibull
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the weibull shape and scale
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated weibull data.
#'
#' @param .x The vector of data to be passed to the function.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' x <- tidy_weibull(.shape = 1, .scale = 2)$y
#' output <- util_weibull_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   tidy_combined_autoplot()
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_weibull_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    x_surv <- survival::Surv(x_term)
    minx <- min(x_term)
    maxx <- max(x_term)
    n <- length(x_term)
    unique_terms <- length(unique(x_term))

    # Checks ----
    if (!inherits(x_surv, "Surv") | !inherits(.x, "numeric")){
        rlang::abort(
            message = "The '.x' parameter must be a numeric vector.",
            use_cli_format = TRUE
        )
    }

    # Make survival regression model
    yw <- survival::survreg(x_surv ~ 1, dist = "weibull")

    w_scale <- w_scale <- as.numeric(exp(stats::coefficients(yw)[[1]]))
    w_shape <- 1/yw$scale

    # Return Tible ----
    if(.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_weibull(.n = n, .shape = round(w_shape, 3), .scale = round(w_scale, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = 'Weibull',
        samp_size = n,
        min = minx,
        max = maxx,
        method = "NIST",
        shape = w_shape,
        scale = w_scale,
        shape_ratio = (w_shape/w_scale)
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "weibull"
    attr(ret, "x_term") <- .x
    attr(ret, "n") <- n

    if (.auto_gen_empirical){
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
