#' Extract Distribution Type from Tidy Distribution Object
#'
#' @family Helper
#'
#' @author Steven P. Sanderson II,
#'
#' @details This will extract the distribution type from a `tidy_` distribution
#' function output using the attributes of that object. You must pass the attribute
#' directly to the function. It is meant really to be used internally.
#'
#' You should be passing if using manually the `$tibble_type` attribute.
#'
#' @description Get the distribution name in title case from the `tidy_` distribution
#' function.
#'
#' @param .x The attribute list passed from a `tidy_` distribution function.
#'
#' @examples
#'
#' tn <- tidy_normal()
#' atb <- attributes(tn)
#' dist_type_extractor(atb$tibble_type)
#'
#' @return A character string
#'
#' @export
#'

dist_type_extractor <- function(.x) {
  x_term <- as.character(.x)
  x_term <- tolower(x_term)
  x_term <- gsub("tidy_", "", x_term)
  x_term <- gsub("_", " ", x_term)
  x_term <- gsub(
    pattern = "\\b([[:alpha:]])([[:alpha:]]+)",
    replacement = "\\U\\1\\L\\2",
    x = x_term,
    perl = TRUE
  )

  return(x_term)
}
