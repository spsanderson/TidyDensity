#' Generate Multiple Tidy Distributions of a single type
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @family Multiple Distribution
#'
#' @details Generate multiple distributions of data from the same `tidy_`
#' distribution function. This allows you to simulate multiple distributions of
#' the same family in order to view how shapes change with parameter changes. You
#' can then visualize the differences however you choose.
#'
#' @description Generate multiple distributions of data from the same `tidy_`
#' distribution function.
#'
#' @param .tidy_dist The type of `tidy_` distribution that you want to run. You
#' can only choose one.
#' @param .param_list This must be a `list()` object of the parameters that you
#' want to pass through to the TidyDensity `tidy_` distribution function.
#'
#' @examples
#' tidy_multi_single_dist(
#'   .tidy_dist = "tidy_normal",
#'   .param_list = list(
#'     .n = 50,
#'     .mean = c(-1, 0, 1),
#'     .sd = 1,
#'     .num_sims = 3
#'   )
#' )
#'
#' @return
#' A tibble
#'
#' @export
#'

tidy_multi_single_dist <- function(.tidy_dist = NULL,
                                   .param_list = list()) {
  require("TidyDensity")

  # Check param ----
  if (is.null(.tidy_dist)) {
    rlang::abort(
      message = "Please enter a 'tidy_' distribution function like 'tidy_normal'
                        in quotes.",
      use_cli_format = TRUE
    )
  }

  if (length(.param_list) == 0) {
    rlang::abort(
      message = "Please enter some parameters for your chosen 'tidy_' distribution.",
      use_cli_format = TRUE
    )
  }

  # Call used ---
  td <- tolower(as.character(.tidy_dist))

  # Params ----
  params <- .param_list

  # Set the grid to make the calls ----
  param_grid <- expand.grid(params)

  # func_parm_list <- as.list(df)
  names(param_grid) <- methods::formalArgs(td)

  # Run call on the grouped df ----
  dff <- param_grid %>%
    dplyr::mutate(results = purrr::pmap(dplyr::cur_data(), match.fun(td)))

  # Get the attributes to be used later on ----
  atb <- dff$results[[1]] %>% attributes()

  # Make Dist Type for column ----
  # dist_type <- stringr::str_remove(atb$tibble_type, "tidy_") %>%
  #   stringr::str_replace_all(pattern = "_", " ") %>%
  #   stringr::str_to_title()

  dist_type <- dist_type_extractor(atb$tibble_type)

  # Get column names from the param_grid in order to make teh dist_type column ----
  cols <- names(param_grid %>% dplyr::select(-c(.n, .num_sims)))

  if (length(cols) == 1) {
    dff$dist_name <- paste0(dist_type, " c(", dff[, cols], ")")
  } else {
    dff$dist_name <- paste0(
      paste0(dist_type, " c("),
      apply(dff[, cols], 1, paste0, collapse = ", "),
      ")"
    )
  }

  # dff$dist_name <- paste0(
  #   paste0(dist_type, " c("),
  #   apply(dff[, cols], 1, paste0, collapse = ", "),
  #   ")"
  # )

  df_unnested_tbl <- dff %>%
    tidyr::unnest(results) %>%
    dplyr::ungroup() %>%
    dplyr::select(sim_number, dist_name, x:q) %>%
    dplyr::mutate(dist_name = as.factor(dist_name)) %>%
    dplyr::arrange(sim_number, dist_name)

  # Attach attributes ----
  attr(df_unnested_tbl, "all") <- atb
  attr(df_unnested_tbl, "tibble_type") <- atb$tibble_type
  attr(df_unnested_tbl, "tbl") <- "tidy_multi_tibble"
  attr(df_unnested_tbl, ".num_sims") <- max(param_grid$.num_sims)
  attr(df_unnested_tbl, ".param_list") <- .param_list

  # Return ----
  return(df_unnested_tbl)
}
