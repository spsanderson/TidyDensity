#' Bootstrap Stat Plot
#'
#' @family Bootstrap
#' @family Autoplot
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' This function will take in data from either `tidy_bootstrap()` directly or
#' after apply `bootstrap_unnest_tbl()` to its output. There are several different
#' cumulative functions that can be applied to the data.The accepted values are:
#' *  "cmean" - Cumulative Mean
#' *  "chmean" - Cumulative Harmonic Mean
#' *  "cgmean" - Cumulative Geometric Mean
#' *  "csum" = Cumulative Sum
#' *  "cmedian" = Cumulative Median
#' *  "cmax" = Cumulative Max
#' *  "cmin" = Cumulative Min
#' *  "cprod" = Cumulative Product
#' *  "csd" = Cumulative Standard Deviation
#' *  "cvar" = Cumulative Variance
#' *  "cskewness" = Cumulative Skewness
#' *  "ckurtosis" = Cumulative Kurtotsis
#'
#' @description
#' This function produces a plot of a cumulative statistic function applied to the
#' bootstrap variable from `tidy_bootstrap()` or after `bootstrap_unnest_tbl()`
#' has been applied to it.
#'
#' @param .data The data that comes from either `tidy_bootstrap()` or after
#' `bootstrap_unnest_tbl()` is applied to it.
#' @param .value The value column that the calculations are being applied to.
#' @param .stat The cumulative statistic function being applied to the `.value`
#' column. It must be quoted. The default is "cmean".
#' @param .show_groups The default is FALSE, set to TRUE to get output of all
#' simulations of the bootstrap data.
#' @param .show_ci_labels The default is TRUE, this will show the last value of
#' the upper and lower quantile.
#' @param .interactive The default is FALSE, set to TRUE to get a plotly plot
#' object back.
#'
#' @examples
#' x <- mtcars$mpg
#'
#' tidy_bootstrap(x) |>
#'   bootstrap_stat_plot(y, "cmean")
#'
#' tidy_bootstrap(x, .num_sims = 10) |>
#'   bootstrap_stat_plot(y,
#'     .stat = "chmean", .show_groups = TRUE,
#'     .show_ci_label = FALSE
#'   )
#'
#' @return
#' A plot either ggplot2 or plotly.
#'
#'
#' @export
#'

