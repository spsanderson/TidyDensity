#' Automatic Plot of Random Walk Data
#'
#' @family Autoplot
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will produce a simple random walk plot from a `tidy_`
#' distribution function.
#'
#' @description This is an auto-plotting function that will take in a `tidy_`
#' distribution function and a few arguments with regard to the output of the
#' visualization.
#'
#' If the number of simulations exceeds 9 then the legend will not print. The plot
#' subtitle is put together by the attributes of the table passed to the function.
#'
#' @param .data The data passed in from a tidy_`distribution` function like
#' `tidy_normal()`
#' @param .line_size The size param ggplot
#' @param .geom_rug A Boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return the use of `ggplot2::geom_rug()`
#' @param .geom_smooth A Boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return the use of `ggplot2::geom_smooth()` The `aes` parameter of group is
#' set to FALSE. This ensures a single smoothing band returned with SE also set to
#' FALSE. Color is set to 'black' and `linetype` is 'dashed'.
#' @param .interactive A Boolean value of TRUE/FALSE, FALSE is the default. TRUE
#' will return an interactive `plotly` plot.
#'
#' @examples
#' tidy_normal(.sd = .1, .num_sims = 5) %>%
#'   tidy_random_walk(.value_type = "cum_sum") %>%
#'   tidy_random_walk_autoplot()
#'
#' tidy_normal(.sd = .1, .num_sims = 20) %>%
#'   tidy_random_walk(.value_type = "cum_sum", .sample = TRUE, .replace = TRUE) %>%
#'   tidy_random_walk_autoplot()
#'
#' @return
#' A ggplot or a plotly plot.
#'
#' @export
#'

