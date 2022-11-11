#' Tidy Mixture Data
#'
#' @family Mixture Data
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function allows you to make mixture model data. It allows you
#' to produce density data and plots for data that is not strictly of one family
#' or of one single type of distribution with a given set of parameters.
#'
#' For example this function will allow you to mix say tidy_normal(.mean = 0, .sd = 1)
#' and tidy_normal(.mean = 5, .sd = 1) or you can mix and match distributions.
#'
#' The output is a list object with three components.
#' 1. Data
#' -  input_data (The random data passed)
#' -  dist_tbl (A tibble of the passed random data)
#' -  density_tbl (A tibble of the x and y data from `stats::density()`)
#'
#' 2. Plots
#' -  line_plot - Plots the dist_tbl
#' -  dens_plot - Plots the density_tbl
#'
#' 3. Input Functions
#' -  input_fns - A list of the functions and their parameters passed to the function
#' itsefl
#'
#' @description Create mixture model data and resulting density and line plots.
#'
#' @param ... The random data you want to pass. Example rnorm(50,0,1) or something
#' like tidy_normal(.mean = 5, .sd = 1)
#'
#' @examples
#' output <- tidy_mixture_density(rnorm(100, 0, 1), tidy_normal(.mean = 5, .sd = 1))
#'
#' output$data
#'
#' output$plots
#'
#' output$input_fns
#'
#' @return
#' A list object
#'
#' @export
#'

tidy_mixture_density <- function(...) {

  # Add distributions to a list, all base R and TidyDensity
  dist_list <- list(...) %>% purrr::compact()

  # Check that list is of length 2 or more before proceeding
  if (length(dist_list) < 2) {
    rlang::abort(
      message = "You need to pass at least two distributions
      or 'y' vectors.",
      use_cli_format = TRUE
    )
  }

  # From SO Question of mine
  # https://stackoverflow.com/questions/71743013/get-formalargs-from-a-list-of-functions-r/71743155#71743155
  input_data_tbl <- stats::setNames(list(...), sapply(as.list(match.call())[-1], deparse))

  # Capture functions that were passed
  input_fns <- as.list(match.call())[-1]

  # Map dist_list to a tibble
  all_col_nms <- names(purrr::map_dfr(dist_list, dplyr::as_tibble))

  if ("sim_number" %in% all_col_nms) {
    # Get the median value of the sim_numbers even if it is
    # only 1
    tidy_dist_data_tbl <- purrr::map_dfr(dist_list, dplyr::as_tibble) %>%
      dplyr::select(y, sim_number) %>%
      dplyr::filter(!is.na(y)) %>%
      dplyr::group_by(sim_number) %>%
      dplyr::mutate(rec_no = dplyr::row_number()) %>%
      dplyr::ungroup() %>%
      dplyr::group_by(rec_no) %>%
      dplyr::summarise(y = stats::median(y)) %>%
      dplyr::ungroup() %>%
      dplyr::select(y) %>%
      dplyr::mutate(x = dplyr::row_number()) %>%
      dplyr::select(x, y)
  }

  if ("value" %in% all_col_nms) {
    tidy_vec_data_tbl <- purrr::map_dfr(dist_list, dplyr::as_tibble) %>%
      dplyr::select(value) %>%
      dplyr::filter(!is.na(value)) %>%
      dplyr::rename(y = value) %>%
      dplyr::mutate(x = dplyr::row_number()) %>%
      dplyr::select(x, y)
  }

  if ((exists("tidy_dist_data_tbl") && nrow(tidy_dist_data_tbl) != 0) &&
    (exists("tidy_vec_data_tbl") && nrow(tidy_vec_data_tbl) != 0)) {
    dist_tbl <- rbind(tidy_vec_data_tbl, tidy_dist_data_tbl)
  } else if ((exists("tidy_dist_data_tbl") && nrow(tidy_dist_data_tbl) != 0) &&
    !exists("tidy_vec_data_tbl")) {
    dist_tbl <- tidy_dist_data_tbl
  } else {
    dist_tbl <- tidy_vec_data_tbl
  }

  n <- nrow(dist_tbl)

  density_tbl <- stats::density(dist_tbl$y, n = n)[c("x", "y")] %>%
    dplyr::as_tibble()

  # Plots ----
  p1 <- dist_tbl %>%
    ggplot2::ggplot(ggplot2::aes(x = x, y = y)) +
    ggplot2::geom_line() +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Line Plot of mixture data",
      subtitle = paste0("Mixutre Model Data from: ", toString(input_fns)),
      x = "",
      y = "Value"
    )

  p2 <- density_tbl %>%
    ggplot2::ggplot(ggplot2::aes(x = x, y = y)) +
    ggplot2::geom_line() +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Density Plot",
      subtitle = paste0("Mixutre Model Data from: ", toString(input_fns))
    )

  # Return ----
  output <- list(
    data = list(
      dist_tbl   = dist_tbl,
      dens_tbl   = density_tbl,
      input_data = input_data_tbl
    ),
    plots = list(
      line_plot = p1,
      dens_plot = p2
    ),
    input_fns = input_fns
  )

  return(output)
}