bootstrap_stat_plot <- function(.data, .value, .stat = "cmean",
                                .show_groups = FALSE, .show_ci_labels = TRUE,
                                .interactive = FALSE) {

  # Tidyeval ----
  value_var_expr <- rlang::enquo(.value)
  stat_fn <- tolower(as.character(.stat))
  show_groups <- as.logical(.show_groups)
  ip <- as.logical(.interactive)
  show_ci_labels <- as.logical(.show_ci_labels)

  atb <- attributes(.data)

  # Checks ----
  if (!atb$tibble_type %in% c("tidy_bootstrap", "tidy_bootstrap_nested")) {
    rlang::abort(
      message = "Must pass data to this function from either tidy_bootstrap() or
      bootstrap_unnest_tbl().",
      use_cli_format = TRUE
    )
  }

  if (rlang::quo_is_missing(value_var_expr)) {
    rlang::abort(
      message = ".value must be supplied.",
      use_cli_format = TRUE
    )
  }

  if (!stat_fn %in% c(
    "cmean", "chmean", "cgmean", "csum", "cmedian", "cmax", "cmin",
    "cprod", "csd", "cvar", "cskewness", "ckurtosis"
  )) {
    rlang::abort(
      message = "The .stat you have chosen is unsupported at the moment.",
      use_cli_format = TRUE
    )
  }

  # Data ----
  if (atb$tibble_type == "tidy_bootstrap_nested") {
    df_tbl <- dplyr::as_tibble(.data) |>
      TidyDensity::bootstrap_unnest_tbl()
  }

  if (atb$tibble_type == "tidy_bootstrap") {
    df_tbl <- dplyr::as_tibble(.data)
  }

  # Manipulation
  if (show_groups) {
    df_tbl <- df_tbl |>
      dplyr::group_by(sim_number) |>
      dplyr::mutate(
        stat = switch(stat_fn,
          "cmean" = TidyDensity::cmean(y),
          "chmean" = TidyDensity::chmean(y),
          "cgmean" = TidyDensity::cgmean(y),
          "csum" = cumsum(y),
          "cmedian" = TidyDensity::cmedian(y),
          "cmax" = cummax(y),
          "cmin" = cummin(y),
          "cprod" = cumprod(y),
          "csd" = TidyDensity::csd(y),
          "cvar" = TidyDensity::cvar(y),
          "cskewness" = TidyDensity::cskewness(y),
          "ckurtosis" = TidyDensity::ckurtosis(y)
        )
      ) |>
      dplyr::mutate(x = dplyr::row_number()) |>
      dplyr::ungroup() |>
      dplyr::group_by(x) |>
      dplyr::mutate(cil = TidyDensity::ci_lo(stat, .na_rm = TRUE)) |>
      dplyr::mutate(cih = TidyDensity::ci_hi(stat, .na_rm = TRUE)) |>
      dplyr::mutate(mstat = mean(stat, na.rm = TRUE)) |>
      dplyr::ungroup()
  } else {
    df_tbl <- df_tbl |>
      dplyr::group_by(sim_number) |>
      dplyr::mutate(
        stat = switch(stat_fn,
          "cmean" = TidyDensity::cmean(y),
          "chmean" = TidyDensity::chmean(y),
          "cgmean" = TidyDensity::cgmean(y),
          "csum" = cumsum(y),
          "cmedian" = TidyDensity::cmedian(y),
          "cmax" = cummax(y),
          "cmin" = cummin(y),
          "cprod" = cumprod(y),
          "csd" = TidyDensity::csd(y),
          "cvar" = TidyDensity::cvar(y),
          "cskewness" = TidyDensity::cskewness(y),
          "ckurtosis" = TidyDensity::ckurtosis(y)
        )
      ) |>
      dplyr::mutate(x = dplyr::row_number()) |>
      dplyr::ungroup() |>
      dplyr::group_by(x) |>
      dplyr::summarise(
        cil = TidyDensity::ci_lo(stat, .na_rm = TRUE),
        cih = TidyDensity::ci_hi(stat, .na_rm = TRUE),
        stat = mean(stat, na.rm = TRUE)
      ) |>
      dplyr::ungroup()
  }

  # Plot ----
  y_txt <- switch(stat_fn,
    "cmean" = "Mean",
    "chmean" = "Harmonic Mean",
    "cgmean" = "Geometric Mean",
    "csum" = "Sum",
    "cmedian" = "Median",
    "cmax" = "Max",
    "cmin" = "Min",
    "cprod" = "Product",
    "csd" = "Standard Deviation",
    "cvar" = "Variance",
    "cskewness" = "Skewness",
    "ckurtosis" = "Kurtosis"
  )

  sub_title <- paste0("Cumulative Statistic: ", y_txt)
  cap <- paste0("Simulations: ", atb$.num_sims)
  if (show_groups) {
    p <- df_tbl |>
      ggplot2::ggplot(ggplot2::aes(x = x, y = stat, group = sim_number)) +
      ggplot2::geom_line(color = "lightgray") +
      ggplot2::geom_line(ggplot2::aes(y = mstat),
        color = "red",
        linetype = "dashed"
      ) +
      ggplot2::geom_line(ggplot2::aes(y = cil),
        color = "darkgreen",
        linetype = "dashed"
      ) +
      ggplot2::geom_line(ggplot2::aes(y = cih),
        color = "darkgreen",
        linetype = "dashed"
      ) +
      ggplot2::theme_minimal() +
      ggplot2::labs(
        x = "X",
        y = y_txt,
        subtitle = sub_title,
        caption = cap
      )
  } else {
    p <- df_tbl |>
      ggplot2::ggplot(ggplot2::aes(x = x, y = stat)) +
      ggplot2::geom_line(color = "red", linetype = "dashed") +
      ggplot2::geom_line(ggplot2::aes(y = cil),
        color = "darkgreen",
        linetype = "dashed"
      ) +
      ggplot2::geom_line(ggplot2::aes(y = cih),
        color = "darkgreen",
        linetype = "dashed"
      ) +
      ggplot2::theme_minimal() +
      ggplot2::labs(
        x = "X",
        y = y_txt,
        subtitle = sub_title,
        caption = cap
      )
  }

  # Show CI Labels ----
  if (show_ci_labels) {
    p <- p +
      ggplot2::annotate(
        geom = "label",
        x = max(df_tbl$x), y = max(subset(df_tbl, x == max(x))$cil),
        label = prettyNum(round(max(subset(df_tbl, x == max(x))$cil), 0), big.mark = ","),
        size = 3, hjust = 1, color = "white", fill = "steelblue"
      ) +
      ggplot2::annotate(
        geom = "label",
        x = max(df_tbl$x), y = min(subset(df_tbl, x == max(x))$cih),
        label = prettyNum(round(min(subset(df_tbl, x == max(x))$cih), 0), big.mark = ","),
        size = 3, hjust = 1, color = "white", fill = "firebrick"
      )
  }


  # Return ----
  if (ip) {
    p <- plotly::ggplotly(p)
  } else {
    p <- p
  }

  return(p)
}
