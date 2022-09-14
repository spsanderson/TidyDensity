#' Compute Skewness of a Vector
#'
#' @family Bootstrap
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the ecdf probability of a vector.
#'
#' @description
#' This function takes in a vector as it's input and will return the ecdf probability
#' of a vector.
#'
#' @param .x A numeric
#'
#' @examples
#' x <- mtcars$mpg
#'
#' bootstrap_p_vec(x)
#'
#' @return
#' A vector
#'
#' @export
#'

bootstrap_p_vec <- function(.x){

    # Tidyeval ----
    x_term <- .x

    # Checks ----
    if (!is.numeric(x)){
        rlang::abort(
            message = "'.x' must be a numeric vector",
            use_cli_format = TRUE
        )
    }

    # Get ecdf
    e <- stats::ecdf(x_term)

    # Return ----
    ret <- e(x_term)

    return(ret)

}
