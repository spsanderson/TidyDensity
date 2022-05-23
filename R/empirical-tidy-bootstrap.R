#' Bootstrap Empirical Data
#'
#' @family Bootstrap
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will take in a numeric input vector and produce a tibble
#' of bootstrapped values in a list. The table that is output will have two columns:
#' `sim_number` and `bootstrap_samples`
#'
#' The `sim_number` corresponds to how many times you want the data to be resampled,
#' and the `bootstrap_samples` column contains a list of the boostrapped resampled
#' data.
#'
#' @description Takes an input vector of numeric data and produces a bootstrapped
#' nested tibble by simulation number.
#'
#' @param .x The vector of data being passed to the function. Must be a numeric
#' vector.
#' @param .num_sims The default is 2000, can be set to anything desired. A warning
#' will pass to the console if the value is less than 2000.
#' @param .proportion How much of the original data do you want to pass through
#' to the sampling function. The default is 0.80 (80%)
#' @param .distribution_type This can either be 'continuous' or 'discrete'
#'
#' @examples
#' x <- mtcars$mpg
#' tidy_bootstrap(x)
#'
#' @return
#' A nested tibble
#'
#' @export
#'

tidy_bootstrap <- function(.x, .num_sims = 2000, .proportion = 0.8,
                           .distribution_type = "continuous"){

    # Tidyeval ----
    x_term <- as.numeric(.x)
    n <- length(x_term)
    dist_type <- tolower(as.character(.distribution_type))
    num_sims <- as.integer(.num_sims)
    size <- as.numeric(.proportion)

    # Checks ----
    if (!is.vector(x_term)) {
        rlang::abort(
            message = "You must pass a vector as the .x argument to this function.",
            use_cli_format = TRUE
        )
    }

    if (size < 0 | size > 1){
        rlang::abort(
            message = "The '.proportion' parameter must be between 0 and 1 inclusive.",
            use_cli_format = TRUE
        )
    }

    if (!dist_type %in% c("continuous","discrete")){
        rlang::abort(
            message = "You must choose either 'continuous' or 'discrete'.",
            use_cli_format = TRUE
        )
    }

    if (num_sims < 2000){
        rlang::warn(
            message = "Setting '.num_sims' to less than 2000 means that results can be
      potentially unstable. Consider setting to 2000 or more.",
            use_cli_format = TRUE
        )
    }

    # Data ----
    df <- dplyr::tibble(sim_number = as.factor(1:num_sims)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(bootstrap_samples = list(
            sample(x = x_term, size = floor(size * n) ,replace = TRUE)
          )
        ) %>%
        dplyr::ungroup()

    # Attach descriptive attributes to tibble
    attr(df, "distribution_family_type") <- dist_type
    attr(df, ".x") <- .x
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_bootstrap_nested"
    attr(df, "dist_with_params") <- "Empirical"

    # Return ----
    return(df)

}
