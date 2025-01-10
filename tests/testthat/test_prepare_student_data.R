library(educationr2)

test_that("prepare_student_data produces valid data", {
  expect_error(prepare_student_data(students[,-c(6:8)]))
  expect_s3_class(prepare_student_data(students), "StudentData")
})
