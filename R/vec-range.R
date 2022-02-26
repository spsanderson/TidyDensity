#' Get the range statistic
#'
#' @family Statistic
#'
#' @author Steven P. Sandeson II, MPH
#'
#' @description Takes in a numeric vector and returns back the range of that
#' vector
#'
#' @details Takes in a numeric vector and returns the range of that vector using
#' the `diff` and `range` functions.
#'
#' @param .x A numeric vector
#'
#' @examples
#' tidy_range_statistic(seq(1:10))
#'
#' @return
#' A single number, the range statistic
#'
#' @export
#'

tidy_range_statistic <- function(.x){

    # Tidyeval ----
    x_term <- .x

    if(!is.numeric(x_term)){
        stop(call. = FALSE, ".x must be a numeric vector.")
    }

    range_statistic <- base::diff(base::range(x_term))

    return(range_statistic)

}
