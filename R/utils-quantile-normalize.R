#' Perform quantile normalization on a numeric matrix/data.frame
#'
#' @family Utility
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description This function will perform quantile normalization on two or more
#' distributions of equal length. Quantile normalization is a technique used to make the distribution of values across different samples
#' more similar. It ensures that the distributions of values for each sample have the same quantiles.
#' This function takes a numeric matrix as input and returns a quantile-normalized matrix.
#'
#' @param .data A numeric matrix where each column represents a sample.
#' @param .return_tibble A logical value that determines if the output should be a tibble. Default is 'FALSE'.
#'
#' @return A numeric matrix (or tibble if .return_tibble = TRUE) that has been quantile normalized.
#' Each column represents a sample, and the quantile normalization ensures that the distributions
#' of values for each sample have the same quantiles.
#'
#' @details
#' This function performs quantile normalization on a numeric matrix by following these steps:
#' \enumerate{
#'   \item Sort each column of the input matrix.
#'   \item Calculate the mean of each row across the sorted columns.
#'   \item Replace each column's sorted values with the row means.
#'   \item Unsort the columns to their original order.
#' }
#'
#' @examples
#' # Create a sample numeric matrix
#' data <- matrix(rnorm(20), ncol = 4)
#'
#' # Perform quantile normalization
#' normalized_data <- quantile_normalize(data)
#' normalized_data
#'
#' as.data.frame(normalized_data) |>
#'   sapply(function(x) quantile(x, probs = seq(0, 1, 1 / 4)))
#'
#' quantile_normalize(
#' data.frame(rnorm(30),
#'            rnorm(30)),
#'            .return_tibble = TRUE)
#'
#' @seealso
#' \code{\link{rowMeans}}: Calculate row means.
#'
#' \code{\link{apply}}: Apply a function over the margins of an array.
#'
#' \code{\link{order}}: Order the elements of a vector.
#'
#' @name quantile_normalize
NULL

#' @export
#' @rdname quantile_normalize
quantile_normalize <- function(.data, .return_tibble = FALSE) {
  # Check if input is a matrix or data frame
  if (!is.matrix(.data) && !is.data.frame(.data)) {
    stop("Input must be a matrix or data frame.")
  }
  
  # Convert data frame to matrix for processing
  if (is.data.frame(.data)) {
    data <- as.matrix(.data)
  } else {
    data <- .data
  }
  
  # Check if data is numeric
  if (!is.numeric(data)) {
    stop("Input data must be numeric.")
  }
  
  # Check for valid dimensions
  if (nrow(data) == 0 || ncol(data) == 0) {
    stop("Input data must have non-zero rows and columns.")
  }
  
  # Handle missing values
  if (any(is.na(data))) {
    warning("Missing values (NA) detected. They will be ignored during ranking but preserved in output structure.")
  }
  
  # Get dimensions
  n_rows <- nrow(data)
  n_cols <- ncol(data)
  
  # Create a matrix to store ranks
  ranks <- matrix(NA, nrow = n_rows, ncol = n_cols)
  
  # Rank each column, handling ties with the average method
  for (j in 1:n_cols) {
    ranks[, j] <- rank(data[, j], na.last = "keep", ties.method = "average")
  }
  
  # Sort each column and handle NAs
  sorted_data <- matrix(NA, nrow = n_rows, ncol = n_cols)
  sort_indices <- matrix(NA, nrow = n_rows, ncol = n_cols)
  
  for (j in 1:n_cols) {
    # Get indices for non-NA values
    non_na_indices <- which(!is.na(data[, j]))
    if (length(non_na_indices) > 0) {
      # Sort only non-NA values
      sorted_order <- order(data[non_na_indices, j])
      sorted_data[1:length(non_na_indices), j] <- data[non_na_indices[sorted_order], j]
      sort_indices[1:length(non_na_indices), j] <- non_na_indices[sorted_order]
    }
  }
  
  # Compute the mean of each row across sorted columns (ignoring NAs)
  row_means <- rowMeans(sorted_data, na.rm = TRUE)
  
  # If all values in a row are NA, set row mean to NA
  row_means[!is.finite(row_means)] <- NA
  
  # Create output matrix
  normalized_data <- matrix(NA, nrow = n_rows, ncol = n_cols)
  
  # Put the row means back in the original order for each column
  for (j in 1:n_cols) {
    # Get indices for non-NA values
    non_na_indices <- which(!is.na(data[, j]))
    if (length(non_na_indices) > 0) {
      # Place row means in original positions of non-NA values
      normalized_data[sort_indices[1:length(non_na_indices), j], j] <- row_means[1:length(non_na_indices)]
    }
  }
  
  # Preserve row and column names
  dimnames(normalized_data) <- dimnames(data)
  
  # Should output be a tibble?
  if (.return_tibble) {
    normalized_data <- dplyr::as_tibble(normalized_data)
  }
  
  return(normalized_data)
}
