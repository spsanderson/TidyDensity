#' Triangle Distribution PDF Plot
#'
#' @family Visualization
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description This function generates a probability density function (PDF) plot for the triangular distribution.
# It takes tidy data from the `tidy_triangular` function as input and produces a plot using ggplot2.
#'
#' @details
#' The function checks if the input data is a data frame or tibble, and if it comes from the `tidy_triangular`
#' function. It then extracts necessary attributes for the plot and creates a PDF plot using ggplot2. The plot
#' includes data points and segments to represent the triangular distribution.
#'
#' @param .data Tidy data from the `tidy_triangular` function.
#' @param .interactive A logical value indicating whether to return an interactive plot using plotly. Default is FALSE.
#'
#' @examples
#' # Example: Generating a PDF plot for the triangular distribution
#' data <- tidy_triangular(.n = 50, .min = 0, .max = 1, .mode = 1/2, .num_sims = 1,
#' .return_tibble = TRUE)
#' triangle_plot(data)
#'
#' @return
#' The function returns a ggplot2 object representing the probability density function plot for the triangular distribution.
# If .interactive is set to TRUE, it returns an interactive plot using plotly.
#'
#' @name triangle_plot
NULL

#' @export
#' @rdname triangle_plot

triangle_plot <- function(.data, .interactive = FALSE){

    # Data Check
    if (!is.data.frame(.data)){
        rlang::abort(
            message = ".data must be a data.frame/tibble.",
            use_cli_format = TRUE
        )
    }

    # Data
    df <- .data

    # Attributes
    atb <- attributes(df)

    # Attribute check
    if (!"tibble_type" %in% names(atb)){
        rlang::abort(
            message = ".data must come from a tidy_ distribution function.",
            use_cli_format = TRUE
        )
    }

    if (atb$tibble_type != "tidy_triangular"){
        rlang::abort(
            message = ".data must come from the tidy_triangular() function.",
            use_cli_format = TRUE
        )
    }

    # Gather Attributes for plot
    sims <- atb$.num_sims
    n <- atb$.n
    mn <- round(atb$param_grid$mn, 4)
    mx <- round(atb$param_grid$mx, 4)
    md <- round(atb$param_grid$md, 4)

    # Points to make plot
    points <- atb$param_grid
    points_df <- data.frame(
        x = c(mn, md, mx),
        #y = c(mn, 2/(mx - mn), mn)
        y = c(0, 2/(mx - mn), 0)
    )

    # Sub Title
    sub_title <- base::paste0(
        "Data Points: ", n, " - ",
        "Simulations: ", sims, "\n",
        "Distribution Family: Tirangular \n",
        "Parameters: ", base::paste0(
            "Min: ", mn, " - ", "Max: ", mx, " - ", "Mode: ", md
        )
    )

    # Plot
    plt <- points_df |>
        ggplot2::ggplot(ggplot2::aes(x = x, y = y)) +
        ggplot2::geom_point() +
        ggplot2::geom_point(ggplot2::aes(
            x = x[2],
            y = y[1]
        )) +
        ggplot2::geom_segment(ggplot2::aes(
            x = x[1],
            y = y[1],
            xend = x[2],
            yend = y[2]
        )) +
        ggplot2::geom_segment(ggplot2::aes(
            x = x[2],
            y = y[2],
            xend = x[3],
            yend = y[3]
        )) +
        ggplot2::geom_segment(ggplot2::aes(
            x = x[1],
            y = y[1],
            xend = x[3],
            yend = y[3]
        )) +
        ggplot2::geom_segment(ggplot2::aes(
            x = x[2],
            y = y[2],
            xend = x[2],
            yend = y[1]
        ),
        linetype = "dashed") +
        ggplot2::geom_segment(ggplot2::aes(
            x = x[1],
            y = y[2],
            xend = x[2],
            yend = y[2]
        ),
        linetype = "dashed") +
        ggplot2::labs(
            x = "",
            y = "",
            title = "Triangle PDF Plot",
            subtitle = sub_title
        ) +
        ggplot2::theme_minimal()

    # Return
    if (.interactive){
        plt <- plotly::ggplotly(plt)
    }

    return(plt)
}