tidy_random_walk_autoplot <- function(.data, .line_size = 1, .geom_rug = FALSE,
                                      .geom_smooth = FALSE, .interactive = FALSE){

    # Tidyeval ----
    line_size <- as.numeric(.line_size)

    # Get the data attributes for plot title/subtitle ---
    atb  <- attributes(.data)
    n    <- atb$all$.n
    sims <- atb$all$.num_sims
    dist_type <- stringr::str_remove(atb$all$tibble_type, "tidy_") %>%
            stringr::str_replace_all(pattern = "_", " ") %>%
            stringr::str_to_title()

    sub_title <- paste0(
        "Data Points: ", n, " - ",
        "Simulations: ", sims, "\n",
        "Distribution Family: ", dist_type, "\n",
        "Parameters: ", if (atb$all$tibble_type == "tidy_gaussian") {
            paste0("Mean: ", atb$all$.mean, " - SD: ", atb$all$.sd)
        } else if (atb$all$tibble_type == "tidy_gamma") {
            paste0("Shape: ", atb$all$.shape, " - Rate: ", atb$all$.rate)
        } else if (atb$all$tibble_type == "tidy_beta") {
            paste0("Shape1: ", atb$all$.shape1, " - Shape2: ", atb$all$.shape2, " - NCP: ", atb$all$.ncp)
        } else if (atb$all$tibble_type %in% c("tidy_poisson", "tidy_zero_truncated_poisson")) {
            paste0("Lambda: ", atb$all$.lambda)
        } else if (atb$all$tibble_type == "tidy_f") {
            paste0("DF1: ", atb$all$.df1, " - DF2: ", atb$all$.df2, " - NCP: ", atb$all$.ncp)
        } else if (atb$all$tibble_type == "tidy_hypergeometric") {
            paste0("M: ", atb$all$.m, " - NN: ", atb$all$.nn, " - K: ", atb$all$.k)
        } else if (atb$all$tibble_type == "tidy_lognormal") {
            paste0("Mean Log: ", atb$all$.meanlog, " - SD Log: ", atb$all$.sdlog)
        } else if (atb$all$tibble_type == "tidy_cauchy") {
            paste0("Location: ", atb$all$.location, " - Scale: ", atb$all$.scale)
        } else if (atb$all$tibble_type == "tidy_chisquare") {
            paste0("DF: ", atb$all$.df, " - NPC: ", atb$all$.ncp)
        } else if (atb$all$tibble_type == "tidy_weibull") {
            paste0("Shape: ", atb$all$.schape, " - Scale: ", atb$all$.scale)
        } else if (atb$all$tibble_type == "tidy_uniform") {
            paste0("Max: ", atb$all$.max, " - Min: ", atb$all$.min)
        } else if (atb$all$tibble_type == "tidy_logistic") {
            paste0("Location: ", atb$all$.location, " - Scale: ", atb$all$.scale)
        } else if (atb$all$tibble_type == "tidy_exponential") {
            paste0("Rate: ", atb$all$.rate)
        } else if (atb$all$tibble_type == "tidy_empirical") {
            paste0("Empirical - No params")
        } else if (atb$all$tibble_type %in% c(
            "tidy_binomial", "tidy_negative_binomial",
            "tidy_zero_truncated_binomial",
            "tidy_zero_truncated_negative_binomial"
        )) {
            paste0("Size: ", atb$all$.size, " - Prob: ", atb$all$.prob)
        } else if (atb$all$tibble_type %in% c("tidy_geometric", "tidy_zero_truncated_geometric")) {
            paste0("Prob: ", atb$all$.prob)
        } else if (atb$all$tibble_type %in% c("tidy_pareto_single_parameter")) {
            paste0("Shape: ", atb$all$.shape, " - Min: ", atb$all$.min)
        } else if (atb$all$tibble_type %in% c("tidy_pareto", "tidy_inverse_pareto")) {
            paste0("Shape: ", atb$all$.shape, " - Scale: ", atb$all$.scale)
        } else if (atb$all$tibble_type %in% c("tidy_generalized_pareto",
                                              "tidy_burr","tidy_inverse_burr")){
            paste0(
                "Shape1: ", atb$all$.shape1, " - ",
                "Shape2: ", atb$all$.shape2, " - ",
                "Rate: ", atb$all$.rate, " - ",
                "Scale: ", atb$all$.scale
            )
        } else if (atb$all$tibble_type %in% c(
            "tidy_paralogistic",
            "tidy_inverse_gamma",
            "tidy_inverse_weibull"
        )
        ){
            paste0("Shape: ", atb$all$.shape, " - ",
                   "Rate: ", atb$all$.rate, " - ",
                   "Scale: ", atb$all$.scale)
        } else if (atb$all$tibble_type == "tidy_inverse_exponential"){
            paste0("Rate: ", atb$all$.rate, " - Scale: ", atb$all$.scale)
        } else if (atb$all$tibble_type == "tidy_inverse_gaussian"){
            paste0("Mean: ", atb$all$.mean, " - ",
                   "Shape: ", atb$all$.shape, " - ",
                   "Dispersion: ", atb$all$.dispersion)
        } else if (atb$all$tibble_type == "tidy_generalized_beta"){
            paste0(
                "Shape1: ", atb$all$.shape1, " - ",
                "Shape2: ", atb$all$.shape2, " - ",
                "Shape3: ", atb$all$.shape3, " - ",
                "Scale: ", atb$all$.scale, " - ",
                "Rate: ", atb$all$.rate
            )
        }
    )

    # Plot Legend logic ----
    leg_pos <- if (atb$all$tibble_type == "tidy_empirical") {
        "none"
    } else if (sims > 9) {
        "none"
    } else {
        "bottom"
    }

    # Data ----
    data_tbl <- dplyr::as_tibble(.data)

    # Plot ----
    plt <- data_tbl %>%
        ggplot2::ggplot(ggplot2::aes(x = x, y = random_walk_value,
                                     group = sim_number, color = sim_number)) +
        ggplot2::geom_line(size = line_size) +
        ggplot2::theme_minimal() +
        ggplot2::labs(
            title = "Random Walk Plot",
            subtitle = sub_title,
            color = "Simulation",
            x = "Time",
            y = "Value"
        ) +
        ggplot2::theme(legend.position = leg_pos)

    if (.geom_rug) {
        plt <- plt +
            ggplot2::geom_rug()
    }

    if (.geom_smooth) {
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

    if (.interactive) {
        plt <- plotly::ggplotly(plt)
    }

    # Return ----
    return(plt)

}
