#' Automatic Plot of Density Data
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
#' @param .data The data passed in from a tidy_`distribution` function like
#' `tidy_normal()`
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
#' tidy_normal(.num_sims = 5) %>%
#'   tidy_four_autoplot()
#'
#' @return
#' A ggplot or a plotly plot.
#'
#' @export
#'

tidy_four_autoplot <- function(.data, .line_size = .5,
                               .geom_point = FALSE, .point_size = 1,
                               .geom_rug = FALSE, .geom_smooth = FALSE,
                               .geom_jitter = FALSE, .interactive = FALSE){

    p1 <- tidy_autoplot(.data = .data, .plot_type = "density", .line_size = .line_size,
                        .geom_point = .geom_point, .geom_smooth = .geom_smooth,
                        .geom_jitter = .geom_jitter, .interactive = .interactive)

    subtitle <- p1$labels$subtitle

    p1 <- p1 + ggplot2::labs(subtitle = "")
    p2 <- tidy_autoplot(.data = .data, .plot_type = "probability", .line_size = .line_size,
                        .geom_point = .geom_point, .geom_smooth = .geom_smooth,
                        .geom_jitter = .geom_jitter, .interactive = .interactive) +
        ggplot2::labs(subtitle = "")
    p3 <- tidy_autoplot(.data = .data, .plot_type = "qq", .line_size = .line_size,
                        .geom_point = .geom_point, .geom_smooth = .geom_smooth,
                        .geom_jitter = .geom_jitter, .interactive = .interactive) +
        ggplot2::labs(subtitle = "")
    p4 <- tidy_autoplot(.data = .data, .plot_type = "quantile", .line_size = .line_size,
                        .geom_point = .geom_point, .geom_smooth = .geom_smooth,
                        .geom_jitter = .geom_jitter, .interactive = .interactive) +
        ggplot2::labs(subtitle = "")

    plt <- patchwork::wrap_plots(
        p1, p2, p3, p4, ncol = 2, guides = "auto"
    ) +
        ggplot2::guides(
            color = ggplot2::theme(legend.position = "bottom")
        ) +
        patchwork::plot_annotation(
            subtitle = subtitle
        )

    return(plt)

}
