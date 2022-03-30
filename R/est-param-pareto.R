#' Estimate Pareto Parameters
#'
#' @family Parameter Estimation
#' @family Pareto
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the pareto shape and scale
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated pareto data.
#'
#' Two different methods of shape parameters are supplied:
#' -  LSE
#' -  MLE
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
#' x <- mtcars$mpg
#' output <- util_pareto_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   tidy_combined_autoplot()
#'
#' t <- tidy_pareto(50, 1, 1) %>% pull(y)
#' util_pareto_param_estimate(t)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_pareto_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

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

    if (n < 2 || any(x_term <= 0) || unique_terms < 2){
        rlang::abort(
            message = "'.x' must contain at least two non-missing distinct values.
      All values of '.x' must be positive.",
            use_cli_format = TRUE
        )
    }

    # Get params ----
    # EnvStats
    ppc <- 0.375
    fhat <- stats::ppoints(n, a = ppc)
    lse_coef <- stats::lm(log(1 - fhat) ~ log(sort(x_term)))$coefficients
    lse_scale <- -lse_coef[[2]]
    lse_shape <- exp(lse_coef[[1]]/lse_scale)

    mle_shape <- min(x_term)
    mle_scale <- n/sum(log(x_term/mle_shape))

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_pareto(.n = n, .shape = round(lse_shape, 3), .scale = round(lse_scale, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = rep('Pareto', 2),
        samp_size = rep(n, 2),
        min = rep(minx, 2),
        max = rep(maxx, 2),
        method = c("LSE", "MLE"),
        shape = c(lse_shape, mle_shape),
        scale = c(lse_scale, mle_scale),
        shape_ratio = c(shape/scale)
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "pareto"
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
