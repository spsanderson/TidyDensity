#' Tidy Randomly Generated Gaussian Tibble
#'
#' @family Data Generator
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://data-flair.training/blogs/normal-distribution-in-r/}
#'
#' @details This function uses the underlying `stats::rnorm()` function to generate
#' data from the given parameters.
#'
#' @description
#'
#' @param .n The number of randomly generated points you want.
#' @param .mean The mean of the randomly generated data.
#' @param .sd The standard deviation of the randomly generated data.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_normal()
#'
#' @return
#' A tibble of randomly generated.
#'
#' @export
#'

tidy_normal <- function(.n = 50, .mean = 0, .sd = 1, .num_sims = 1){

    # Tidyeval ----
    n         <- as.integer(.n)
    num_walks <- as.integer(.num_sims)
    mu  <- as.numeric(.mean)
    std <- as.numeric(.sd)

    # Checks ----
    if(!is.integer(n) | n < 0){
        rlang::abort(
            "The parameters '.n' must be of class integer. Please pass a whole
            number like 50 or 100. It must be greater than 0."
        )
    }

    if(!is.integer(num_walks) | num_walks < 0){
        rlang::abort(
            "The parameter `.num_sims' must be of class integer. Please pass a
            whole number like 50 or 100. It must be greater than 0."
        )
    }

    if(!is.numeric(mu)){
        rlang::abort(
            "The parameters of '.mean' and '.sd' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
        )
    }

    if(!is.numeric(std)){
        rlang::abort(
            "The parameters of '.mean' and '.sd' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
        )
    }

    x <- seq(1, num_walks, 1)

    df <- dplyr::tibble(sim_number = as.factor(x)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = list(stats::rnorm(n, mu, std))) %>%
        tidyr::unnest(cols = c(x,y)) %>%
        dplyr::ungroup()


    # Attach descriptive attributes to tibble
    attr(df, ".mean") <- .mean
    attr(df, ".sd") <- .sd
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_gaussian"

    # Return final result as function output
    return(df)

}
