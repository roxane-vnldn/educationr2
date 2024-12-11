#' Prepare Student Performance Data
#'
#' Cleans and processes student performance data by handling missing values,
#' standardizing numeric variables, and assigning a custom class for further use.
#'
#' @param data A data frame containing the student performance data.
#' @param scale Logical; whether to standardize numeric columns. Defaults to \code{TRUE}.
#' @param handle_missing How to handle missing values. Either \code{"remove"} to remove rows
#' with missing values or \code{"mean"} to impute with the mean of the column. Defaults to \code{"remove"}.
#' @return An object of class \code{"StudentData"}, which is a processed data frame ready
#' for analysis and plotting.
#'
#' @export

prepare_student_data <- function(data, scale = TRUE, handle_missing = "remove") {
  # Check for required columns
  required_cols <- c("math_score", "reading_score", "writing_score")
  missing_cols <- setdiff(required_cols, colnames(data))
  if (length(missing_cols) > 0) {
    stop(paste("Missing required columns:", paste(missing_cols, collapse = ", ")))
  }
  # Handle missing values
  if (handle_missing == "remove") {
    data <- na.omit(data)
  } else if (handle_missing == "mean") {
    data <- data.frame(lapply(data, function(col) {
      if (is.numeric(col)) {
        col[is.na(col)] <- mean(col, na.rm = TRUE)
      }
      return(col)
    }))
  } else {
    stop("Invalid option for handle_missing. Use 'remove' or 'mean'.")
  }
}
# Scale numeric variables if required
if (scale) {
  numeric_cols <- sapply(data, is.numeric)
  data[, numeric_cols] <- scale(data[, numeric_cols])


# Assign custom class
class(data) <- c("StudentData", class(data))

return(data)
}
