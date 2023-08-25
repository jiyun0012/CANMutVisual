library(testthat)
library(CANMutVisual)

# validity of input files are already tested in cosImport test, so skipped.

context("Check if output value is valid")

test_that("output test", {
  result <- countMut("data/MutantData.tsv", "data/HGNC.tsv")

  #test if return value is dataframe consisting of lists
  expect_type(result, "list")
  expect_s3_class(result, "data.frame")

  # check column names of the dataframe
  expect_identical(colnames(result), c("symbol_gene", "Freq"))

})
