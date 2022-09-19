#' Cumulative Variance
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative variance of a vector.
#' `exp(cummean(log(.x)))`
#'
#' @description
#' A function to return the cumulative variance of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cvar(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

cvar <- function(.x){
    sapply(seq_along(.x), function(k, z) stats::var(z[1:k]), z = .x)
}

#' Cumulative Skewness
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative skewness of a vector.
#'
#' @description
#' A function to return the cumulative skewness of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cskewness(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

cskewness <- function(.x){
    skewness <- function(.x){
        sqrt(length(.x)) * sum((.x - mean(.x))^3) / (sum((.x - mean(.x))^2)^(3/2))
    }
    sapply(seq_along(.x), function(k, z) skewness(z[1:k]), z = .x)
}

#' Cumulative Kurtosis
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative kurtosis of a vector.
#'
#' @description
#' A function to return the cumulative kurtosis of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' ckurtosis(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

ckurtosis <- function(.x){
    kurtosis <- function(.x){
        length(.x) * sum((.x - mean(.x))^4) / (sum((.x - mean(.x))^2)^2)
    }
    sapply(seq_along(.x), function(k, z) kurtosis(z[1:k]), z = .x)
}

#' Cumulative Standard Deviation
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative standard deviation of a vector.
#'
#' @description
#' A function to return the cumulative standard deviation of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' csd(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

csd <- function(.x){
    sapply(seq_along(.x), function(k, z) stats::sd(z[1:k]), z = .x)
}

#' Cumulative Median
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative median of a vector.
#'
#' @description
#' A function to return the cumulative median of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cmedian(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

cmedian <- function(.x){
    sapply(seq_along(.x), function(k, z) stats::median(z[1:k]), z = .x)
}

#' Cumulative Geometric Mean
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative geometric mean of a vector.
#' `exp(cummean(log(.x)))`
#'
#' @description
#' A function to return the cumulative geometric mean of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cgmean(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

cgmean <- function(.x){
    exp(cmean(log(.x)))
}

#' Cumulative Harmonic Mean
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative harmonic mean of a vector.
#' `1 / (cumsum(1 / .x))`
#'
#' @description
#' A function to return the cumulative harmonic mean of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' chmean(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

chmean <- function(.x){
    1 / (cumsum(1 / .x))
}

#' Cumulative Mean
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative mean of a vector. It uses [dplyr::cummean()]
#' as the basis of the function.
#'
#' @description
#' A function to return the cumulative mean of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cmean(x)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

cmean <- function(.x){
    dplyr::cummean(.x)
}
