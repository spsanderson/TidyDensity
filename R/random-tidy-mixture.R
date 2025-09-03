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
#' The function now supports different combination types:
#' - 'add': Element-wise addition of distributions (e.g., rnorm(50) + rbeta(50, 0.5, 0.5))
#' - 'subtract': Element-wise subtraction (e.g., rnorm(50) - rbeta(50, 0.5, 0.5))
#' - 'multiply': Element-wise multiplication (e.g., rnorm(50) * rbeta(50, 0.5, 0.5))
#' - 'divide': Element-wise division (e.g., rnorm(50) / rbeta(50, 0.5, 0.5))
#' - 'stack': Combine all data points together (e.g., c(rnorm(50), rbeta(50, 0.5, 0.5)))
#'
#' When .cumulative_sum = TRUE, the cumulative sum is applied to the combined result.
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
#' itself
#'
#' @description Create mixture model data and resulting density and line plots.
#'
#' @param ... The random data you want to pass. Example rnorm(50,0,1) or something
#' like tidy_normal(.mean = 5, .sd = 1)
#' @param .combination_type A character string specifying how to combine the distributions.
#' Options are 'add', 'subtract', 'multiply', 'divide', or 'stack' (default).
#' @param .cumulative_sum A logical value indicating whether to apply cumulative sum
#' to the result. Default is FALSE.
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
#' # Example with different combination types
#' set.seed(123)
#' mix_add <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5), .combination_type = "add")
#' mix_add$input_fns
#'
#' mix_multiply <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5), .combination_type = "multiply")
#' mix_multiply$input_fns
#'
#' mix_stack <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5), .combination_type = "stack")
#' mix_stack$input_fns
#'
#' # Example with cumulative sum
#' mix_cumsum <- tidy_mixture_density(rnorm(50), rbeta(50, 0.5, 0.5),
#'                                   .combination_type = "stack", .cumulative_sum = TRUE)
#' mix_cumsum$input_fns
#'
#' @return
#' A list object
#'
#' @export
#'

tidy_mixture_density <- function(..., .combination_type = "stack", .cumulative_sum = FALSE) {

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
  l_names <- as.list(substitute(list(...)))[-1L]
  l <- list(...)
  input_data_tbl <- stats::setNames(l, l_names)

  # input_data_tbl <- dist_fns(...)
  # input_data_tbl <- stats::setNames(list(...), sapply(as.list(match.call())[-1], deparse))

  # Capture functions that were passed
  input_fns <- match.call()[-1]
  input_call_string <- toString(input_fns)
  # Make sure input_call_string does not contain the following:
  # add, subtract, multiply, divide, stack, TRUE, FALSE
  input_call_string <- stringr::str_remove_all(
    string = input_call_string,
    pattern = "\\b(add|subtract|multiply|divide|stack|TRUE|FALSE)\\b"
  )
  # Remove extra commas and spaces at the end if they exist
  input_call_string <- gsub("(,\\s*)+$", "", input_call_string)
  # Removed redundant second gsub call

  # Parameter validation
  combination_type <- tolower(as.character(.combination_type))
  cumulative_sum <- as.logical(.cumulative_sum)

  if (!combination_type %in% c("add", "subtract", "multiply", "divide", "stack")) {
    rlang::abort(
      message = "'.combination_type' must be one of: 'add', 'subtract', 'multiply', 'divide', 'stack'",
      use_cli_format = TRUE
    )
  }

  if (!is.logical(cumulative_sum)) {
    rlang::abort(
      message = "'.cumulative_sum' must be TRUE or FALSE",
      use_cli_format = TRUE
    )
  }

  # Extract data vectors from each distribution
  data_vectors <- list()

  for (i in seq_along(dist_list)) {
    dist_data <- dplyr::as_tibble(dist_list[[i]])

    if ("y" %in% names(dist_data)) {
      # TidyDensity object
      if ("sim_number" %in% names(dist_data)) {
        # Get median across simulations for consistency
        y_values <- dist_data %>%
          dplyr::filter(!is.na(y)) %>%
          dplyr::group_by(sim_number) %>%
          dplyr::mutate(rec_no = dplyr::row_number()) %>%
          dplyr::ungroup() %>%
          dplyr::group_by(rec_no) %>%
          dplyr::summarise(y = stats::median(y), .groups = "drop") %>%
          dplyr::pull(y)
      } else {
        y_values <- dist_data %>%
          dplyr::filter(!is.na(y)) %>%
          dplyr::pull(y)
      }
    } else if ("value" %in% names(dist_data)) {
      # Raw vector
      y_values <- dist_data %>%
        dplyr::filter(!is.na(value)) %>%
        dplyr::pull(value)
    } else {
      # Try to extract as a simple vector
      y_values <- as.numeric(dist_list[[i]])
      y_values <- y_values[!is.na(y_values)]
    }

    data_vectors[[i]] <- y_values
  }

  # Combine distributions based on combination_type
  if (combination_type == "stack") {
    # Original behavior - combine all data points
    combined_y <- unlist(data_vectors)
  } else {
    # Element-wise operations - use first two distributions primarily
    if (length(data_vectors) < 2) {
      rlang::abort(
        message = "Element-wise operations require at least 2 distributions",
        use_cli_format = TRUE
      )
    }

    # Use the minimum length for element-wise operations
    min_length <- min(sapply(data_vectors, length))
    vec1 <- data_vectors[[1]][1:min_length]
    vec2 <- data_vectors[[2]][1:min_length]

    combined_y <- switch(combination_type,
      "add" = vec1 + vec2,
      "subtract" = vec1 - vec2,
      "multiply" = vec1 * vec2,
      "divide" = vec1 / vec2
    )

    # Include additional distributions if present
    if (length(data_vectors) > 2) {
      for (i in 3:length(data_vectors)) {
        vec_i <- data_vectors[[i]][1:min_length]
        combined_y <- switch(combination_type,
          "add" = combined_y + vec_i,
          "subtract" = combined_y - vec_i,
          "multiply" = combined_y * vec_i,
          "divide" = combined_y / vec_i
        )
      }
    }
  }

  # Apply cumulative sum if requested
  if (cumulative_sum) {
    combined_y <- cumsum(combined_y)
  }

  # Create final data table
  dist_tbl <- dplyr::tibble(
    x = seq_along(combined_y),
    y = combined_y
  )

  n <- nrow(dist_tbl)

  density_tbl <- stats::density(dist_tbl$y, n = n)[c("x", "y")] %>%
    dplyr::as_tibble()

  # Create subtitle with combination info
  combo_info <- paste0("Combination: ", toupper(combination_type))
  if (cumulative_sum) {
    combo_info <- paste0(combo_info, " + Cumulative Sum")
  }

  # Plots ----
  p1 <- dist_tbl %>%
    ggplot2::ggplot(ggplot2::aes(x = x, y = y)) +
    ggplot2::geom_line() +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Line Plot of mixture data",
      subtitle = paste0("Mixture Model Data from: ", input_call_string, " - ", combo_info),
      x = "",
      y = "Value"
    )

  p2 <- density_tbl %>%
    ggplot2::ggplot(ggplot2::aes(x = x, y = y)) +
    ggplot2::geom_line() +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Density Plot",
      subtitle = paste0("Mixture Model Data from: ", input_call_string, " - ", combo_info)
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
    input_fns = input_call_string
  )

  return(output)
}
