#' Summarize students performances
#'
#'This function computes summary statistics (e.g., mean, min, max) for student performance metrics (math.score, writing.score, and reading.score) grouped by specified categorical variables in a dataset.
#'
#' @param obj A dataset of class \code{StudentData} containing
#'  at least the variables \code{math.score}, \code{writing.score}, and \code{reading.score}.
#'  Other variables may be used as grouping variables.
#' @param group_var A character vector specifying the column name(s) to group the data by.
#' @param summary_func A function to summarize each numeric variable
#'  (e.g., \code{mean}, \code{min}, or \code{max}). The function is applied to
#'  \code{math.score}, \code{writing.score}, and \code{reading.score} within each group
#'  defined by \code{group_var}. Defaults to \code{mean}
#'
#' @return A \code{tibble} containing the grouped data and the summarized statistics for
#'  \code{math.score}, \code{writing.score}, and \code{reading.score}.
#' @importFrom dplyr "filter" "group_by" "summarise_all" "all_of" "across"
#' @importFrom tibble "as_tibble"
#' @export
#'
#' @examples
#' data(students)
#' data <- prepare_student_data(students, scale = FALSE)
#' summary(obj = data, group_var = c("gender", "lunch"), summary_func = median)
summary.StudentData <- function(obj,
                                group_var,
                                summary_func = mean) {

  variable <- colnames(obj)
  grp_variable <- setdiff(variable, c("math.score", "writing.score", "reading.score"))

  if (!all(group_var %in% grp_variable)) stop("One of the grouping variable do not exist in the dataset.")


  obj |>
    dplyr::select(dplyr::all_of(group_var), math.score, reading.score, writing.score) |>
    dplyr::group_by(dplyr::across(dplyr::all_of(group_var))) |>
    dplyr::summarise_all(summary_func) |>
    tibble::as_tibble()

}
