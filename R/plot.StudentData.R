#' Plot Student Performances - Student performance compared to various variables
#'
#' Plots the subject scores against your chosen categorical variable in 3 ways, "violin", "boxplot" or "barplot".
#'
#' @param data A data-frame containing numeric variables for test scores (e.g. \code{"math.score"}),
#' and categorical variables that have been converted to factors (e.g. \code{"gender"}).
#' @param categorical_var A chosen categorical variable from the dataset (e.g. \code{"gender"}).
#' @param plot_type 3 different types of plots for analysis (e.g. \code{"boxplot"}).
#'
#' @importFrom ggplot2 "ggplot" "aes_string" "geom_boxplot" "geom_bar" "geom_violin" "ggtitle" "theme"
#' @importFrom tidyr "gather"
#'
#'
#' @return A plot, either boxplot, violin or barplot of the \code{"math.score"}, \code{"reading.score"},
#' or \code{"writing.score"}, compared to the chosen categorical variable (e.g. \code{"gender"}) for analysis.
#' @export
#'
#' @examples
#' data(students)
#' data <- prepare_student_data(students)
#' plot.StudentData(data, "gender", "boxplot")
#'
#'
#'
plot.StudentData <- function(data,
                                categorical_var,
                                plot_type = "boxplot") {

  #Check if the categorical variable exists in the dataset
  if (!categorical_var %in% colnames(data)) {
    stop(paste("Categorical variable", categorical_var, "not found in data."))
  }

  #Check if the categorical variable is a factor
  if (!is.factor(data[[categorical_var]]) && !is.character(data[[categorical_var]])) {
    stop(paste("The variable", categorical_var, "is not a factor or character. Please ensure it's a categorical variable."))
  }

  #Stack scores into one column
  melted_data <- tidyr::gather(data, key = "Subject", value = "Score", math.score, reading.score, writing.score)

  #Initialize ggplot
  p <- ggplot2::ggplot(melted_data, ggplot2::aes_string(x = categorical_var, y = "Score", fill = "Subject")) +
    ggplot2::theme_minimal()

  #Add plot type based on user choice
  if (plot_type == "boxplot") {
    p <- p + ggplot2::geom_boxplot(position = ggplot2::position_dodge(width = 0.8), width = 0.6)
    p <- p + ggplot2::ggtitle(paste("Boxplot of Student Test Scores by", categorical_var))

  } else if (plot_type == "violin") {
    p <- p + ggplot2::geom_violin(position = ggplot2::position_dodge(width = 0.8))
    p <- p + ggplot2::ggtitle(paste("Violin Plot of Student Test Scores by", categorical_var))

  } else if (plot_type == "barplot") {
    p <- p + ggplot2::geom_bar(stat = "summary", fun = "mean", position = ggplot2::position_dodge(width = 0.8), width = 0.6)
    p <- p + ggplot2::ggtitle(paste("Bar Plot of Student Test Scores by", categorical_var))

  } else {
    stop(paste("Invalid plot type", plot_type, ". Choose from 'boxplot', 'violin', or 'barplot'."))
  }

  # Display the plot
  print(p)
}
