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
#' A numeric vector. Note: The first entry will always be
#' NaN.
#'
#' @export
#'

cvar <- function(.x) {
  n <- length(.x)
  csumx <- base::cumsum(.x)
  cmeanx <- cmean(.x)

  p1 <- base::cumsum(.x^2)
  p2 <- -2 * cmeanx * csumx
  p3 <- (1:n) * cmeanx^2
  (p1 + p2 + p3) / ((1:n) - 1)
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

cskewness <- function(.x) {
  n <- length(.x)

  if (n == 0L) {
    return(.x)
  } else if (n == 1L) {
    return(0)
  }

  m2 <- m3  <- term1 <- 0
  out <- numeric(n)
  out[1] <- NaN
  m1 <- .x[1]

  for (i in 2:n) {
    n0 <- i - 1
    delta <- x[i] - m1
    delta_n <- delta/i
    m1 <- m1 + delta_n
    term1 <- delta*delta_n*n0
    m3 <- m3 + term1*delta_n*(n0 - 1) - 3*delta_n*m2
    m2 <- m2 + term1
    out[i] <- sqrt(i)*m3/m2^1.5
  }

  out
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

ckurtosis <- function(.x) {
  kurtosis <- function(.x) {
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
#' A numeric vector. Note: The first entry will always be
#' NaN.
#'
#' @export
#'

csd <- function(.x) {
  sqrt(cvar(.x))
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

cmedian <- function(.x) {
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

cgmean <- function(.x) {
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

chmean <- function(.x) {
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

cmean <- function(.x) {
  dplyr::cummean(.x)
}
