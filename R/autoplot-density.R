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
#' @description This is an autoplotting function that will take in a `tidy_`
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
#' @param .plot_type This is a quoted string like 'density'
#' @param .line_size The size param ggplot
#' @param .point_size The line size param for ggplot
#' @param .interactive A boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return an interactive plotly plot.
#'
#' @examples
#' tn <- tidy_normal(.num_sims = 5)
#' tidy_autoplot(tn, .plot_type = "density", .point_size = .1)
#'
#' @return
#' A ggplot or a plotly plot.
#'
#' @export
#'

tidy_autoplot <- function(.data, .plot_type = "density", .line_size = .5, .point_size = .5,
                          .interactive = FALSE){

    # Plot type ----
    plot_type <- tolower(as.character(.plot_type))
    line_size <- as.numeric(.line_size)
    point_size <- as.numeric(.point_size)

    # Get the data attributes
    atb <- attributes(.data)
    ns <- atb$.num_sims
    ps <- attributes(.data)$ps
    ps <- rep(ps, ns)
    qs <- attributes(.data)$qs
    qs <- rep(qs, ns)

    # Checks on data ---
    if(!is.data.frame(.data)){
        rlang::abort("The .data parameter must be a valid data.frame from a `tidy_`
                     distribution function.  ")
    }

    if(!"tibble_type" %in% names(atb)){
        rlang::abort("The data passed must come from a `tidy_` distribution function.")
    }

    if(!attributes(.data)$tibble_type %in% c(
        "tidy_gaussian", "tidy_poisson","tidy_gamma","tidy_beta","tidy_f",
        "tidy_hypergeometric","tidy_lognormal","tidy_cauchy","tidy_chisquare",
        "tidy_weibull","tidy_uniform","tidy_logistic","tidy_exponential",
        "tidy_empirical"
    )){
        rlang::abort("The data passed must come from a `tidy_` distribution function.")
    }

    if(!is.numeric(.line_size) | !is.numeric(.point_size) | .line_size < 0 | .point_size < 0){
        rlang::abort("The parameters .line_size and .point_size must be numeric and
                     greater than 0.")
    }

    if(!plot_type %in% c("density","quantile","probability","qq")){
        rlang::abort("You have chose an unsupported plot type.")
    }

    # Get .data parameters from the tidy_ function to construct subtitle
    # for ggplot
    n <- atb$.n
    sims <- atb$.num_sims
    dist_type <- stringr::str_remove(atb$tibble_type, "tidy_") %>%
        stringr::str_to_title()

    sub_title <- paste0(
        "Data Points: ", n," - ",
        "Simulations: ", sims,"\n",
        "Distribution Family: ", dist_type, "\n",
        "Parameters: ", if(atb$tibble_type == "tidy_gaussian"){
            paste0("Mean: ", atb$.mean, " - SD: ", atb$.sd)
        } else if(atb$tibble_type == "tidy_gamma"){
            paste0("Shape: ", atb$.shape, " - Rate: ", atb$.rate)
        } else if(atb$tibble_type == "tidy_beta"){
            paste0("Shape1: ", atb$.shape1, " - Shape2: ", atb$.shape2, " - NCP: ", atb$.ncp)
        } else if(atb$tibble_type == "tidy_poisson"){
            paste0("Lambda: ", atb$.lambda)
        } else if(atb$tibble_type == "tidy_f"){
            paste0("DF1: ", atb$.df1, " - DF2: ", atb$.df2, " - NCP: ", atb$.ncp)
        } else if(atb$tibble_type == "tidy_hypergeometric"){
            paste0("M: ", atb$.m, " - NN: ", atb$.nn, " - K: ", atb$.k)
        } else if(atb$tibble_type == "tidy_lognormal"){
            paste0("Mean Log: ", atb$.meanlog, " - SD Log: ", atb$.sdlog)
        } else if(atb$tibble_type == "tidy_cauchy"){
            paste0("Location: ", atb$.location, " - Scale: ", atb$.scale)
        } else if(atb$tibble_type == "tidy_chisquare"){
            paste0("DF: ", atb$.df, " - NPC: ", atb$.ncp)
        } else if(atb$tibble_type == "tidy_weibull"){
            paste0("Shape: ", atb$.schape, " - Scale: ", atb$.scale)
        } else if(atb$tibble_type == "tidy_uniform"){
            paste0("Max: ", atb$.max, " - Min: ", atb$.min)
        } else if(atb$tibble_type == "tidy_logistic"){
            paste0("Location: ", atb$.location, " - Scale: ", atb$.scale)
        } else if(atb$tibble_type == "tidy_exponential"){
            paste0("Rate: ", atb$.rate)
        } else if(atb$tibble_type == "tidy_empirical"){
            paste0("Empirical - No params")
        }
    )

    # Data ----
    data_tbl <- dplyr::as_tibble(.data)

    # Plot logic ----
    leg_pos <- ifelse(sims > 9, "none", "bottom")

    if(plot_type == "density"){
        plt <- data_tbl %>%
            ggplot2::ggplot(
                ggplot2::aes(x = dx, y = dy, group = sim_number, color = sim_number)
            ) +
            ggplot2::geom_line(size = line_size) +
            ggplot2::geom_point(size = point_size) +
            ggplot2::theme_minimal() +
            ggplot2::geom_jitter() +
            ggplot2::labs(
                title = "Density Plot",
                subtitle = sub_title,
                color = "Simulation"
            ) +
            ggplot2::theme(legend.position = leg_pos)
    } else if(plot_type == "quantile"){
        plt <- data_tbl %>%
            ggplot2::ggplot(
                ggplot2::aes(
                    x = qs, y = q, group = sim_number, color = sim_number
                )
            ) +
            ggplot2::geom_point(size = point_size) +
            ggplot2::geom_line(size = line_size) +
            ggplot2::theme_minimal() +
            ggplot2::geom_jitter() +
            ggplot2::labs(
                title = "Qantile Plot",
                subtitle = sub_title,
                color = "Simulation"
            ) +
            ggplot2::theme(legend.position = leg_pos)
    } else if(plot_type == "probability"){
        plt <- data_tbl %>%
            ggplot2::ggplot(
                ggplot2::aes(
                    x = ps, y = p, color = sim_number, group = sim_number
                )
            ) +
            ggplot2::geom_point(size = point_size) +
            ggplot2::geom_line(size = line_size) +
            ggplot2::theme_minimal() +
            ggplot2::labs(
                title = "Probabilty Plot",
                subtitle = sub_title,
                color = "Simulation"
            ) +
            ggplot2::theme(legend.position = leg_pos)
    } else if(plot_type == "qq"){
        plt <- data_tbl %>%
            ggplot2::ggplot(
                ggplot2::aes(
                    sample = y, color = sim_number, group = sim_number
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

    if(.interactive){
        plt <- plotly::ggplotly(plt)
    }

    # Return ----
    return(plt)
}
