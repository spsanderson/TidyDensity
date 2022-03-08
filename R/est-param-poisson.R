#' Estimate Poisson Parameters
#'
#' @family Parameter Estimation
#' @family Poisson
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the pareto lambda
#' parameter given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated poisson data.
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
#' x <- as.integer(mtcars$mpg)
#' output <- util_poisson_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   ggplot(aes(x = y, group = dist_type, fill = dist_type)) +
#'   geom_histogram(binwidth = 0.5, color = "black") +
#'   theme_minimal() +
#'   theme(legend.position = "bottom")
#'
#' t <- rpois(50, 5)
#' util_poisson_param_estimate(t)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_poisson_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    minx <- min(x_term)
    maxx <- max(x_term)
    n <- length(x_term)
    unique_terms <- length(unique(x_term))

    # Checks ----
    if (!is.vector(x_term, mode = "numeric") || is.factor(x_term)){
        rlang::abort(
            message = "'.x' must be a numeric vector.",
            use_cli_format = TRUE
        )
    }

    if (n < 1 || any(x_term < 0) || any(x_term != trunc(x_term))){
        rlang::abort(
            message = "'.x' must contain at least one non-missing distinct value.
      All values of '.x' must be positive integers.",
            use_cli_format = TRUE
        )
    }

    # Get params ----
    # EnvStats
    m <- mean(x_term, na.rm = TRUE)

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_poisson(.n = n, .lambda = round(m, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = "Posson",
        samp_size = n,
        min = minx,
        max = maxx,
        method = "MLE",
        lambda = m
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "poisson"
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
