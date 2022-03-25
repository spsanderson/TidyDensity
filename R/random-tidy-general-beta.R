#' Tidy Randomly Generated Generalized Beta Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Beta
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://statisticsglobe.com/beta-distribution-in-r-dbeta-pbeta-qbeta-rbeta}
#' @seealso \url{https://en.wikipedia.org/wiki/Beta_distribution}
#' @seealso \url{https://openacttexts.github.io/Loss-Data-Analytics/C-SummaryDistributions.html}
#'
#' @details This function uses the underlying `stats::rbeta()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rbeta()]
#'
#' @description This function will generate `n` random points from a generalized beta
#' distribution with a user provided, `.shape1`, `.shape2`, `.shape3`, `.rate`, and/or
#' `.sclae`, and number of random simulations to be produced. The function returns a tibble with the
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
#' @param .shape1 A non-negative parameter of the Beta distribution.
#' @param .shape2 A non-negative parameter of the Beta distribution.
#' @param .shape3 A non-negative parameter of the Beta distribution.
#' @param .scale Must be strictly positive.
#' @param .rate An alternative way to specify the `.scale` parameter.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_generalized_beta()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_generalized_beta <- function(.n = 50, .shape1 = 1, .shape2 = 1,
                                  .shape3 = 1, .rate = 1, .scale = 1/.rate,
                                  .num_sims = 1) {

    # Tidyeval ----
    n <- as.integer(.n)
    num_sims <- as.integer(.num_sims)
    shape1 <- as.numeric(.shape1)
    shape2 <- as.numeric(.shape2)
    shape3 <- as.numeric(.shape3)
    rate <- as.numeric(.rate)
    scl <- as.numeric(.scale)

    # Checks ----
    if (!is.integer(n) | n < 0) {
        rlang::abort(
            "The parameters '.n' must be of class integer. Please pass a whole
            number like 50 or 100. It must be greater than 0."
        )
    }

    if (!is.integer(num_sims) | num_sims < 0) {
        rlang::abort(
            "The parameter `.num_sims' must be of class integer. Please pass a
            whole number like 50 or 100. It must be greater than 0."
        )
    }

    if (!is.numeric(shape1) | !is.numeric(shape2) | !is.numeric(shape3) |
        !is.numeric(scl) | !is.numeric(rate)) {
        rlang::abort(
            "The parameters of '.shape1', '.shape2', '.shape3', '.rate', and '.scale'
            must be of class numeric."
        )
    }

    if (shape1 <= 0 | shape2 <= 0 | shape3 <= 0 | scl <= 0 | rate <= 0){
        rlang::abort(
            "The parameters of '.shape1', '.shape2', '.shape3', '.rate', and '.scale'
            must be strictly positive."
        )
    }

    x <- seq(1, num_sims, 1)

    # ps <- seq(-n, n - 1, 2)
    qs <- seq(0, 1, (1 / (n - 1)))
    ps <- qs

    df <- dplyr::tibble(sim_number = as.factor(x)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = list(actuar::rgenbeta(n = n, shape1 = shape1,
                                                shape2 = shape2,
                                                shape3 = shape3,
                                                rate = rate, scale = scl))) %>%
        dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
                                   purrr::set_names("dx", "dy") %>%
                                   dplyr::as_tibble())) %>%
        dplyr::mutate(p = list(actuar::pgenbeta(ps, shape1 = shape1,
                                            shape2 = shape2,
                                            shape3 = shape3,
                                            rate = rate, scale = scl))) %>%
        dplyr::mutate(q = list(actuar::qgenbeta(qs, shape1 = shape1,
                                            shape2 = shape2,
                                            shape3 = shape3,
                                            rate = rate, scale = scl))) %>%
        tidyr::unnest(cols = c(x, y, d, p, q)) %>%
        dplyr::ungroup()

    param_grid <- dplyr::tibble(.shape1, .shape2, .shape3, .rate, .scale)

    # Attach descriptive attributes to tibble
    attr(df, "distribution_family_type") <- "continuous"
    attr(df, ".shape1") <- .shape1
    attr(df, ".shape2") <- .shape2
    attr(df, ".shape3") <- .shape3
    attr(df, ".rate") <- .rate
    attr(df, ".scale") <- .scale
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_generalized_beta"
    attr(df, "ps") <- ps
    attr(df, "qs") <- qs
    attr(df, "param_grid") <- param_grid
    attr(df, "param_grid_txt") <- paste0(
        "c(",
        paste(param_grid[, names(param_grid)], collapse = ", "),
        ")"
    )
    attr(df, "dist_with_params") <- paste0(
        "Generalized Beta",
        " ",
        paste0(
            "c(",
            paste(param_grid[, names(param_grid)], collapse = ", "),
            ")"
        )
    )

    # Return final result as function output
    return(df)
}
