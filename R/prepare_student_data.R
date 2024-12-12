#' Prepare Student Performance Data
#'
#' Cleans and processes student performance data by handling missing values,
#' standardizing numeric variables, converting non-score variables to factors,
#' and assigning a custom class for further use.
#'
#' @param data A data frame containing the student performance data. Columns ending with
#' \code{".score"} (e.g., \code{"math.score"}) are treated as numeric score variables.
#' Other columns are automatically converted to factors.
#' @param scale Logical; whether to standardize numeric score columns. Defaults to \code{TRUE}.
#' @param handle_missing How to handle missing values. Either \code{"remove"} to remove rows
#' with missing values or \code{"mean"} to impute with the mean of the column. Defaults to \code{"remove"}.
#' @return An object of class \code{"StudentData"}, which is a processed data frame ready
#' for analysis and plotting. Non-score variables are converted to factors for categorical representation.
#'
#' @export
#'
#' @examples
#' student_data <- data.frame(
#'   math.score = c(72, 69, NA, 47, 76),
#'   reading.score = c(72, 90, 95, 57, 78),
#'   writing.score = c(74, 88, 93, 44, 75),
#'   gender = c("female", "female", "female", "male", "male")
#' )
#' tidy_data <- prepare_student_data(student_data, scale = TRUE, handle_missing = "mean")
#' str(tidy_data) # Check the structure to see non-score variables converted to factors

prepare_student_data <- function(data, scale = TRUE, handle_missing = "remove") {
  # Check for required columns
  required_cols <- c("math.score", "reading.score", "writing.score")
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

  # Convert non-score variables to factors
  score_columns <- grep("\\.score$", colnames(data), value = TRUE)
  non_score_columns <- setdiff(colnames(data), score_columns)
  data[non_score_columns] <- lapply(data[non_score_columns], as.factor)

  # Standardize column names
  colnames(data) <- gsub(" ", "_", tolower(colnames(data)))

  # Scale numeric variables if required
  if (scale) {
    numeric_cols <- sapply(data, is.numeric)
    data[, numeric_cols] <- scale(data[, numeric_cols])
  }

  # Assign custom class
  class(data) <- c("StudentData", class(data))

  return(data)
}
