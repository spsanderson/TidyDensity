#' Estimate Burr Parameters
#'
#' @family Parameter Estimation
#' @family Burr
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will see if the given vector `.x` is a numeric vector.
#' It will attempt to estimate the prob parameter of a Burr distribution.
#'
#' @description This function will attempt to estimate the Burr prob parameter
#' given some vector of values `.x`. The function will return a list output by default,
#' and  if the parameter `.auto_gen_empirical` is set to `TRUE` then the empirical
#' data given to the parameter `.x` will be run through the `tidy_empirical()`
#' function and combined with the estimated Burr data.
#'
#' @param .x The vector of data to be passed to the function. Must be non-negative
#' integers.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' tb <- tidy_burr(.shape1 = 1, .shape2 = 2, .rate = .3) %>% pull(y)
#' output <- util_burr_param_estimate(tb)
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

util_burr_param_estimate <- function(.x, .auto_gen_empirical = TRUE) {

    # Tidyeval ----
    x_term <- as.numeric(.x)
    n <- length(x_term)

    # Checks ----
    if (!is.vector(x_term, mode = "numeric")) {
        rlang::abort(
            message = "The '.x' term must be a numeric vector.",
            use_cli_format = TRUE
        )
    }

    if (any(x_term < 0)) {
        rlang::abort(
            message = "All values of 'x' must be non-negative integers greater than 0.",
            use_cli_format = TRUE
        )
    }

    if (n < 2) {
        rlang::abort(
            message = "You must supply at least two data points for this function.",
            use_cli_format = TRUE
        )
    }

    # Parameters ----
    # https://stats.stackexchange.com/a/595379/35448
    burr_lik <- function(theta,x){
        c <- exp(theta[1])
        k <- exp(theta[2])
        mu <- 0
        sigma <- exp(theta[3])
        bll <- actuar::dburr(x, c, k, mu, sigma)
        return(-sum(log(bll)))
    }

    brmod <- stats::optim(
        c(
            .shape1 = 0,
            .shape2 = 0,
            .scale = 0
        ),
        fn = burr_lik,
        x = x_term
    )

    est_params <- exp(brmod$par)
    shape1 <- est_params[[1]]
    shape2 <- est_params[[2]]
    rate <- est_params[[3]]
    scale <- 1/rate

    # Return Tibble ----
    if (.auto_gen_empirical) {
        te <- tidy_empirical(.x = x_term)
        td <- tidy_burr(.n = n, .shape1 = round(shape1, 3),
                        .shape2 = round(shape2, 3),
                        .rate = round(rate, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = "Burr",
        samp_size = n,
        min = min(x_term),
        max = max(x_term),
        mean = mean(x_term),
        shape1 = shape1,
        shape2 = shape2,
        rate = rate,
        scale = scale
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "bernoulli"
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
