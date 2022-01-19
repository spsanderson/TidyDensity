#' Tidy Randomly Generated Chisquare (Non-Central) Tibble
#'
#' @family Data Generator
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://www.itl.nist.gov/div898/handbook/eda/section3/eda3666.htm}
#'
#' @details This function uses the underlying `stats::rchisq()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rchisq()]
#'
#' @description This function will generate `n` random points from a chisquare
#' distribution with a user provided, shape, scale, and number of
#' random simulations to be produced. The function returns a tibble with the
#' simulation number column the x column which corresponds to the n randomly
#' generated points, the `d_`, `p_` and `q_` data points as well.
#'
#' The data is returned un-grouped.
#'
#' The columns that are output are:
#'
#' -  `sim_number` The current simulation number.
#' -  `x` The current value of `n` for the current simulation.
#' -  `y` The randomly generated data point.
#' -  `dx` The `x` value from the [stats::density()] function.
#' -  `dy` The `y` value from the [stats::density()] function.
#' -  `p` The values from the resulting p_ function of the distribution family.
#' -  `q` The values from the resulting q_ function of the distribution family.
#'
#' @param .n The number of randomly generated points you want.
#' @param .df Degrees of freedom (non-negative but can be non-integer)
#' @param .ncp Non-centrality parameter, must be non-negative.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_chisquare()
#'
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_chisquare <- function(.n = 50, .df = 1, .ncp = 1, .num_sims = 1){

    # Tidyeval ----
    n        <- as.integer(.n)
    num_sims <- as.integer(.num_sims)
    df    <- as.numeric(.df)
    ncp    <- as.numeric(.ncp)

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

    if(!is.numeric(shape) | !is.numeric(scale)){
        rlang::abort(
            "The parameter of rate must be of class numeric and greater than 0."
        )
    }

    if(df < 0 | ncp < 0){
        rlang::abort("The parameters of .df and .ncp must be greater than or equal to 0.")
    }

    x <- seq(1, num_sims, 1)

    ps <- seq(-n, n-1, 2)
    qs <- seq(0, 1, (1/(n-1)))

    df <- dplyr::tibble(sim_number = as.factor(x)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = list(stats::rchisq(n = n, df = df, ncp = ncp))) %>%
        dplyr::mutate(d = list(density(unlist(y), n = n)[c("x","y")] %>%
                                   purrr::set_names("dx","dy") %>%
                                   dplyr::as_tibble())) %>%
        dplyr::mutate(p = list(stats::pchisq(ps,  df = df, ncp = ncp))) %>%
        dplyr::mutate(q = list(stats::qchisq(qs,  df = df, ncp = ncp))) %>%
        tidyr::unnest(cols = c(x, y, d, p, q)) %>%
        dplyr::ungroup()


    # Attach descriptive attributes to tibble
    attr(df, ".df") <- .df
    attr(df, ".ncp") <- .ncp
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_chisquare"
    attr(df, "ps") <- ps
    attr(df, "qs") <- qs

    # Return final result as function output
    return(df)

}