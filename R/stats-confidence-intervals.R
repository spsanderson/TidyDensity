#' Confidence Interval Generic
#'
#' @family Statistic
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Gets the lower 2.5% quantile of a numeric vector.
#'
#' @description Gets the lower 2.5% quantile of a numeric vector.
#'
#' @param .x A vector of numeric values
#' @param .na_rm A Boolean, defaults to FALSE. Passed to the quantile function.
#'
#' @return
#' A numeric value.
#'
#' @examples
#' x <- mtcars$mpg
#' ci_lo(x)
#'
#' @export
#'

ci_lo <- function(.x, .na_rm = FALSE){

    na_rm <- as.logical(.na_rm)
    x_term <- .x

    ret <- unname(stats::quantile(x_term, 0.025, na.rm = na_rm))

    return(ret)
}

#' Confidence Interval Generic
#'
#' @family Statistic
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Gets the upper 97.5% quantile of a numeric vector.
#'
#' @description Gets the upper 97.5% quantile of a numeric vector.
#'
#' @param .x A vector of numeric values
#' @param .na_rm A Boolean, defaults to FALSE. Passed to the quantile function.
#'
#' @return
#' A numeric value.
#'
#' @examples
#' x <- mtcars$mpg
#' ci_hi(x)
#'
#' @export
#'

ci_hi <- function(.x, .na_rm = FALSE){

    na_rm <- as.logical(.na_rm)
    x_term <- .x

    ret <- unname(stats::quantile(x_term, 0.975, na.rm = na_rm))

    return(ret)
}
