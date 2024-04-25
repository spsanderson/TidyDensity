#' Tidy MCMC Sampling
#'
#' Perform MCMC sampling and return tidy data and a plot.
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function performs Markov Chain Monte Carlo (MCMC) sampling on the input
#' data and returns tidy data and a plot representing the results.
#'
#' @details
#' The function takes a data vector as input and performs MCMC sampling with the
#' specified number of simulations. It applies user-defined functions to each
#' MCMC sample and to the cumulative MCMC samples. The resulting data is
#' formatted in a tidy format, suitable for further analysis. Additionally, a
#' plot is generated to visualize the MCMC samples and cumulative statistics.
#'
#' @param .x The data vector for MCMC sampling.
#' @param .fns The function(s) to apply to each MCMC sample. Default is "mean".
#' @param .cum_fns The function(s) to apply to the cumulative MCMC samples. Default is "cmean".
#' @param .num_sims The number of simulations. Default is 2000.
#'
#' @return A list containing tidy data and a plot.
#'
#' @examples
#' # Generate MCMC samples
#' set.seed(123)
#' data <- rnorm(100)
#' result <- tidy_mcmc_sampling(data, "median", "cmedian", 500)
#' result
#'
#' @name tidy_mcmc_sampling
NULL

#' @rdname tidy_mcmc_sampling
#' @export
tidy_mcmc_sampling <- function(.x, .fns = "mean", .cum_fns = "cmean",
                               .num_sims = 2000) {

  # Error handling for data argument
  if (!is.vector(.x)) {
    rlang::abort(
      message = "Error: '.x' argument must be a vector.",
      use_cli_format = TRUE
    )
  }

  # Error handling for function arguments
  if (!exists(.fns)) {
    rlang::abort(
      message = "Error: '.fns' argument must be a valid function name. Make sure
      any necessary libraries are loaded.",
      use_cli_format = TRUE
    )
  }

  if (!exists(.cum_fns)) {
    rlang::abort(
      message = "Error: '.cum_fns' argument must be a valid function name. Make sure
      any necessary libraries are loaded.",
      use_cli_format = TRUE
    )
  }

  # Validate number of simulations
  nsims <- ifelse(.num_sims > 0, as.integer(.num_sims), 1L)

  fns <- match.fun(.fns)
  fns_name <- as.character(.fns)
  cum_fns <- match.fun(.cum_fns)
  cum_fns_name <- as.character(.cum_fns)
  nsims <- as.integer(.num_sims)
  fctr_lvl_nms <- c(
    paste0(".sample_", fns_name),
    paste0(".cum_stat_", cum_fns_name)
  )

  df <- TidyDensity::tidy_bootstrap(.x = .x, .num_sims = nsims) |>
    dplyr::mutate(.sample = purrr::map(bootstrap_samples, \(x) fns(x))) |>
    dplyr::select(sim_number, .sample) |>
    tidyr::unnest(cols = .sample) |>
    dplyr::rename_with(~paste0(., "_", fns_name), .cols = .sample)

  mcmc_data <- df |>
    dplyr::mutate(.cum_stat = cum_fns(df[[2]])) |>
    dplyr::rename_with(~paste0(., "_", cum_fns_name), .cols = .cum_stat) |>
    tidyr::pivot_longer(-sim_number) |>
    dplyr::mutate(name = factor(name, levels = fctr_lvl_nms))

  plt <- mcmc_data |>
    ggplot2::ggplot(ggplot2::aes(x = as.numeric(sim_number), y = value)) +
    ggplot2::facet_wrap(~name, scales = "free") +
    ggplot2::geom_line() +
    ggplot2::labs(
      y = "Value",
      x = "Simulation Number",
      title = "MCMC Sampling"
    ) +
    ggplot2::theme_minimal()

  # Return
  mcmc_list <- list(
    mcmc_data = mcmc_data,
    plt = plt
  )

  return(mcmc_list)
}
