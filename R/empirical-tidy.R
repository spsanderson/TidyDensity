#' Tidy Empirical
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function takes in a single argument of .x a vector
#'
#' @description This function takes in a single argument of .x a vector and will
#' return a tibble of information similar to the `tidy_` distribution functions.
#' The `y` column is set equal to `dy` from the density function.
#'
#' @param .x A vector of numbers
#' @param .num_sims How many simulations should be run, defaults to 1.
#' @param .distribution_type A string of either "continuous" or "discrete". The
#' function will default to "continuous"
#'
#' @examples
#' x <- mtcars$mpg
#' tidy_empirical(.x = x, .distribution_type = "continuous")
#' tidy_empirical(.x = x, .num_sims = 10, .distribution_type = "continuous")
#'
#' @return
#' A tibble
#'
#' @export
#'

tidy_empirical <- function(.x, .num_sims = 1, .distribution_type = "continuous") {
    x_term <- .x
    n <- length(x_term)
    dist_type <- tolower(as.character(.distribution_type))
    num_sims = as.integer(.num_sims)

    if (!is.vector(x_term)) {
        rlang::abort("You must pass a vector as the .x argument to this function.")
    }

    if (!dist_type %in% c("continuous","discrete")){
        rlang::abort("You must choose either 'continuous' or 'discrete'.")
    }

    ## New P
    e <- stats::ecdf(x_term)

    df <- dplyr::tibble(sim_number = as.factor(1:num_sims)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = ifelse(
            num_sims == 1,
            list(x_term),
            list(sample(x_term, replace = TRUE))
        )) %>%
        dplyr::mutate(d = list(density(unlist(y), n = n)[c("x", "y")] %>%
                                   purrr::set_names("dx", "dy") %>%
                                   dplyr::as_tibble())) %>%
        dplyr::mutate(p = list(e(unlist(y)))) %>%
        dplyr::mutate(q = NA) %>%
        tidyr::unnest(cols = c(x, y, d, p, q)) %>%
        dplyr::ungroup()

    q_vec <- df %>%
        dplyr::select(sim_number, y) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(
            q = rep(
                stats::quantile(y, probs = seq(0, 1, 1 / (n - 1)), type = 1),
                1
            )
        ) %>%
        dplyr::ungroup() %>%
        dplyr::select(q)

    df <- df %>%
        dplyr::mutate(q = q_vec$q)

    # Attach descriptive attributes to tibble
    attr(df, "distribution_family_type") <- dist_type
    attr(df, ".x") <- .x
    attr(df, ".n") <- n
    attr(df, ".num_sims") <- num_sims
    attr(df, "tibble_type") <- "tidy_empirical"
    attr(df, "dist_with_params") <- "Empirical"

    # Return ----
    return(df)
}

# tidy_empirical <- function(.x) {
#   x_term <- .x
#   n <- length(x_term)
#
#   if (!is.vector(x_term)) {
#     rlang::abort("You must pass a vector as the .x arguemtn to this function.")
#   }
#
#   dens_obj <- stats::density(1:n, n = n)
#   dft <- data.frame(x = double(), y = double())
#   for (i in 1:n) {
#     lower <- i - 1
#     upper <- i
#     y <- stats::integrate(
#       stats::approxfun(dens_obj),
#       lower = lower,
#       upper = upper
#     )$value
#     tmp <- data.frame(x = i, y = y)
#     dft <- rbind(dft, tmp)
#   }
#
#   p_vec <- dft$y
#
#   df <- dplyr::tibble(sim_number = as.factor(1)) %>%
#     dplyr::group_by(sim_number) %>%
#     dplyr::mutate(x = list(1:n)) %>%
#     dplyr::mutate(y = NA) %>%
#     dplyr::mutate(d = list(density(unlist(x), n = n)[c("x", "y")] %>%
#       purrr::set_names("dx", "dy") %>%
#       dplyr::as_tibble())) %>%
#     dplyr::mutate(p = list(p_vec)) %>%
#     dplyr::mutate(q = NA) %>%
#     dplyr::mutate(y = list(d[[1]][["dy"]])) %>%
#     tidyr::unnest(cols = c(x, y, d, p, q)) %>%
#     dplyr::ungroup()
#
#   q_vec <- stats::quantile(df$y, probs = seq(0, 1, 1 / (n - 1)), type = 1) %>%
#     dplyr::as_tibble() %>%
#     dplyr::rename("q" = "value")
#
#   df <- df %>%
#     dplyr::mutate(q = q_vec$q)
#
#   attr(df, ".x") <- .x
#   attr(df, ".n") <- n
#   attr(df, ".num_sims") <- 1L
#   attr(df, "tibble_type") <- "tidy_empirical"
#   attr(df, "dist_with_params") <- "Empirical"
#
#   # Return ----
#   return(df)
# }
