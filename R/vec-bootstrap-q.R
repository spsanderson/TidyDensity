#' Compute Bootstrap Q of a Vector
#'
#' @family Bootstrap
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the quantile of a vector.
#'
#' @description
#' This function takes in a vector as it's input and will return the quantile
#' of a vector.
#'
#' @param .x A numeric
#'
#' @examples
#' x <- mtcars$mpg
#'
#' bootstrap_q_vec(x)
#'
#' @return
#' A vector
#'
#' @export
#'

bootstrap_q_vec <- function(.x){

    x_term <- .x
    n <- length(x_term)

    if (!is.numeric(.x)){
        rlang::abort(
            message = "'.x' must be a numeric vector",
            use_cli_format = TRUE
        )
    }

    ret <- unname(
        stats::quantile(x_term, probs = seq(0, 1, 1 / (n - 1)), type = 1)
    )

    return(ret)
}
