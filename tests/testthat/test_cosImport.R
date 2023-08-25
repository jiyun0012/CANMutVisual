library(testthat)
library(CANMutVisual)

context("Test if the input file is valid")

test_that("Invalid Input", {
  # Incorrect file type input for first argument
  expect_error(cosImport("inst/extdata/V95_38_MUTANT.csv", "data/HGNC.tsv"))
  # Incorrect file type for second argument
  expect_error(cosImport("data/MutantData.tsv", "inst/extdata/V95_38_MUTANT.csv"))
  # Incorrect input type for first argument
  expect_error(cosImport(2, "data/HGNC.tsv"))
  # Incorrect input type for second argument
  expect_error(cosImport("data/MutantData.tsv", "Hello"))

  })

context("Checking if the output value is correct")
test_that("output correct", {
  result <- cosImport("data/MutantData.tsv", "data/HGNC.tsv")
  # test is type is a list (dataframe consist of lists)
  expect_type(result, "list")
  # check if return value is dataframe
  expect_s3_class(result, "data.frame")
  # check is column values that the function read from the file are correct
  expect_identical(colnames(result), c("GENE_NAME", "ACCESSION_NUMBER",
                                       "GENE_CDS_LENGTH", "HGNC_ID",
                                       "SAMPLE_NAME", "GENOMIC_MUTATION_ID",
                                       "MUTATION_ID", "MUTATION_CDS",
                                       "MUTATION_AA", "MUTATION_DESCRIPTION",
                                       "SAMPLE_TYPE", "TUMOUR_ORIGIN", "IDsymbol"))
})
