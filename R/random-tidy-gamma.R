

tidy_gamma <- function(.n = 50, .shape = 1, .rate = 1, .num_sims = 1){

    # Tidyeval ----
    n        <- as.integer(.n)
    num_sims <- as.integer(.num_sims)
    shp <- .shape
    rte <- .rate

    # Checks ----
    if(!is.integer(n) | n < 0){
        rlang::abort(
            "The parameters '.n' must be of class integer. Please pass a whole
            number like 50 or 100. It must be greater than 0."
        )
    }

    if(!is.integer(num_sims) | num_sims < 0){
        rlang::abort(
            "The parameter `.num_sims' must be of class integer. Please pass a
            whole number like 50 or 100. It must be greater than 0."
        )
    }

    if(!is.numeric(shp) | shp < 0){
        rlang::abort(
            "The parameters of '.shapte' and '.rate' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc. and must be greater than 0."
        )
    }

    if(!is.numeric(rte)){
        rlang::abort(
            "The parameters of '.shape' and '.rate' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
        )
    }

    x <- seq(1, num_sims, 1)

    ps <- seq(-n, n-1, 2)
    qs <- seq(0, 1, (1/(n-1)))

    df <- dplyr::tibble(sim_number = as.factor(x)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = list(stats::rgamma(n = n, shape = shp, rate = rte))) %>%
        dplyr::mutate(d_gamma = list(stats::dgamma(unlist(y), shape = shp, rate = rte))) %>%
        dplyr::mutate(p_gamma = list(stats::pgamma(ps, shape = shp, rate = rte))) %>%
        dplyr::mutate(q_gamma = list(stats::qgamma(qs, shape = shp, rate = rte))) %>%
        tidyr::unnest(cols = c(x, y, d_gamma, p_gamma, q_gamma)) %>%
        dplyr::ungroup()


    # Attach descriptive attributes to tibble
    attr(df, ".shape") <- .shape
    attr(df, ".rate") <- .rate
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_gamma"
    attr(df, "ps") <- ps
    attr(df, "qs") <- qs

    # Return final result as function output
    return(df)

}

tidy_rgamma()
