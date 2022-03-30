#' Estimate Normal Gaussian Parameters
#'
#' @family Parameter Estimation
#' @family Gaussian
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the normal gaussian mean and standard
#' deviation parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated normal data.
#'
#' Three different methods of shape parameters are supplied:
#' -  MLE/MME
#' -  MVUE
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
#' output <- util_normal_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   tidy_combined_autoplot()
#'
#' t <- rnorm(50, 0, 1)
#' util_normal_param_estimate(t)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_normal_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    minx <- min(x_term)
    maxx <- max(x_term)
    m <- mean(x_term, na.rm = TRUE)
    n <- length(x_term)
    unique_terms <- length(unique(x_term))

    # Checks ----
    if (!is.vector(x_term, mode = "numeric")){
        rlang::abort(
            message = "'.x' must be a numeric vector.",
            use_cli_format = TRUE
        )
    }

    if (n < 2 || unique_terms < 2){
        rlang::abort(
            message = "'.x' must contain at least two non-missing distinct values",
            use_cli_format = TRUE
        )
    }

    # Get params ----
    # EnvStats
    es_mvue_sd <- stats::sd(x_term)
    es_mme_sd <- sqrt((n - 1)/n) * stats::sd(x_term)

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_normal(.n = n, .mean = round(m, 3), .sd = round(es_mme_sd, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = rep('Gaussian', 2),
        samp_size = rep(n, 2),
        min = rep(minx, 2),
        max = rep(maxx, 2),
        method = c("EnvStats_MME_MLE", "EnvStats_MVUE"),
        mu = c(m, m),
        stan_dev = c(es_mme_sd, es_mvue_sd),
        shape_ratio = c(m/es_mme_sd, m/es_mvue_sd)
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "gaussian"
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
