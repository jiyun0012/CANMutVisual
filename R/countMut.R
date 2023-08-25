#' Returns gene name and frequency of each gene types
#'
#' counMut function uses cosImport function in cosImport.R file to read from
#' cosmic file and uses that dataframe to extract IDsymbol column and return the
#' occurrence frequency of each gene types.
#'
#' @param mutFile A .tsv file containing COSMIC point mutations
#' @param hgncFile A .tsv file with complete approved human gene nomenclature IDs
#'
#' @return Returns dataframe with gene names and frequency.
#'
#' @examples
#' # Using data files available in the package: "MutantData.tsv" and "HGNC.tsv"
#'
#' # countMut("Data/MutantData.tsv", "Data/HGNC.tsv")
#'
#' @export
#'
#'
countMut <- function(mutFile, hgncFile){ #Two input files to process cosimport function
  # source cosImport.R file to use the cosImport function in this script
  #source("R/cosImport.R")

  # use cosImport function to get total data read from cosmic file
  dataImp <- CANMutVisual::cosImport(mutFile, hgncFile)

  # get IDsymbol column
  symbol_gene <- dataImp$IDsymbol

  # count the number of gene ID occurences and present as data frame with two columns
  gene_freq <- as.data.frame(table(symbol_gene))

  return (gene_freq)
}
#[END]


