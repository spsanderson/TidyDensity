#' Automatic Plot of Multi Dist Data
#'
#' @family Autoplot
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will spit out one of the following plots:
#' -  `density`
#' -  `quantile`
#' -  `probability`
#' -  `qq`
#'
#' @description This is an auto plotting function that will take in a `tidy_`
#' distribution function and a few arguments, one being the plot type, which is
#' a quoted string of one of the following:
#' -  `density`
#' -  `quantile`
#' -  `probablity`
#' -  `qq`
#'
#' If the number of simulations exceeds 9 then the legend will not print. The plot
#' subtitle is put together by the attributes of the table passed to the function.
#'
#' @param .data The data passed in from a the function `tidy_multi_dist()`
#' @param .plot_type This is a quoted string like 'density'
#' @param .line_size The size param ggplot
#' @param .geom_point A Boolean value of TREU/FALSE, FALSE is the default. TRUE
#' will return a plot with `ggplot2::ggeom_point()`
#' @param .point_size The point size param for ggplot
#' @param .geom_rug A Boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return the use of `ggplot2::geom_rug()`
#' @param .geom_smooth A Boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return the use of `ggplot2::geom_smooth()` The `aes` parameter of group is
#' set to FALSE. This ensures a single smoothing band returned with SE also set to
#' FALSE. Color is set to 'black' and `linetype` is 'dashed'.
#' @param .geom_jitter A Boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return the use of `ggplot2::geom_jitter()`
#' @param .interactive A Boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return an interactive `plotly` plot.
#'
#' @examples
#' tn <- tidy_multi_single_dist(
#'   .tidy_dist = "tidy_normal",
#'   .param_list = list(
#'     .n = 500,
#'     .mean = c(-2, 0, 2),
#'     .sd = 1,
#'     .num_sims = 5
#'   )
#' )
#'
#' tn %>%
#'   tidy_multi_dist_autoplot()
#'
#' tn %>%
#'   tidy_multi_dist_autoplot(.plot_type = "qq")
#'
#' @return
#' A ggplot or a plotly plot.
#'
#' @export
#'

