#' Estimate Uniform Parameters
#'
#' @family Parameter Estimation
#' @family Uniform
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the uniform min and max
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated uniform data.
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
#' x <- tidy_uniform(.min = 1, .max = 3)$y
#' output <- util_uniform_param_estimate(x)
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

util_uniform_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    minx <- min(x_term)
    maxx <- max(x_term)
    n <- length(x_term)
    unique_terms <- length(unique(x_term))

    # Checks ----
    if (!inherits(x_term, "numeric")){
        rlang::abort(
            message = "The '.x' parameter must be numeric.",
            use_cli_format = TRUE
        )
    }

    # Use linear model to obtain mu_hat
    mu_hat <- stats::lm(x_term ~ 1)$coefficients[[1]]
    s <- sqrt( ((maxx - minx)^2)/12 )

    # Momenth Method Estimator
    a_mme <- mu_hat - sqrt(3)*s
    b_mme <- mu_hat + sqrt(3)*s

    # MLE Estimator
    a_hat_mr <- stats::median(range(minx, maxx))
    h <- (0.5 * range(minx, maxx))

    a_mle <- round((a_hat_mr - h)[[2]], 0)
    b_mle <- round((a_hat_mr + h)[[2]], 0)

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_uniform(.n = n, .min = round(a_mme, 3), .max = round(b_mme, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = rep("Uniform", 2),
        samp_size = rep(n, 2),
        min       = rep(minx, 2),
        max       = rep(maxx, 2),
        method    = c("NIST_MME", "NIST_MLE"),
        min_est   = c(a_mme, a_mle),
        max_est   = c(b_mme, b_mle),
        ratio     = c(a_mme/b_mme, a_mle/b_mle)
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "uniform"
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
