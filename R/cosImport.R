#' Returns data read from cosmic file
#'
#' cosImport function returns data read from cosmic file with additional
#' column named IDsymbol to extract only the genes with approved HGNC ID
#'
#' @param mutFile A .tsv file containing COSMIC point mutations
#' @param hgncFile A .tsv file with complete approved human gene nomenclature IDs
#'
#' @return Returns dataframe with columns GENE_NAME, ACCESSION_NUMBER,
#' GENE_CDS_LENGTH, HGNC_ID, SAMPLE_NAME, GENOMIC_MUTATION_ID, MUTATION_ID,
#' MUTATION_CDS, MUTATION_AA, MUTATION_DESCRIPTION, SAMPLE_TYPE, TUMOUR_ORIGIN,
#' and the additional column that the function inserts: IDsymbol
#'
#' @examples
#' # Using data files available in the package: "MutantData.tsv" and "HGNC.tsv"
#'
#' # cosImport("Data/MutantData.tsv", "Data/HGNC.tsv")
#'
#' @references
#' Cosmic. (2021, May 28). Data downloads (release V94, 28th May 2021). Download
#' Files. Retrieved November 21, 2021, from https://cancer.sanger.ac.uk/cosmic/download.
#'
#' Custom downloads HGNC. HGNC. (n.d.). Retrieved
#' November 21, 2021, from https://www.genenames.org/download/custom/.
#'
#' Wickham, H., Hester, J., &amp; Francois, R. (2021, November 11). Read
#' rectangular text data [R package readr version 2.1.0]. The Comprehensive
#' R Archive Network. Retrieved November 21, 2021,
#' from https://cran.r-project.org/web/packages/readr/index.html.
#'
#' @export
#'@importFrom readr read_tsv
#'
library(readr)
cosImport <- function(mutFile, hgncFile){
  # read .tsv COSMIC file using readr package
  #"c" representing col_character()
  #Specify each column types
  readCos <- readr::read_tsv(mutFile, col_types = cols_only('GENE_NAME' = "c",
                                                            "ACCESSION_NUMBER" = "c",
                                                            "GENE_CDS_LENGTH" = "c",
                                                            "HGNC_ID" = "c",
                                                            "SAMPLE_NAME" = "c",
                                                            "GENOMIC_MUTATION_ID" = "c",
                                                            "MUTATION_ID" = "c",
                                                            "MUTATION_CDS" = "c",
                                                            "MUTATION_AA" = "c",
                                                            "MUTATION_DESCRIPTION" = "c",
                                                            "SAMPLE_TYPE" = "c",
                                                            "TUMOUR_ORIGIN" = "c"))

  # extract only the HGNC_ID column and save as cos_id
  cos_id <- readCos$'HGNC_ID'

  # HGNC ID : approved human gene symbols
  # get HGNC id column in the tsv file
  getID <- readCos$'HGNC_ID'

  # remove duplicate IDs
  hgnc_id <- unique(getID)

  # since total hgnc id file is formatted as "HGNC: id", edit hgnc_id from tsv file.
  hgnc_id_format <- paste("HGNC:", hgnc_id, sep = "")

  # read hgnc id file downloaded from genenames.org
  readHGNC <- readr::read_tsv(hgncFile, col_types = cols_only("HGNC ID" = "c", # Specify Column types
                                                              "Approved symbol" = "c",
                                                              "Approved name" = "c",
                                                              "Previous symbols" = "c"))
  # obtain HGNC ID column from readHGNC data read from hgncfile
  id <- readHGNC$'HGNC ID'

  # extract and set Approved Symbol column as symb data frame
  symb <- readHGNC$'Approved symbol'

  # Since dplyr is slower than data.table, we use data.table to process large data like the following tsv data.
  dt_hgncID <- data.table::data.table("ID" = hgnc_id, # column1 named ID to store hgnc_id
                                      "Gene" = symb[match(hgnc_id_format, id)]) # column2 named Gene, save gene symbols
  data.table::setkey(dt_hgncID, 'ID')

  # Add a new column named "IDsymbol" to the existing readCos dataset
  readCos$IDsymbol <- dt_hgncID[cos_id, allow.cartesian = TRUE]$'Gene'

  return (readCos)
}
#[END]


