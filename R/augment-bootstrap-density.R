#' Bootstrap Density Tibble
#'
#' @family Bootstrap
#' @family Augment Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function takes as input the output of the `tidy_bootstrap()` or
#' `bootstrap_unnest_tbl()` and returns an augmented tibble that has the following
#' columns added to it: _`x`_, _`y`_, _`dx`_, and _`dy`_.
#'
#' It looks for an attribute that comes from using `tidy_bootstrap()` or
#' `bootstrap_unnest_tbl()` so it will not work unless the data comes from one of
#' those functions.
#'
#' @description Add density information to the output of `tidy_bootstrap()`, and
#' `bootstrap_unnest_tbl()`.
#'
#' @param .data The data that is passed from the `tidy_bootstrap()` or
#' `bootstrap_unnest_tbl()` functions.
#'
#' @examples
#' x <- mtcars$mpg
#'
#' tidy_bootstrap(x) %>%
#'   bootstrap_density_augment()
#'
#' tidy_bootstrap(x) %>%
#'   bootstrap_unnest_tbl() %>%
#'   bootstrap_density_augment()
#'
#' @return
#' A tibble
#'
#' @export
#'

bootstrap_density_augment <- function(.data){

    atb <- attributes(.data)

    # Checks
    if (!is.data.frame(.data)){
        rlang::abort(
            message = "'.data' is expecting a data.frame/tibble. Please supply.",
            use_cli_format = TRUE
        )
    }

    if (!atb$tibble_type %in% c("tidy_bootstrap","tidy_bootstrap_nested")){
        rlang::abort(
            message = "Must pass data to this function from either tidy_bootstrap() or
      bootstrap_unnest_tbl().",
      use_cli_format = TRUE
        )
    }

    # Add density data
    if(atb$tibble_type == "tidy_bootstrap_nested"){
        df_tbl <- dplyr::as_tibble(.data) %>%
            TidyDensity::bootstrap_unnest_tbl()
    }

    if(atb$tibble_type == "tidy_bootstrap"){
        df_tbl <- dplyr::as_tibble(.data)
    }

    df_tbl <- df_tbl %>%
        dplyr::nest_by(sim_number) %>%
        dplyr::mutate(dens_tbl = list(
            stats::density(unlist(data),
                           n = nrow(data))[c("x","y")] %>%
                purrr::set_names("dx","dy") %>%
                dplyr::as_tibble())) %>%
        tidyr::unnest(cols = c(data, dens_tbl)) %>%
        dplyr::mutate(x = dplyr::row_number()) %>%
        dplyr::ungroup() %>%
        dplyr::select(sim_number, x, y, dx, dy, dplyr::everything())

    # Return
    attr(df_tbl, "tibble_type") <- "bootstrap_density"
    attr(df_tbl, "incoming_tibble_type") <- atb$tibble_type
    attr(df_tbl, ".num_sims") <- atb$.num_sims
    attr(df_tbl, "dist_with_params") <- atb$dist_with_params
    attr(df_tbl, "distribution_family_type") <- atb$distribution_family_type

    return(df_tbl)

}
