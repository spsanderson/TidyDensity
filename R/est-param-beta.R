#' Estimate Beta Parameters
#'
#' @family Parameter Estimation
#' @family Beta
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This is a wrapper for the [EnvStats::ebeta()] function.
#'
#' @description This function is a wrapper for the [EnvStats::ebeta()] function.
#' It will automatically scale the data from 0 to 1 if it is not already. This means
#' you can pass a vector like `mtcars$mpg` and not worry about it.
#'
#' @param .x The vector of data to be passed to the function. Must be numeric, and
#' all values must be 0 <= x <= 1
#' @param .auto_gen_empirical This is a boolean value of TRUE/FALSE with default
#' set to TRUE. This will automatically create the `tidy_empirical()` output
#' for the `.x` parameter and use the `tidy_combine_distributions()`. The user
#' can then plot out the data using `$combined_data_tbl` from the function output.
#'
#' @examples
#' library(dplyr)
#'
#' tb <- tidy_beta(.n = 50, .shape1 = 2.5, .shape2 = 1.4, .ncp = 0) %>%
#'   pull(y)
#' util_beta_param_estimate(tb)
#'
#' @return
#' A tibble
#'
#' @export
#'

util_beta_param_estimate <- function(.x, .auto_gen_empirical = TRUE){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    minx <- min(x_term)
    maxx <- max(x_term)

    # Checks ----
    if (length(n) < 2  || length(unique(x_term)) < 2){
        rlang::abort(
            message = "The data must have at least two (2) unique data points.",
            use_cli_format = TRUE
        )
    }

    if (!is.numeric(x_term)){
        rlang::abort(
            "The '.x' parameter must be numeric."
        )
    }

    if (minx < 0 | maxx > 1){
        rlang::inform(
            message = "For the beta distribution, its mean 'mu' should be 0 < mu < 1.
      The data will therefore be scaled to enforce this.",
            use_cli_format = TRUE
        )
        x_term <- healthyR.ai::hai_scale_zero_one_vec(x_term)
        scaled <- TRUE
    } else {
        rlang::inform(
            message = "There was no need to scale the data.",
            use_cli_format = TRUE
        )
        x_term <- x_term
        scaled <- FALSE
    }

    # Get params ----
    n <- length(x_term)
    m <- mean(x_term, na.rm = TRUE)
    s2 <- var(x_term, na.rm = TRUE)

    # wikipedia generic
    alpha <- m * n
    beta <- sqrt(((1- m) * n)^2)

    # https://itl.nist.gov/div898/handbook/eda/section3/eda366h.htm
    p <- m * (((m * (1- m))/s2) - 1)
    q <- (1 - m) * (((m * (1 - m))/s2) - 1)

    if (p < 0){
        p <- sqrt((p)^2)
    }

    if (q < 0){
        q <- sqrt((q)^2)
    }

    # EnvStats
    term <- ((m * (1 - m))/(((n - 1)/n) * s2)) - 1
    esshape1 <- m * term
    esshape2 <- (1 - m) * term

    # Return Tibble ----
    if (.auto_gen_empirical){
        te <- tidy_empirical(.x = x_term)
        td <- tidy_beta(.n = n, .shape1 = round(p, 3), .shape2 = round(q, 3))
        combined_tbl <- tidy_combine_distributions(te, td)
    }

    ret <- dplyr::tibble(
        dist_type = rep('Beta', 3),
        samp_size = rep(n, 3),
        min = rep(minx, 3),
        max = rep(maxx, 3),
        mean = rep(m, 3),
        variance = rep(s2, 3),
        method = c("Bayes", "NIST_MME", "EnvStats_MME"),
        shape1 = c(alpha, p, esshape1),
        shape2 = c(beta, q, esshape2),
        shape_ratio = c(alpha/beta, p/q, esshape1/esshape2)
    )

    # Return ----
    attr(ret, "tibble_typle") <- "beta_parameter_estimation"
    attr(ret, "x_term") <- .x
    attr(ret, "scaled") <- scaled
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