tidy_multi_dist_autoplot <- function(.data, .plot_type = "density", .line_size = .5,
                                     .geom_point = FALSE, .point_size = 1,
                                     .geom_rug = FALSE, .geom_smooth = FALSE,
                                     .geom_jitter = FALSE, .interactive = FALSE) {

  # Plot type ----
  plot_type <- tolower(as.character(.plot_type))
  line_size <- as.numeric(.line_size)
  point_size <- as.numeric(.point_size)

  # Get the data attributes
  atb <- attributes(.data)
  ns <- atb$.param_list$.num_sims
  ps <- attributes(.data)$all$ps
  ps <- rep(ps, (ns * nrow(expand.grid(atb$.param_list))))
  qs <- attributes(.data)$all$qs
  qs <- rep(qs, (ns * nrow(expand.grid(atb$.param_list))))

  # Checks on data ---
  if (!is.data.frame(.data)) {
    rlang::abort("The .data parameter must be a valid data.frame from a `tidy_`
                     distribution function.  ")
  }

  if (!atb$tbl == "tidy_multi_tibble") {
    rlang::abort("The data passed must come from the `tidy_multi_dist()` function.")
  }

  if (!attributes(.data)$all$tibble_type %in% c(
    "tidy_gaussian", "tidy_poisson", "tidy_gamma", "tidy_beta", "tidy_f",
    "tidy_hypergeometric", "tidy_lognormal", "tidy_cauchy", "tidy_chisquare",
    "tidy_weibull", "tidy_uniform", "tidy_logistic", "tidy_exponential",
    "tidy_empirical", "tidy_binomial", "tidy_geometric", "tidy_negative_binomial",
    "tidy_zero_truncated_poisson", "tidy_zero_truncated_geometric",
    "tidy_zero_truncated_binomial", "tidy_zero_truncated_negative_binomial",
    "tidy_pareto_single_parameter", "tidy_pareto", "tidy_inverse_pareto",
    "tidy_generalized_pareto", "tidy_paralogistic", "tidy_inverse_exponential",
    "tidy_inverse_gamma", "tidy_inverse_weibull", "tidy_burr", "tidy_inverse_burr",
    "tidy_inverse_gaussian", "tidy_generalized_beta", "tidy_t","tidy_bernoulli"
  )) {
    rlang::abort("The data passed must come from a `tidy_` distribution function.")
  }

  if (!is.numeric(.line_size) | !is.numeric(.point_size) | .line_size < 0 | .point_size < 0) {
    rlang::abort("The parameters .line_size and .point_size must be numeric and
                     greater than 0.")
  }

  if (!plot_type %in% c("density", "quantile", "probability", "qq", "mcmc")) {
    rlang::abort("You have chose an unsupported plot type.")
  }

  # Get .data parameters from the tidy_ function to construct subtitle
  # for ggplot
  n <- atb$all$.n
  sims <- atb$.num_sims

  sub_title <- paste0(
    "Data Points: ", n, " - ",
    "Simulations: ", sims, "\n",
    "Parameters: ", if (atb$all$tibble_type == "tidy_gaussian") {
      paste0("Mean: ", toString(atb$.param_list$.mean), " - SD: ", toString(atb$.param_list$.sd))
    } else if (atb$all$tibble_type == "tidy_gamma") {
      paste0("Shape: ", toString(atb$.param_list$.shape), " - Scale: ", toString(atb$.param_list$.scale))
    } else if (atb$all$tibble_type == "tidy_beta") {
      paste0("Shape1: ", toString(atb$.param_list$.shape1), " - Shape2: ", toString(atb$.param_list$.shape2), " - NCP: ", toString(atb$.param_list$.ncp))
    } else if (atb$all$tibble_type %in% c("tidy_poisson", "tidy_zero_truncated_poisson")) {
      paste0("Lambda: ", toString(atb$.param_list$.lambda))
    } else if (atb$all$tibble_type == "tidy_f") {
      paste0("DF1: ", toString(atb$.param_list$.df1), " - DF2: ", toString(atb$.param_list$.df2), " - NCP: ", toString(atb$.param_list$.ncp))
    } else if (atb$all$tibble_type == "tidy_hypergeometric") {
      paste0("M: ", toString(atb$.param_list$.m), " - NN: ", toString(atb$.param_list$.nn), " - K: ", toString(atb$.param_list$.k))
    } else if (atb$all$tibble_type == "tidy_lognormal") {
      paste0("Mean Log: ", toString(atb$.param_list$.meanlog), " - SD Log: ", toString(atb$.param_list$.sdlog))
    } else if (atb$all$tibble_type == "tidy_cauchy") {
      paste0("Location: ", toString(atb$.param_list$.location), " - Scale: ", toString(atb$.param_list$.scale))
    } else if (atb$all$tibble_type %in% c("tidy_chisquare", "tidy_t")) {
      paste0("DF: ", toString(atb$.param_list$.df), " - NPC: ", toString(atb$.param_list$.ncp))
    } else if (atb$all$tibble_type == "tidy_weibull") {
      paste0("Shape: ", toString(atb$.param_list$.schape), " - Scale: ", toString(atb$.param_list$.scale))
    } else if (atb$all$tibble_type == "tidy_uniform") {
      paste0("Max: ", toString(atb$.param_list$.max), " - Min: ", toString(atb$.param_list$.min))
    } else if (atb$all$tibble_type == "tidy_logistic") {
      paste0("Location: ", toString(atb$.param_list$.location), " - Scale: ", toString(atb$.param_list$.scale))
    } else if (atb$all$tibble_type == "tidy_exponential") {
      paste0("Rate: ", toString(atb$.param_list$.rate))
    } else if (atb$all$tibble_type == "tidy_empirical") {
      paste0("Empirical - No params")
    } else if (atb$all$tibble_type %in% c(
      "tidy_binomial", "tidy_negative_binomial",
      "tidy_zero_truncated_binomial",
      "tidy_zero_truncated_negative_binomial"
    )) {
      paste0("Size: ", toString(atb$.param_list$.size), " - Prob: ", toString(atb$.param_list$.prob))
    } else if (atb$all$tibble_type %in% c("tidy_geometric", "tidy_zero_truncated_geometric",
                                          "tidy_bernoulli")) {
      paste0("Prob: ", toString(atb$.param_list$.prob))
    } else if (atb$all$tibble_type %in% c("tidy_pareto_single_parameter")) {
      paste0("Shape: ", toString(atb$.param_list$.shape), " - Min: ", toString(atb$.param_list$.min))
    } else if (atb$all$tibble_type %in% c("tidy_pareto", "tidy_inverse_pareto")) {
      paste0("Shape: ", toString(atb$.param_list$.shape), " - Scale: ", toString(atb$.param_list$.scale))
    } else if (atb$all$tibble_type %in% c(
      "tidy_generalized_pareto",
      "tidy_burr", "tidy_inverse_burr"
    )) {
      paste0(
        "Shape1: ", toString(atb$.param_list$.shape1), " - ",
        "Shape2: ", toString(atb$.param_list$.shape2), " - ",
        "Rate: ", toString(atb$.param_list$.rate), " - ",
        "Scale: ", toString(atb$.param_list$.scale)
      )
    } else if (atb$all$tibble_type %in% c(
      "tidy_paralogistic",
      "tidy_inverse_gamma",
      "tidy_inverse_weibull"
    )
    ) {
      paste0(
        "Shape: ", toString(atb$.param_list$.shape), " - ",
        "Rate: ", toString(atb$.param_list$.rate), " - ",
        "Scale: ", toString(atb$.param_list$.scale)
      )
    } else if (atb$all$tibble_type == "tidy_inverse_exponential") {
      paste0("Rate: ", toString(atb$.param_list$.rate), " - Scale: ", toString(atb$.param_list$.scale))
    } else if (atb$all$tibble_type == "tidy_inverse_gaussian") {
      paste0(
        "Mean: ", toString(atb$.param_list$.mean), " - ",
        "Shape: ", toString(atb$.param_list$.shape), " - ",
        "Dispersion: ", toString(atb$.param_list$.dispersion)
      )
    } else if (atb$all$tibble_type == "tidy_generalized_beta") {
      paste0(
        "Shape1: ", toString(atb$.param_list$.shape1), " - ",
        "Shape2: ", toString(atb$.param_list$.shape2), " - ",
        "Shape3: ", toString(atb$.param_list$.shape3), " - ",
        "Scale: ", toString(atb$.param_list$.scale), " - ",
        "Rate: ", toString(atb$.param_list$.rate)
      )
    }
  )

  # Data ----
  data_tbl <- dplyr::as_tibble(.data)

  # Plot logic ----
  leg_pos <- if (atb$all$tibble_type == "tidy_empirical") {
    "none"
  } else if (sims > 9) {
    "none"
  } else {
    "bottom"
  }

  if (plot_type == "density" & atb$all$distribution_family_type == "continuous") {
    plt <- data_tbl %>%
      ggplot2::ggplot(
        ggplot2::aes(x = dx, y = dy, group = interaction(dist_name, sim_number), color = dist_name)
      ) +
      ggplot2::geom_line(size = line_size) +
      ggplot2::theme_minimal() +
      ggplot2::labs(
        title = "Density Plot",
        subtitle = sub_title,
        color = "Simulation"
      ) +
      ggplot2::theme(legend.position = leg_pos)
  } else if (plot_type == "density" & atb$all$distribution_family_type == "discrete") {
    plt <- data_tbl %>%
      ggplot2::ggplot(
        ggplot2::aes(x = y, group = interaction(dist_name, sim_number), fill = dist_name)
      ) +
      ggplot2::geom_histogram(
        alpha = 0.318, color = "#e9ecef", bins = max(unique(data_tbl$y)) + 1,
        position = "identity"
      ) +
      ggplot2::theme_minimal() +
      ggplot2::labs(
        title = "Histogram Plot",
        subtitle = sub_title,
        fill = "Simulation"
      ) +
      ggplot2::theme(legend.position = leg_pos)
  } else if (plot_type == "quantile") {
    ## EDIT
    data_tbl <- data_tbl %>%
      dplyr::select(sim_number, q) %>%
      dplyr::group_by(sim_number) %>%
      dplyr::arrange(q) %>%
      dplyr::mutate(x = 1:dplyr::n()) %>%
      dplyr::ungroup()
    ## End EDIT
    plt <- data_tbl %>%
      ggplot2::ggplot(
        ggplot2::aes(
          x = x, y = q, group = interaction(dist_name, sim_number), color = dist_name
        )
      ) +
      ggplot2::geom_line(size = line_size) +
      ggplot2::theme_minimal() +
      ggplot2::labs(
        title = "Quantile Plot",
        subtitle = sub_title,
        color = "Simulation"
      ) +
      ggplot2::theme(legend.position = leg_pos)
  } else if (plot_type == "probability") {
    plt <- data_tbl %>%
      ggplot2::ggplot(
        ggplot2::aes(
          x = y, group = interaction(dist_name, sim_number), color = dist_name
        )
      ) +
      ggplot2::stat_ecdf(size = line_size) +
      ggplot2::theme_minimal() +
      ggplot2::labs(
        title = "Probability Plot",
        subtitle = sub_title,
        color = "Simulation"
      ) +
      ggplot2::theme(legend.position = leg_pos)
  } else if (plot_type == "qq") {
    plt <- data_tbl %>%
      ggplot2::ggplot(
        ggplot2::aes(
          sample = y, group = interaction(dist_name, sim_number), color = dist_name
        )
      ) +
      ggplot2::stat_qq(size = point_size) +
      ggplot2::stat_qq_line(size = line_size) +
      ggplot2::theme_minimal() +
      ggplot2::labs(
        title = "QQ Plot",
        subtitle = sub_title,
        color = "Simulation"
      ) +
      ggplot2::theme(legend.position = leg_pos)
  } else if (plot_type == "mcmc") {
    plt <- data_tbl %>%
      dplyr::group_by(sim_number) %>%
      dplyr::mutate(cmy = dplyr::cummean(y)) %>%
      dplyr::ungroup() %>%
      ggplot2::ggplot(ggplot2::aes(
        x = x, y = cmy, group = sim_number, color = sim_number
      )) +
      ggplot2::geom_line() +
      ggplot2::theme_minimal() +
      ggplot2::scale_x_continuous(trans = "log10") +
      ggplot2::labs(
        title = "MCMC Cumulative Mean Plot",
        caption = "X is on log10 scale.",
        subtitle = sub_title,
        color = "Simulation",
        x = "",
        y = ""
      ) +
      ggplot2::theme(legend.position = leg_pos)
  }

  if (.geom_rug) {
    plt <- plt +
      ggplot2::geom_rug()
  }

  if ((.geom_point) & (!plot_type == "qq")) {
    plt <- plt +
      ggplot2::geom_point(size = point_size)
  }

  if (.geom_smooth & !plot_type == "mcmc") {
    max_dy <- max(data_tbl$dy)

    plt <- plt +
      ggplot2::geom_smooth(
        ggplot2::aes(
          group = FALSE
        ),
        se = FALSE,
        color = "black",
        linetype = "dashed"
      ) +
      ggplot2::ylim(0, max_dy)
  } else if (.geom_smooth & plot_type == "mcmc") {
    plt <- plt +
      ggplot2::geom_smooth(
        ggplot2::aes(
          group = FALSE
        ),
        se = FALSE,
        color = "black",
        linetype = "dashed"
      )
  }

  if (.geom_jitter) {
    plt <- plt +
      ggplot2::geom_jitter()
  }

  if (.interactive) {
    plt <- plotly::ggplotly(plt)
  }

  # Return ----
  return(plt)
}
