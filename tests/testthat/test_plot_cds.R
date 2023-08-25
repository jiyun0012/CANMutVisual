library(testthat)
library(CANMutVisual)

context("Test if the input file is valid")

test_that("Invalid Input", {
  # Incorrect file type input for first argument
  expect_error(plot_cds("inst/extdata/V95_38_MUTANT.csv", "data/HGNC.tsv"))
  # Incorrect file type for second argument
  expect_error(plot_cds("data/MutantData.tsv", "inst/extdata/V95_38_MUTANT.csv"))
  # Incorrect input type for first argument
  expect_error(plot_cds(2, "data/HGNC.tsv"))
  # Incorrect input type for second argument
  expect_error(plot_cds("data/MutantData.tsv", "Hello"))

})

context("Check if plot is returned")

test_that("test is pie chart is returned", {
  result <- plot_cds("data/MutantData.tsv", "data/HGNC.tsv")

  # Check if return value is not null
  expect_true(!is.null(result))
})
