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
  # rescale `y` to avoid detrimental impacts by outliers
  y <- scale(.x)
  # cumulative length of y
  k <- seq_along(y)
  # cumulative n-th raw moments of y
  m3 <- cumsum(y^3)
  m2 <- cumsum(y^2)
  m1 <- cumsum(y)
  u <- m1 / k
  # expand cubic terms and refactor skewness in terms of num/den
  num <- (m3 - 3 * u * m2 + 3 * u^2 * m1 - k * u^3) / k
  den <- sqrt((m2 + k * u^2 - 2 * u * m1) / k)^3
  c(NaN, (num / den)[-1])
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
  x <- scale(.x)
  k <- seq_along(x)
  # Cumulative nth raw moment
  m4 <- cumsum(x^4)
  m3 <- cumsum(x^3)
  m2 <- cumsum(x^2)
  m1 <- cumsum(x)
  u <- m1 / k
  # Expand quartic terms and refactor kurtosis in terms of num/den
  num <- (m4 - 4 * u * m3 + 6 * u^2 * m2 - 4 * u^3 * m1 + k * u^4) / k
  den <- (m2 + k * u^2 - 2 * u * m1) / k
  c(NaN, (num / den^2)[-1])
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
