#' Estimate Exponential Parameters
#'
#' @family Parameter Estimation
#' @family Exponential
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will see if the given vector `.x` is a numeric vector.
#'
#' @description This function will attempt to estimate the exponential rate parameter
#' given some vector of values. The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated exponential data.
#'
#' @param .x The vector of data to be passed to the function. Must be numeric.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' te <- tidy_exponential(.rate = .1) %>% pull(y)
#' output <- util_exponential_param_estimate(te)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   ggplot(aes(x = dx, y = dy, group = dist_type, color = dist_type)) +
#'   geom_line() +
#'   theme_minimal() +
#'   theme(legend.position = "bottom")
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_exponential_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- .x
    n <- length(x_term)
    minx <- min(as.numeric(x_term))
    maxx <- max(as.numeric(x_term))
    m <- mean(as.numeric(x_term))
    s2 <- var(as.numeric(x_term))

    # Checks ----
    if (!is.numeric(x_term)){
        rlang::abort(
            message = "The '.x' term must be a numeric vector.",
            use_cli_format = TRUE
        )
    }

    if (!is.vector(x_term)){
        rlang::abort(
            message = "The '.x' term must be a numeric vecotr.",
            use_cli_format = TRUE
        )
    }

    rate <- 1/m

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_exponential(.n = n, .rate = round(rate, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = 'Exponential',
        samp_size = n,
        min = minx,
        max = maxx,
        mean = m,
        variance = s2,
        method = "NIST_MME",
        rate = rate
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "exponential"
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
