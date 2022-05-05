#' Automatic Plot of Combined Multi Dist Data
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
#' combined_tbl <- tidy_combine_distributions(
#'   tidy_normal(),
#'   tidy_gamma(),
#'   tidy_beta()
#' )
#'
#' combined_tbl
#'
#' combined_tbl %>%
#'   tidy_combined_autoplot()
#'
#' combined_tbl %>%
#'   tidy_combined_autoplot(.plot_type = "qq")
#'
#' @return
#' A ggplot or a plotly plot.
#'
#' @export
#'

tidy_combined_autoplot <- function(.data, .plot_type = "density", .line_size = .5,
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

    if (!atb$tibble_type == "tidy_multi_dist_combine") {
        rlang::abort(
            message = "The data passed must come from the
            `tidy_combine_distributions()` function.",
            use_cli_format = TRUE
        )
    }

    if (!is.numeric(.line_size) | !is.numeric(.point_size) | .line_size < 0 | .point_size < 0) {
        rlang::abort(
            message = "The parameters .line_size and .point_size must be numeric and
                     greater than 0.",
            use_cli_format = TRUE
        )
    }

    if (!plot_type %in% c("density", "quantile", "probability", "qq")) {
        rlang::abort(
            message = "You have chose an unsupported plot type.",
            use_cli_format = TRUE
        )
    }

    # Data ----
    data_tbl <- dplyr::as_tibble(.data)

    # Data for ggplot
    n <- max(data_tbl$x)
    sims <- max(as.numeric(data_tbl$sim_number))

    sub_title <- paste0(
        "Data Points: ", n, " - ",
        "Simulations: ", sims
    )

    # Plot logic ----
    leg_pos <- if (sims > 9) {
        "none"
    } else {
        "bottom"
    }

    if (plot_type == "density") {
        plt <- data_tbl %>%
            ggplot2::ggplot(
                ggplot2::aes(x = dx, y = dy,
                             group = interaction(dist_type, sim_number),
                             color = dist_type)
            ) +
            ggplot2::geom_line(size = line_size) +
            ggplot2::theme_minimal() +
            ggplot2::labs(
                title = "Density Plot",
                subtitle = sub_title,
                color = "Simulation"
            ) +
            ggplot2::theme(legend.position = leg_pos)
    } else if (plot_type == "quantile") {
        ## EDIT
        data_tbl <- data_tbl %>%
            dplyr::select(sim_number, dist_type, q) %>%
            dplyr::group_by(sim_number, dist_type) %>%
            dplyr::arrange(q) %>%
            dplyr::mutate(x = 1:dplyr::n() %>%
                              tidy_scale_zero_one_vec()) %>%
            dplyr::ungroup()
        ## End EDIT
        plt <- data_tbl %>%
            dplyr::filter(q > -Inf, q < Inf) %>%
            ggplot2::ggplot(
                ggplot2::aes(
                    #x = tidy_scale_zero_one_vec(dx),
                    x = x,
                    y = tidy_scale_zero_one_vec(q),
                    group = interaction(dist_type, sim_number),
                    color = dist_type
                )
            ) +
            ggplot2::geom_line(size = line_size) +
            ggplot2::theme_minimal() +
            ggplot2::labs(
                title = "Quantile Plot",
                subtitle = sub_title,
                x = "",
                y = "",
                color = "Simulation"
            ) +
            ggplot2::theme(legend.position = leg_pos)
    } else if (plot_type == "probability") {
        plt <- data_tbl %>%
            ggplot2::ggplot(
                ggplot2::aes(
                    x = y,
                    group = interaction(dist_type, sim_number),
                    color = dist_type
                )
            ) +
            ggplot2::stat_ecdf(size = line_size) +
            ggplot2::theme_minimal() +
            ggplot2::labs(
                title = "Probability Plot",
                subtitle = sub_title,
                color = "Simulation",
                x = "dx"
            ) +
            ggplot2::theme(legend.position = leg_pos)
    } else if (plot_type == "qq") {
        plt <- data_tbl %>%
            ggplot2::ggplot(
                ggplot2::aes(
                    sample = y,
                    group = interaction(dist_type, sim_number),
                    color = dist_type
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
    }

    if (.geom_rug) {
        plt <- plt +
            ggplot2::geom_rug()
    }

    if ((.geom_point) & (!plot_type == "qq")) {
        plt <- plt +
            ggplot2::geom_point(size = point_size)
    }

    if (.geom_smooth) {
        max_dy <- max(data_tbl$dy)

        plt <- plt +
            ggplot2::geom_smooth(
                ggplot2::aes(
                    group = dist_type
                ),
                se = FALSE,
                color = "black",
                linetype = "dashed"
            ) +
            ggplot2::ylim(0, max_dy)
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
