#' Convert Data to Time Series Format
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description This function converts data in a data frame or tibble into a time series format. It is designed to
#' work with data generated from `tidy_` distribution functions. The function can return time series data, pivot it
#' into long format, or both.
#'
#' @details
#' The function takes a data frame or tibble as input and processes it based on the specified options.
#' It performs the following actions:
#' 1. Checks if the input is a data frame or tibble; otherwise, it raises an error.
#' 2. Checks if the data comes from a `tidy_` distribution function; otherwise, it raises an error.
#' 3. Converts the data into a time series format, grouping it by "sim_number" and transforming the "y" column into a time series.
#' 4. Returns the result based on the chosen options:
#'    - If `ret_ts` is set to TRUE, it returns the time series data.
#'    - If `pivot_longer` is set to TRUE, it pivots the data into long format.
#'    - If both options are set to FALSE, it returns the data as a tibble.
#'
#' @param .data A data frame or tibble to be converted into a time series format.
#' @param .return_ts A logical value indicating whether to return the time series data. Default is TRUE.
#' @param .pivot_longer A logical value indicating whether to pivot the data into long format. Default is FALSE.
#'
#' @examples
#' # Example 1: Convert data to time series format without returning time series data
#' x <- tidy_normal()
#' result <- convert_to_ts(x, FALSE)
#' head(result)
#'
#' # Example 2: Convert data to time series format and pivot it into long format
#' x <- tidy_normal()
#' result <- convert_to_ts(x, FALSE, TRUE)
#' head(result)
#'
#' # Example 3: Convert data to time series format and return the time series data
#' x <- tidy_normal()
#' result <- convert_to_ts(x)
#' head(result)
#'
#' @return
#' The function returns the processed data based on the chosen options:
#' - If `ret_ts` is set to TRUE, it returns time series data.
#' - If `pivot_longer` is set to TRUE, it returns the data in long format.
#' - If both options are set to FALSE, it returns the data as a tibble.
#'
#' @name convert_to_ts
NULL

#' @export
#' @rdname convert_to_ts
convert_to_ts <- function(.data, .return_ts = TRUE, .pivot_longer = FALSE){

    # Data
    df <- .data

    # Attributes of incoming df
    atb <- attributes(df)

    # Checks
    if (!is.data.frame(.data)){
        rlang::abort(
            message = "The .data argument requires a data.frame/tibble.",
            use_cli_format = TRUE
        )
    }

    if (!"tibble_type"%in% names(atb)){
        rlang::abort(
            message = "The data passed must come from a `tidy_` distribution function.",
            use_cli_format = TRUE
        )
    }

    # Variables
    ret_ts <- as.logical(.return_ts)
    pvt_long <- as.logical(.pivot_longer)

    # Manipulation
    df <- df |>
        base::split(~ sim_number) |>
        base::lapply(function(x) x[,"y"] |>
                         stats::ts())
    df <- base::do.call(cbind, df)

    # Return TS
    if (ret_ts){return(df)}

    # Return tibble
    if (!ret_ts & !pvt_long){
        df <- df |>
            dplyr::as_tibble()
        return(df)
    }

    # Return long tibble
    if (!ret_ts & pvt_long & ncol(df) > 1){
        df <- df |>
            dplyr::as_tibble() |>
            tidyr::pivot_longer(cols = tidyr::everything()) |>
            dplyr::arrange(as.numeric(name)) |>
            purrr::set_names("sim_number","y")
        return(df)
    }

    if (!ret_ts & pvt_long & ncol(df) == 1){
        df <- df |>
            dplyr::as_tibble()
        return(df)
    }
}
