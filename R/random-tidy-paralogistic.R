#' Tidy Randomly Generated Paralogistic Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Logistic
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Logistic_distribution}
#'
#' @details This function uses the underlying `actuar::rparalogis()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [actuar::rparalogis()]
#'
#' @description This function will generate `n` random points from a paralogistic
#' distribution with a user provided, `.shape`, `.rate`, `.scale` and number of
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
#' @param .shape Must be strictly positive.
#' @param .scale Must be strictly positive.
#' @param .rate An alternative way to specify the `.scale`
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_paralogistic()
#'
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_paralogistic <- function(.n = 50, .shape = 1, .rate = 1, .scale = 1/.rate,
                              .num_sims = 1) {

    # Tidyeval ----
    n <- as.integer(.n)
    num_sims <- as.integer(.num_sims)
    shape <- as.numeric(.shape)
    scale <- as.numeric(.scale)
    rate <- as.numeric(.rate)

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

    if (!is.numeric(shape) | !is.numeric(scale) | !is.numeric(rate)) {
        rlang::abort(
            "The parameters of shape, rate, and scale must be of class numeric and greater than 0."
        )
    }

    if (shape <= 0 | rate <= 0 | scale <= 0){
        rlang::abort(
            "The parameters of shape, rate, and scale must be strictly positive."
        )
    }

    x <- seq(1, num_sims, 1)

    # ps <- seq(-n, n - 1, 2)
    qs <- seq(0, 1, (1 / (n - 1)))
    ps <- qs

    df <- dplyr::tibble(sim_number = as.factor(x)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = list(actuar::rparalogis(n = n, shape = shape, rate = rate,
                                                 scale = scale))) %>%
        dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
                                   purrr::set_names("dx", "dy") %>%
                                   dplyr::as_tibble())) %>%
        dplyr::mutate(p = list(actuar::pparalogis(ps, shape = shape, rate = rate,
                                                  scale = scale))) %>%
        dplyr::mutate(q = list(actuar::qparalogis(tidy_scale_zero_one_vec(unlist(y)), shape = shape, rate = rate,
                                                  scale = scale))) %>%
        tidyr::unnest(cols = c(x, y, d, p, q)) %>%
        dplyr::ungroup()

    param_grid <- dplyr::tibble(.shape, .rate, .scale)

    # Attach descriptive attributes to tibble
    attr(df, "distribution_family_type") <- "continuous"
    attr(df, ".shape") <- .shape
    attr(df, ".rate") <- .rate
    attr(df, ".scale") <- .scale
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_paralogistic"
    attr(df, "ps") <- ps
    attr(df, "qs") <- qs
    attr(df, "param_grid") <- param_grid
    attr(df, "param_grid_txt") <- paste0(
        "c(",
        paste(param_grid[, names(param_grid)], collapse = ", "),
        ")"
    )
    attr(df, "dist_with_params") <- paste0(
        "Paralogistic",
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
