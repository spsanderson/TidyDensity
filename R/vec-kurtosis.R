#' Compute Kurtosis of a Vector
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @family Statistic
#' @family Vector Function
#'
#' @details
#' A function to return the kurtosis of a vector.
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Kurtosis}
#'
#' @description
#' This function takes in a vector as it's input and will return the kurtosis
#' of that vector. The length of this vector must be at least four numbers. The
#' kurtosis explains the sharpness of the peak of a distribution of data.
#'
#' `((1/n) * sum(x - mu})^4) / ((()1/n) * sum(x - mu)^2)^2`
#'
#' @param .x A numeric vector of length four or more.
#'
#' @examples
#' tidy_kurtosis_vec(rnorm(100, 3, 2))
#'
#' @return
#' The kurtosis of a vector
#'
#' @export
#'

tidy_kurtosis_vec <- function(.x){

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
    n              <- length(x_term)
    mu             <- mean(x_term, na.rm = TRUE)
    n_diff         <- (x_term - mu)^4
    nu             <- (1/n * sum(n_diff))
    d_diff         <- (x_term - mu)^2
    de             <- (1/n * sum(d_diff))^2
    k              <- nu/de
    return(k)
    print(k)
}
