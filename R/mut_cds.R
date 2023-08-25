#' Returns gene name and frequency of each gene types
#'
#' mut_cds function uses cosImport function in cosImport.R file to read from
#' cosmic file and uses that dataframe to obtain MUTATION_CDS column
#' The last three letters are extracted and compared with mutValue list and unmatched
#' elements are deleted. Then, dataframe with two columns returned.
#'
#' @param mutFile A .tsv file containing COSMIC point mutations
#' @param hgncFile A .tsv file with complete approved human gene nomenclature IDs
#'
#' @return Returns dataframe with MUTATION_CDS and each of its frequency.
#'
#' @examples
#' # Using data files available in the package: "MutantData.tsv" and "HGNC.tsv"
#'
#' # mut_cds("Data/MutantData.tsv", "Data/HGNC.tsv")
#'
#' @references
#' Wickham, H. (n.d.). stringr: Simple, Consistent Wrappers for Common String
#' Operations. Introduction to stringr. Retrieved November 21, 2021,
#' from https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html.
#'
#' @export
#' @importFrom  stringr str_sub
#'
#'
library(stringr)

mut_cds <- function(mutFile, hgncFile){
  # source cosImport.R file to use the cosImport function in this script
  #source("R/cosImport.R")

  #import complete cosmic data from cosImport function
  dataImp <- CANMutVisual::cosImport(mutFile, hgncFile)

  # save MUTATION_CDS column as cds_raw dataframe
  cds_raw <- dataImp$MUTATION_CDS

  # keep the last 3 characters from all the elements and delete all others
  # use stringr package to complete this process
  cds_del <- stringr::str_sub(cds_raw,-3, -1)

  # Create a list of all possible mutation that could be found in the column
  mutValue <- c("C>A", "C>G", "C>T", "T>A",
                "T>C", "T>G", "G>T", "G>C",
                "G>A", "A>T", "A>G", "A>C")

  #Delete all characters that are not one of the element in mutValue list
  # Do this by checking if elements cds_del matches any one of the mutValue elements
  # delete if no match
  cdsData <- cds_del[cds_del %in% mutValue]

  # Get the frequency element occurrences
  cds_freq <- as.data.frame(table(cdsData))

  return (cds_freq)
}
#[END]
