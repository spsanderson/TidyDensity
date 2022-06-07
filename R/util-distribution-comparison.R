#' Compare Empirical Data to Distributions
#'
#' @family Empirical
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details The purpose of this function is to take some data set provided and
#' to try to find a distribution that may fit the best. A parameter of
#' `.distribution_type` must be set to either `continuous` or `discrete` in order
#' for this the function to try the appropriate types of distributions.
#'
#' The following distributions are used:
#'
#' Continuous:
#' -  tidy_beta
#' -  tidy_cauchy
#' -  tidy_exponential
#' -  tidy_gamma
#' -  tidy_logistic
#' -  tidy_lognormal
#' -  tidy_pareto
#' -  tidy_uniform
#' -  tidy_weibull
#'
#' Discrete:
#' -  tidy_binomial
#' -  tidy_geometric
#' -  tidy_hypergeometric
#' -  tidy_poisson
#'
#'
#' @description Compare some empirical data set against different distributions
#' to help find the distribution that could be the best fit.
#'
#' @param .x The data set being passed to the function
#' @param .distribution_type What kind of data is it, can be one of `continuous`
#' or `discrete`
#'
#' @examples
#' xc <- mtcars$mpg
#' tidy_distribution_comparison(xc, "continuous")
#'
#' xd <- trunc(xc)
#' tidy_distribution_comparison(xd, "discrete")
#'
#' @return
#' An invisible list object. A tibble is printed.
#'
#' @export
#'

