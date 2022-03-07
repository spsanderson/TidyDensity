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
#' th <- rhyper(10, 20, 30, 5)
#' output <- util_hypergeometric_param_estimate(th, .total = 50, .k = 5)
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
    x_vec <- as.numeric(.x)
    x_term <- x_vec[1]
    k <- .k
    m <- .m
    n <- length(x_vec)
    t <- .total


    # Checks ----
    if (!is.vector(x_term, mode = "numeric") || length(x_term) != 1 ||
           !is.finite(x_term) || x_term != trunc(x_term) ||
           !is.vector(k, mode = "numeric") ||
           length(k) != 1 || !is.finite(k) || k != trunc(k)){
        rlang::abort(
            message = "You must supply a single integer value '.x' and '.k'.",
            use_cli_format = TRUE
        )
    }

    if ((is.null(m) & is.null(t)) || (!is.null(m) & !is.null(t))){
        rlang::abort(
            message = "You must supply either '.m' or '.total', but not both.",
            use_cli_format = TRUE
        )
    }

    if (!is.null(m)) {
        if (!is.vector(m, mode = "numeric") || length(m) != 1 ||
            !is.finite(m) || m != trunc(m)){
            rlang::abort(
                message = "Missing values are not allowed for '.m' and it must be
                an integer.",
                use_cli_format = TRUE
            )
        }
        est_m <- FALSE
    } else {
        if (!is.vector(t, mode = "numeric") || length(t) != 1 ||
            !is.finite(t) || t != trunc(t)){
            rlang::abort(
                message = "Missing values are not allowed for '.total' and it must be
                an integer.",
                use_cli_format = TRUE
            )
        }
        est_m <- TRUE
    }

    # Estimateion ----
    if (est_m){
        if (x_term < 0 || x_term > k){
            rlang::abort(
                message = paste0(
                    "'.x' must be between 0 and '.k'. You gave values of: ",
                    "'.x' = ", x_term,
                    " and '.k. = ", k
                ),
                use_cli_format = TRUE
            )
        }

        if (t < 1){
            rlang::abort(
                message = paste0("'.t' must be at least 1. You gave '.total' = ", t),
                use_cli_format = TRUE
            )
        }

        if (k < 1 || k > t){
            rlang::abort(
                message = paste0("'.k' must be between 1 and '.total'. You gave '.k' = ", k,
                                 "and '.total' = ", t),
                use_cli_format = TRUE
            )
        }

        m_hat <- ((t + 1) * x_term)/k
        ifelse(m_hat == trunc(m_hat), m_hat - 1, floor(m_hat))
        es_mle_m  <- m_hat
        es_mvue_m <- (t * x_term)/k
    } else {
        if (x_term < 0 || x_term > min(k, m)){
            rlang::abort(
                message = paste0("'.x' must be between 0 and min(k, m). Values supplied are: ",
                                 "'.x' = ", x_term, "'.k' = ", k, " and '.m' = ", m),
                use_cli_format = TRUE
            )
        }

        if (m < 0){
            rlang::abort(
                message = paste0("'.m' must be at least 0. Value suppled is: ", m),
                use_cli_format = TRUE
            )
        }

        if (k < 1){
            rlang::abort(
                message = paste0("'.k' must be at least 1. Value supplied is: ", k),
                use_cli_format = TRUE
            )
        }

        es_mle_t <- floor((k * m)/x_term)
    }

    # Return Tibble ----
    if(!.auto_gen_empirical | n < 2){
        rlang::inform(
            message = paste0("Empirical data cannot be generated because '.auto_gen_empirical' = ",
            .auto_gen_empirical, " and the length of '.x' is ", n, "'.auto_gen_empirical' must
            bet TRUE and n must be at least 2."),
            use_cli_format = TRUE
        )
    } else {
        te <- tidy_empirical(.x = x_vec)
        td <- tidy_hypergeometric(.n = n, .m = es_mle_m, .nn = t, .k = k)
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    # ES MLE Total Exists?
    if (!exists("es_mle_t", mode = "numeric")){
        es_mle_t <- NA
    }

    ret <- dplyr::tibble(
        dist_type = rep('Hypergeometric', 2),
        samp_size = rep(n, 2),
        method = c("EnvStats_MLE", "EnvStats_MVUE"),
        m = c(es_mle_m, es_mvue_m),
        total = c(es_mle_t, t)
    )

    # Return ----
    attr(ret, "tibble_type") <- "parameter_estimation"
    attr(ret, "family") <- "hypergeometric"
    attr(ret, "x_term") <- x_term
    attr(ret, "n") <- n

    ct_exists <- if(exists("combined_tbl") && nrow(combined_tbl) > 1){
        ct_exists <- TRUE
    } else {
        ct_exists <- FALSE
    }

    if (.auto_gen_empirical & ct_exists){
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
