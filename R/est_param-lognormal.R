#' Estimate Lognormal Parameters
#'
#' @family Parameter Estimation
#' @family Lognormal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will attempt to estimate the lognormal meanlog and log sd
#' parameters given some vector of values.
#'
#' @description The function will return a list output by default, and  if the parameter
#' `.auto_gen_empirical` is set to `TRUE` then the empirical data given to the
#' parameter `.x` will be run through the `tidy_empirical()` function and combined
#' with the estimated lognormal data.
#'
#' Three different methods of shape parameters are supplied:
#' -  mme, see [EnvStats::elnorm()]
#' -  mle, see [EnvStats::elnorm()]
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
#' output <- util_lognormal_param_estimate(x)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   ggplot(aes(x = dx, y = dy, group = dist_type, color = dist_type)) +
#'   geom_line() +
#'   theme_minimal() +
#'   theme(legend.position = "bottom")
#'
#' tb <- tidy_lognormal(.meanlog = 2, .sdlog = 1) %>% pull(y)
#' util_lognormal_param_estimate(tb)$parameter_tbl
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_lognormal_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    minx <- min(x_term)
    maxx <- max(x_term)
    n <- length(x_term)
    unique_terms <- length(unique(x_term))

    # Checks ----
    if (!is.vector(x_term, mode = "numeric")){
        rlang::abort(
            message = "'.x' must be a numeric vector.",
            use_cli_format = TRUE
        )
    }

    if (n < 2 || unique_terms < 2 || any(x_term <= 0)){
        rlang::abort(
            message = paste0("'.x' must contain at least two non-missing distict values.
                             All non-missing values must be positive."),
            use_cli_format = TRUE
        )
    }

    log_x <- log(x_term)
    muhat <- mean(log_x)
    es_mvue_sd <- sd(log_x)
    es_mme_sd <- sqrt((n - 1)/n) * sd(log_x)

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_lognormal(.n = n, .meanlog = round(muhat, 3), .sdlog = round(es_mme_sd, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = rep('Lognormal', 2),
        samp_size = rep(n, 2),
        min = rep(minx, 2),
        max = rep(maxx, 2),
        method = c("EnvStats_MVUE", "EnvStats_MME"),
        mean_log = c(muhat, muhat),
        sd_log = c(es_mvue_sd, es_mme_sd),
        shape_ratio = c(muhat/es_mvue_sd, muhat/es_mme_sd)
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "lognormal"
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
