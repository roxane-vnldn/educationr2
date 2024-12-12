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
