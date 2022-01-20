#' Tidy Empirical
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function takes in a single argument of .x a vector
#'
#' @description This function takes in a single arguemtn of .x a vector and will
#' return a tibble of information similar to the `tidy_` distribution functions.
#' The `y` column is set equal to `dy` from the density function.
#'
#' @param .x A vector of numbers
#'
#' @examples
#' tidy_empirical(.x = 1:10)
#'
#' @return
#' A tibble
#'
#' @export
#'

tidy_empirical <- function(.x){

    x_term <- .x
    n <- length(x_term)

    if(!is.vector(x_term)){
        rlang::abort("You must pass a vector as the .x arguemtn to this function.")
    }

    dens_obj <- stats::density(1:n, n = n)
    dft <- data.frame(x = double(), y = double())
    for(i in 1:n){
        lower <- i - 1
        upper <- i
        y <- stats::integrate(
            stats::approxfun(dens_obj),
            lower = lower,
            upper = upper
        )$value
        tmp <- data.frame(x = i, y = y)
        dft <- rbind(dft, tmp)
    }

    p_vec <- dft$y

    df <- dplyr::tibble(sim_number = as.factor(1)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = NA) %>%
        dplyr::mutate(d = list(density(unlist(x), n = n)[c("x","y")] %>%
                                   purrr::set_names("dx","dy") %>%
                                   dplyr::as_tibble())) %>%
        dplyr::mutate(p = list(p_vec)) %>%
        dplyr::mutate(q = NA) %>%
        dplyr::mutate(y = list(d[[1]][["dy"]])) %>%
        tidyr::unnest(cols = c(x, y, d, p, q)) %>%
        dplyr::ungroup()

    q_vec <- stats::quantile(df$y, probs = seq(0, 1, 1/(n-1)), type = 1) %>%
        dplyr::as_tibble() %>%
        dplyr::rename("q" = "value")

    df <- df %>%
        dplyr::mutate(q = q_vec$q)

    attr(df, ".x") <- .x
    attr(df, "tibble_type") <- "tidy_empirical"

    # Return ----
    return(df)

}
