#' Tidy Randomly Generated Inverse Gaussian Distribution Tibble
#'
#' @family Continuous Distribution
#' @family Gaussian
#' @family Inverse Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function uses the underlying `actuar::rinvgauss()`. For
#' more information please see [rinvgauss()]
#'
#' @description This function will generate `n` random points from an Inverse Gaussian
#' distribution with a user provided, `.mean`, `.shape`, `.dispersion`The function
#' returns a tibble with the simulation number column the x column which corresponds
#' to the n randomly generated points.
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
#' @param .mean Must be strictly positive.
#' @param .shape Must be strictly positive.
#' @param .dispersion An alternative way to specify the `.shape`.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_inverse_normal()
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_inverse_normal <- function(.n = 50, .mean = 1, .shape = 1, .dispersion = 1/.shape,
                        .num_sims = 1) {

    # Tidyeval ----
    n <- as.integer(.n)
    num_sims <- as.integer(.num_sims)
    mu <- as.numeric(.mean)
    shape <- as.numeric(.shape)
    dispers <- as.numeric(.dispersion)

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

    if (!is.numeric(mu) | !is.numeric(shape) | !is.numeric(dispers)) {
        rlang::abort(
            "The parameters of '.mean', '.shape', and '.dispersion' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
        )
    }

    if (mu <= 0 | shape <= 0 | dispers <= 0){
        rlang::abort(
            "The parameters of '.mean', '.shape', and '.disperson' must be strictly
            positive."
        )
    }

    x <- seq(1, num_sims, 1)

    # ps <- seq(-n, n - 1, 2)
    qs <- seq(0, 1, (1 / (n - 1)))
    ps <- qs

    df <- dplyr::tibble(sim_number = as.factor(x)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = list(actuar::rinvgauss(n, mean = mu, shape = shape
                                                 , dispersion = dispers))) %>%
        dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
                                   purrr::set_names("dx", "dy") %>%
                                   dplyr::as_tibble())) %>%
        dplyr::mutate(p = list(actuar::pinvgauss(ps, mean = mu, shape = shape
                                            , dispersion = dispers))) %>%
        dplyr::mutate(q = list(actuar::qinvgauss(qs, mean = mu, shape = shape
                                            , dispersion = dispers))) %>%
        tidyr::unnest(cols = c(x, y, d, p, q)) %>%
        dplyr::ungroup()

    param_grid <- dplyr::tibble(.mean, .shape, .dispersion)

    # Attach descriptive attributes to tibble
    attr(df, ".mean") <- .mean
    attr(df, ".shape") <- .shape
    attr(df, ".dispersion") <- .dispersion
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_inverse_gaussian"
    attr(df, "ps") <- ps
    attr(df, "qs") <- qs
    attr(df, "param_grid") <- param_grid
    attr(df, "param_grid_txt") <- paste0(
        "c(",
        paste(param_grid[, names(param_grid)], collapse = ", "),
        ")"
    )
    attr(df, "dist_with_params") <- paste0(
        "Inverse Gaussian",
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
