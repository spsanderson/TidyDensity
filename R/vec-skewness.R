#' Compute Skewness of a Vector
#'
#' @family Statistic
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the skewness of a vector.
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Skewness}
#'
#' @description
#' This function takes in a vector as it's input and will return the skewness
#' of that vector. The length of this vector must be at least four numbers. The
#' skewness explains the 'tailedness' of the distribution of data.
#'
#' `((1/n) * sum(x - mu})^3) / ((()1/n) * sum(x - mu)^2)^(3/2)`
#'
#' @param .x A numeric vector of length four or more.
#'
#' @examples
#' tidy_skewness_vec(rnorm(100, 3, 2))
#'
#' @return
#' The skewness of a vector
#'
#' @export
#'

tidy_skewness_vec <- function(.x){

    # Tidyeval ----
    x_term <- .x

    # Checks ----
    if(!is.numeric(x_term)){
        stop(call. = FALSE, ".x must be a numeric vector.")
    }

    if(length(x_term) < 4){
        stop(call. = FALSE, ".x must be a numeric vector of 4 or more.")
    }

    # Calculate
    n      <- length(x_term)
    mu     <- mean(x_term, na.rm = TRUE)
    n_diff <- (x_term - mu)^3
    nu     <- (1/n * sum(n_diff))
    d_diff <- (x_term - mu)^2
    de     <- (1/n * sum(d_diff))^(3/2)
    s      <- nu/de
    return(s)
    print(s)
}