tidy_distribution_comparison <- function(.x, .distribution_type = "continuous"){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    n <- length(x_term)
    dist_type <- tolower(as.character(.distribution_type))

    if (!dist_type %in% c("continuous","discrete")){
        rlang::abort(
            message = "The '.distribution_type' parameter must be either 'continuous'
      or 'discrete'.",
      use_cli_format = TRUE
        )
    }

    # Get parameter estimates for distributions
    if (dist_type == "continuous"){
        b <- util_beta_param_estimate(x_term)$parameter_tbl %>%
            dplyr::filter(method == "NIST_MME") %>%
            dplyr::select(dist_type, shape1, shape2) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        c <- util_cauchy_param_estimate(x_term)$parameter_tbl %>%
            dplyr::select(dist_type, location, scale) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        e <- util_exponential_param_estimate(x_term)$parameter_tbl %>%
            dplyr::select(dist_type, rate) %>%
            dplyr::mutate(param_2 = NA) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        g <- util_gamma_param_estimate(x_term)$parameter_tbl %>%
            dplyr::filter(method == "NIST_MME") %>%
            dplyr::select(dist_type, shape, scale) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        l <- util_logistic_param_estimate(x_term)$parameter_tbl %>%
            dplyr::filter(method == "EnvStats_MME") %>%
            dplyr::select(dist_type, location, scale) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        ln <- util_lognormal_param_estimate(x_term)$parameter_tbl %>%
            dplyr::filter(method == "EnvStats_MME") %>%
            dplyr::select(dist_type, mean_log, sd_log) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        p <- util_pareto_param_estimate(x_term)$parameter_tbl %>%
            dplyr::filter(method == "MLE") %>%
            dplyr::select(dist_type, shape, scale) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        u <- util_uniform_param_estimate(x_term)$parameter_tbl %>%
            dplyr::filter(method == "NIST_MME") %>%
            dplyr::select(dist_type, min_est, max_est) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        w <- util_weibull_param_estimate(x_term)$parameter_tbl %>%
            dplyr::select(dist_type, shape, scale) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        comp_tbl <- tidy_combine_distributions(
            tidy_empirical(x_term, .distribution_type = dist_type),
            tidy_beta(.n = n, .shape1 = round(b[[2]], 2), .shape2 = round(b[[3]], 2)),
            tidy_cauchy(.n = n, .location = round(c[[2]], 2), .scale = round(c[[3]], 2)),
            tidy_exponential(.n = n, .rate = round(e[[2]], 2)),
            tidy_gamma(.n = n, .shape = round(g[[2]], 2),  .scale = round(g[[3]], 2)),
            tidy_logistic(.n = n, .location = round(l[[2]], 2), .scale = round(l[[3]], 2)),
            tidy_lognormal(.n = n, .meanlog = round(ln[[2]], 2), .sdlog = round(ln[[3]], 2)),
            tidy_pareto(.n = n, .shape = round(p[[2]], 2), .scale = round(p[[3]], 2)),
            tidy_uniform(.n = n, .min = round(u[[2]], 2), .max = round(u[[3]], 2)),
            tidy_weibull(.n = n, .shape = round(w[[2]], 2), .scale = round(w[[3]], 2))
        )

    } else {
        bn <- util_binomial_param_estimate(trunc(tidy_scale_zero_one_vec(x_term)))$parameter_tbl %>%
            dplyr::select(dist_type, size, prob) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        ge <- util_geometric_param_estimate(x_term)$parameter_tbl %>%
            dplyr::filter(method == "EnvStats_MME") %>%
            dplyr::select(dist_type, shape) %>%
            dplyr::mutate(param_2 = NA) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        h <- util_hypergeometric_param_estimate(.x = x_term, .total = n, .k = n)$parameter_tbl %>%
            tidyr::drop_na() %>%
            dplyr::slice(1) %>%
            dplyr::select(dist_type, m, total) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        po <- util_poisson_param_estimate(x_term)$parameter_tbl %>%
            dplyr::select(dist_type, lambda) %>%
            dplyr::mutate(param_2 = NA) %>%
            purrr::set_names("dist_type", "param_1", "param_2")

        comp_tbl <- tidy_combine_distributions(
            tidy_empirical(.x = x_term, .distribution_type = dist_type),
            tidy_binomial(.n = n, .size = round(bn[[2]], 2), .prob = round(bn[[3]], 2)),
            tidy_geometric(.n = n, .prob = round(ge[[2]], 2)),
            tidy_hypergeometric(
                .n = n,
                .m = trunc(h[[2]]),
                .nn = n - trunc(h[[2]]),
                .k = trunc(h[[2]])
            ),
            tidy_poisson(.n = n, .lambda = round(po[[2]], 2))
        )

    }

    # Deviance calculations ----
    deviance_tbl <- comp_tbl %>%
        dplyr::select(dist_type, x, y) %>%
        dplyr::group_by(dist_type, x) %>%
        dplyr::mutate(y = stats::median(y)) %>%
        dplyr::ungroup() %>%
        dplyr::group_by(dist_type) %>%
        dplyr::mutate(y = tidy_scale_zero_one_vec(y)) %>%
        dplyr::ungroup() %>%
        tidyr::pivot_wider(
            id_cols = x,
            names_from = dist_type,
            values_from = y
        ) %>%
        dplyr::select(x, Empirical, dplyr::everything()) %>%
        dplyr::mutate(
            dplyr::across(
                .cols = -c(x, Empirical),
                .fns = ~ Empirical - .
            )
        ) %>%
        tidyr::drop_na() %>%
        tidyr::pivot_longer(
            cols = -x
        )

    total_deviance_tbl <- deviance_tbl %>%
        dplyr::filter(!name == "Empirical") %>%
        dplyr::group_by(name) %>%
        dplyr::summarise(total_deviance = sum(value)) %>%
        dplyr::ungroup() %>%
        dplyr::mutate(total_deviance = abs(total_deviance)) %>%
        dplyr::arrange(abs(total_deviance)) %>%
        dplyr::rename(dist_with_params = name,
                      abs_tot_deviance = total_deviance)

    # Return ----
    attr(deviance_tbl, ".tibble_type") <- "deviance_comparison_tbl"
    attr(total_deviance_tbl, ".tibble_type") <- "deviance_results_tbl"

    output <- list(
        comparison_tbl     = comp_tbl,
        deviance_tbl       = deviance_tbl,
        total_deviance_tbl = total_deviance_tbl
    )

    print(total_deviance_tbl)

    return(invisible(output))

}
