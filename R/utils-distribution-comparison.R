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
#' -  tidy_normal
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
#' The function itself returns a list output of tibbles. Here are the tibbles that
#' are returned:
#' -  comparison_tbl
#' -  deviance_tbl
#' -  total_deviance_tbl
#' -  aic_tbl
#' -  kolmogorov_smirnov_tbl
#' -  multi_metric_tbl
#'
#' The `comparison_tbl` is a long `tibble` that lists the values of the `density`
#' function against the given data.
#'
#' The `deviance_tbl` and the `total_deviance_tbl` just give the simple difference
#' from the actual density to the estimated density for the given estimated distribution.
#'
#' The `aic_tbl` will provide the `AIC` for a `lm` model of the estimated density
#' against the emprical density.
#'
#' The `kolmogorov_smirnov_tbl` for now provides a `two.sided` estimate of the
#' `ks.test` of the estimated density against the empirical.
#'
#' The `multi_metric_tbl` will summarise all of these metrics into a single tibble.
#'
#'
#' @description Compare some empirical data set against different distributions
#' to help find the distribution that could be the best fit.
#'
#' @param .x The data set being passed to the function
#' @param .distribution_type What kind of data is it, can be one of `continuous`
#' or `discrete`
#' @param .round_to_place How many decimal places should the parameter estimates
#' be rounded off to for distibution construction. The default is 3
#'
#' @examples
#' xc <- mtcars$mpg
#' output_c <- tidy_distribution_comparison(xc, "continuous")
#'
#' xd <- trunc(xc)
#' output_d <- tidy_distribution_comparison(xd, "discrete")
#'
#' output_c
#'
#' @return
#' An invisible list object. A tibble is printed.
#'
#' @export
#'

