
# educationr2
### Written by Roxane Marine Van Olden Barneveld, Killian Harnett, Krisra Ritina and Ronan Lambe

<!-- badges: start -->
<!-- badges: end -->

educationr2 takes a data set consisting of the marks secured by the students in mathematics, reading and writing exams, along with information on gender, ethnicity, parental education level, lunch type, and participation in a test preparation course. It allows for analyzing the influence of these factors on academic performance. Three functions include

  1. `prepare_student_data()` method: this prepares the data. It tidys into a clear readable and usable format
  
  2. `plot_student_scores()` method for producing nice visualizations based on `ggplot2`.
  
  3. `summary.StudentData()` this method calculations summary statistics for (mean median etc) for the data set 

## Installation

You can install the development version of educationr2 from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("roxane-vnldn/educationr2")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(educationr2)
## basic example code
```

