#' Prepare Student Performance Data
#'
#' Cleans and processes student performance data by handling missing values,
#' standardizing numeric variables, and assigning a custom class for further use.
#'
#' @param data A data frame containing the student performance data.

prepare_student_data <- function(data, scale = TRUE, handle_missing = "remove") {
  # Check for required columns
  required_cols <- c("math_score", "reading_score", "writing_score")
  missing_cols <- setdiff(required_cols, colnames(data))
  if (length(missing_cols) > 0) {
    stop(paste("Missing required columns:", paste(missing_cols, collapse = ", ")))
  }
}