tidy_distribution_comparison <- function(.x, .distribution_type = "continuous",
                                         .round_to_place = 3) {

    # Tidyeval ----
    x_term <- as.numeric(.x)
    n <- length(x_term)
    dist_type <- tolower(as.character(.distribution_type))
    rt <- as.numeric(.round_to_place)

    if (!dist_type %in% c("continuous", "discrete")) {
        rlang::abort(
            message = "The '.distribution_type' parameter must be either 'continuous'
      or 'discrete'.",
      use_cli_format = TRUE
        )
    }

    # Get parameter estimates for distributions
    if (dist_type == "continuous") {
        b <- try(util_beta_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::filter(method == "NIST_MME") %>%
                     dplyr::select(dist_type, shape1, shape2) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(b, "try-error")) {
            tb <- tidy_beta(.n = n, .shape1 = round(b[[2]], rt), .shape2 = round(b[[3]], rt))
        }

        c <- try(util_cauchy_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::select(dist_type, location, scale) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(c, "try-error")) {
            tc <- tidy_cauchy(.n = n, .location = round(c[[2]], rt), .scale = round(c[[3]], rt))
        }

        e <- try(util_exponential_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::select(dist_type, rate) %>%
                     dplyr::mutate(param_2 = NA) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(e, "try-error")) {
            te <- tidy_exponential(.n = n, .rate = round(e[[2]], rt))
        }

        g <- try(util_gamma_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::filter(method == "NIST_MME") %>%
                     dplyr::select(dist_type, shape, scale) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(g, "try-error")) {
            tg <- tidy_gamma(.n = n, .shape = round(g[[2]], rt), .scale = round(g[[3]], rt))
        }

        l <- try(util_logistic_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::filter(method == "EnvStats_MME") %>%
                     dplyr::select(dist_type, location, scale) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(l, "try-error")) {
            tl <- tidy_logistic(.n = n, .location = round(l[[2]], rt), .scale = round(l[[3]], rt))
        }

        ln <- try(util_lognormal_param_estimate(x_term)$parameter_tbl %>%
                      dplyr::filter(method == "EnvStats_MME") %>%
                      dplyr::select(dist_type, mean_log, sd_log) %>%
                      purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(ln, "try-error")) {
            tln <- tidy_lognormal(.n = n, .meanlog = round(ln[[2]], rt), .sdlog = round(ln[[3]], rt))
        }

        p <- try(util_pareto_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::filter(method == "MLE") %>%
                     dplyr::select(dist_type, shape, scale) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(p, "try-error")) {
            tp <- tidy_pareto(.n = n, .shape = round(p[[2]], rt), .scale = round(p[[3]], rt))
        }

        u <- try(util_uniform_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::filter(method == "NIST_MME") %>%
                     dplyr::select(dist_type, min_est, max_est) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(u, "try-error")) {
            tu <- tidy_uniform(.n = n, .min = round(u[[2]], rt), .max = round(u[[3]], rt))
        }

        w <- try(util_weibull_param_estimate(x_term)$parameter_tbl %>%
                     dplyr::select(dist_type, shape, scale) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(w, "try-error")) {
            tw <- tidy_weibull(.n = n, .shape = round(w[[2]], rt), .scale = round(w[[3]], rt))
        }

        nn <- try(util_normal_param_estimate(x_term)$parameter_tbl %>%
                      dplyr::filter(method == "EnvStats_MME_MLE") %>%
                      dplyr::select(dist_type, mu, stan_dev) %>%
                      purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(n, "try-error")) {
            tn <- tidy_normal(.n = n, .mean = round(nn[[2]], rt), .sd = round(nn[[3]], rt))
        }

        comp_tbl <- tidy_combine_distributions(
            tidy_empirical(x_term, .distribution_type = dist_type),
            if (exists("tb") && nrow(tb) > 0) {
                tb
            },
            if (exists("tc") && nrow(tc) > 0) {
                tc
            },
            if (exists("te") && nrow(te) > 0) {
                te
            },
            if (exists("tg") && nrow(tg) > 0) {
                tg
            },
            if (exists("tl") && nrow(tl) > 0) {
                tl
            },
            if (exists("tln") && nrow(tln) > 0) {
                tln
            },
            if (exists("tp") && nrow(tp) > 0) {
                tp
            },
            if (exists("tu") && nrow(tu) > 0) {
                tu
            },
            if (exists("tw") && nrow(tw) > 0) {
                tw
            },
            if (exists("tn") && nrow(tn) > 0) {
                tn
            }
        )
    } else {
        bn <- try(util_binomial_param_estimate(trunc(tidy_scale_zero_one_vec(x_term)))$parameter_tbl %>%
                      dplyr::select(dist_type, size, prob) %>%
                      purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(bn, "try-error")) {
            tb <- tidy_binomial(.n = n, .size = round(bn[[2]], rt), .prob = round(bn[[3]], rt))
        }

        ge <- try(util_geometric_param_estimate(trunc(x_term))$parameter_tbl %>%
                      dplyr::filter(method == "EnvStats_MME") %>%
                      dplyr::select(dist_type, shape) %>%
                      dplyr::mutate(param_2 = NA) %>%
                      purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(ge, "try-error")) {
            tg <- tidy_geometric(.n = n, .prob = round(ge[[2]], rt))
        }

        h <- try(util_hypergeometric_param_estimate(.x = trunc(x_term), .total = n, .k = n)$parameter_tbl %>%
                     tidyr::drop_na() %>%
                     dplyr::slice(1) %>%
                     dplyr::select(dist_type, m, total) %>%
                     purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(h, "try-error")) {
            th <- tidy_hypergeometric(
                .n = n,
                .m = trunc(h[[2]]),
                .nn = n - trunc(h[[2]]),
                .k = trunc(h[[2]])
            )
        }

        po <- try(util_poisson_param_estimate(trunc(x_term))$parameter_tbl %>%
                      dplyr::select(dist_type, lambda) %>%
                      dplyr::mutate(param_2 = NA) %>%
                      purrr::set_names("dist_type", "param_1", "param_2"))

        if (!inherits(po, "try-error")) {
            tp <- tidy_poisson(.n = n, .lambda = round(po[[2]], rt))
        }

        comp_tbl <- tidy_combine_distributions(
            tidy_empirical(.x = x_term, .distribution_type = dist_type),
            if (exists("tb") && nrow(tb) > 0) {
                tb
            },
            if (exists("tg") && nrow(tg) > 0) {
                tg
            },
            if (exists("th") && nrow(th) > 0) {
                th
            },
            if (exists("tp") && nrow(tp) > 0) {
                tp
            }
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
        ) %>%
        dplyr::select(-x)

    total_deviance_tbl <- deviance_tbl %>%
        dplyr::filter(!name == "Empirical") %>%
        dplyr::group_by(name) %>%
        dplyr::summarise(total_deviance = sum(value)) %>%
        dplyr::ungroup() %>%
        dplyr::mutate(total_deviance = abs(total_deviance)) %>%
        dplyr::arrange(abs(total_deviance)) %>%
        dplyr::rename(
            dist_with_params = name,
            abs_tot_deviance = total_deviance
        )

    # AIC Data ----
    emp_data_tbl <- comp_tbl %>%
        dplyr::select(dist_type, x, dy) %>%
        dplyr::filter(dist_type == "Empirical")

    aic_tbl <- comp_tbl %>%
        dplyr::filter(!dist_type == "Empirical") %>%
        dplyr::select(dist_type, dy) %>%
        tidyr::nest(data = dy) %>%
        dplyr::mutate(
            lm_model = purrr::map(
                data,
                function(df) stats::lm(dy ~ emp_data_tbl$dy, data = df)
            )
        ) %>%
        dplyr::mutate(aic_value = purrr::map(lm_model, stats::AIC)) %>%
        dplyr::mutate(aic_value = unlist(aic_value)) %>%
        dplyr::mutate(abs_aic = abs(aic_value)) %>%
        dplyr::arrange(abs_aic) %>%
        dplyr::select(dist_type, aic_value, abs_aic)

    ks_tbl <- comp_tbl %>%
        dplyr::filter(dist_type != "Empirical") %>%
        dplyr::select(dist_type, dy) %>%
        tidyr::nest(data = dy) %>%
        dplyr::mutate(
            ks = purrr::map(
                .x = data,
                .f = ~ ks.test(
                    x = .x$dy,
                    y = emp_data_tbl$dy,
                    alternative = "two.sided",
                    simulate.p.value = TRUE
                )
            ),
            tidy_ks = purrr::map(ks, broom::tidy)
        ) %>%
        tidyr::unnest(cols = tidy_ks) %>%
        dplyr::select(-c(data, ks)) %>%
        dplyr::mutate(dist_char = as.character(dist_type)) %>%
        purrr::set_names(
            "dist_type", "ks_statistic", "ks_pvalue", "ks_method", "alternative",
            "dist_char"
        )

    multi_metric_tbl <- total_deviance_tbl %>%
        dplyr::mutate(dist_with_params = as.factor(dist_with_params)) %>%
        dplyr::inner_join(aic_tbl, by = c("dist_with_params" = "dist_type")) %>%
        dplyr::inner_join(ks_tbl, by = c("dist_with_params" = "dist_char")) %>%
        dplyr::select(dist_type, dplyr::everything(), -dist_with_params) %>%
        dplyr::mutate(dist_type = as.factor(dist_type))

    # Return ----
    output <- list(
        comparison_tbl         = comp_tbl,
        deviance_tbl           = deviance_tbl,
        total_deviance_tbl     = total_deviance_tbl,
        aic_tbl                = aic_tbl,
        kolmogorov_smirnov_tbl = ks_tbl,
        multi_metric_tbl       = multi_metric_tbl
    )

    # Attributes ----
    attr(deviance_tbl, ".tibble_type") <- "deviance_comparison_tbl"
    attr(total_deviance_tbl, ".tibble_type") <- "deviance_results_tbl"
    attr(aic_tbl, ".tibble_type") <- "aic_tbl"
    attr(comp_tbl, ".tibble_type") <- "comparison_tbl"
    attr(ks_tbl, ".tibble_type") <- "kolmogorov_smirnov_tbl"
    attr(multi_metric_tbl, ".tibble_type") <- "full_metric_tbl"
    attr(output, ".x") <- x_term
    attr(output, ".n") <- n

    # Return ----
    return(invisible(output))
}
