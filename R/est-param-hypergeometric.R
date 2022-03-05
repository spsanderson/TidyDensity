#' Estimate Hypergeometric Parameters
#'
#' @family Parameter Estimation
#' @family Hypergeometric
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will see if the given vector `.x` is a numeric integer.
#' It will attempt to estimate the prob parameter of a geometric distribution.
#' Missing (NA), undefined (NaN), and infinite (Inf, -Inf) values are not allowed.
#' Let `.x` be an observation from a hypergeometric distribution with parameters
#' `.m` = `M`, .`n` = `N`, and `.k` = `K`. In R nomenclature, .`x` represents
#' the number of white balls drawn out of a sample of `.k` balls drawn without
#' replacement from an urn containing `.m` white balls and `.n` black balls.
#' The total number of balls in the urn is thus `.m` + `.n`. Denote the total
#' number of balls by `T` = `.m` + `.n`
#'
#' @description This function will attempt to estimate the geometric prob parameter
#' given some vector of values `.x`. Estimate m, the number of white balls in
#' the urn, or m+n, the total number of balls in the urn, for a hypergeometric
#' distribution.
#'
#' @param .x A non-negative integer indicating the number of white balls out of a
#' sample of size `.k` drawn without replacement from the urn.
#' You cannot have missing, undefined or infinite values.
#' @param .m Non-negative integer indicating the number of white balls in the urn.
#' You must supply `.m` or `.total`, but not both. You cannot have missing values.
#' @param .k A positive integer indicating the number of balls drawn without
#' replacement from the urn. You cannot have missing values.
#' @param .total A positive integer indicating the total number of balls in the
#' urn (i.e., m+n). You must supply `.m` or `.total`, but not both. You cannot
#' have missing values.
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' th <- rhyper(1, 20, 30, 5)
#' output <- util_hypergeometric_param_estimate(th)
#'
#' output$parameter_tbl
#'
#' output$combined_data_tbl %>%
#'   ggplot(aes(x = y, group = dist_type, fill = dist_type)) +
#'   geom_histogram(binwidth = 0.5, color = "black") +
#'   theme_minimal() +
#'   theme(legend.position = "bottom")
#'
#' @return
#' A tibble/list
#'
#' @export
#'

util_hypergeometric_param_estimate <- function(.x, .m = NULL, .total = NULL, .k,
                                               .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    k <- .k
    m <- .m
    n <- length(x_term)


    # Checks ----
    if (!is.vector(x_term, mode = "numeric") || length(x_term) != 1 ||
        !is.finite(x_term) || x != trunc(x_term) || !is.vector(k, mode = "numeric") ||
        length(k) != 1 || !is.finite(k) || k != trunc(k))
        stop("Missing values not allowed for 'x' and 'k' and they must be integers")
    if ((is.null(m) & is.null(total)) || (!is.null(m) & !is.null(total)))
        stop("You must supply 'm' or 'total' but not both")
    if (!is.null(m)) {
        if (!is.vector(m, mode = "numeric") || length(m) != 1 ||
            !is.finite(m) || m != trunc(m))
            stop("Missing values not allowed for 'm' and it must be an integer")
        est.m <- FALSE
    }
    else {
        if (!is.vector(total, mode = "numeric") || length(total) !=
            1 || !is.finite(total) || total != trunc(total))
            stop("Missing values not allowed for 'total' and it must be an integer")
        est.m <- TRUE
    }

    # Parameters ----
    # EnvStats
    es_mme_prob <- n/(n + sum_x)
    es_mvue_prob <- (n - 1)/(n + sum_x - 1)

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_geometric(.n = n, .prob = round(es_mme_prob, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = rep('Geometric', 2),
        samp_size = rep(n, 2),
        min = rep(minx, 2),
        max = rep(maxx, 2),
        mean = rep(m, 2),
        variance = rep(s, 2),
        sum_x = rep(sum_x, 2),
        method = c("EnvStats_MME", "EnvStats_MVUE"),
        shape = c(es_mme_prob, es_mvue_prob)
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "geometric"
    attr(ret, "x_term") <- .x
    attr(ret, "n") <- n

    if (.auto_gen_empirical){
        output <- list(
            combined_data_tbl = combined_tbl,
            parameter_tbl     = ret
        )
    } else {
        output <- ret
    }

    return(output)

}
