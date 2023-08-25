#' Returns piechart of freuqnecy of each gene types
#'
#' plot_top_15 function uses countMut function in countMut.R file to get frequency data
#' of each gene and return piechart using the data extracted
#'
#' @param mutFile A .tsv file containing COSMIC point mutations
#' @param hgncFile A .tsv file with complete approved human gene nomenclature IDs
#'
#' @return Returns 3D pie chart containing top 15 most occureing gene names in a
#' specific cancer type using gene frequency data obtained from countMut function
#'
#' @examples
#' # Using data files available in the package: "MutantData.tsv" and "HGNC.tsv"
#'
#' # plot_top_15("Data/MutantData.tsv", "Data/HGNC.tsv")
#'
#' @references
#' Lemon, J., Bolker, B., Oom, S., &amp; Klein, E. (n.d.). Package plotrix. CRAN.
#' Retrieved November 22, 2021, from https://cran.r-project.org/web/packages/
#' plotrix/index.html.
#'
#' @export
#' @import plotrix
#'
#'

if (! requireNamespace("plotrix", quietly = TRUE)) {
  install.packages("plotrix")
}
library(plotrix)

plot_top_15 <- function(mutFile, hgncFile){


  # source countMut.R file to use the countMut function in this script
  #source("R/countMut.R")

  # get gene frequency data using countMut function
  mut_gene <- CANMutVisual::countMut(mutFile, hgncFile)

  # order them in descending order
  mut_gene <- mut_gene[order(mut_gene$Freq, decreasing = TRUE), ]

  # extract first 15 rows from mut_gene (most mutated gene type)
  mut_gene <- mut_gene[1:15, ]

  # set specific colors for better visualization purpose
  colors <- c("#CDECA8","#C3EBAF",
              "#BAEBB7","#B3E9C0",
              "#AEE7C8","#ACE5CF",
              "#ADE1D5","#B1DEDA",
              "#B7DADE","#BED5E0",
              "#C7D1E0","#D0CCDE",
              "#DAC6DA","#E3C1D5",
              "#EABDCE")

  # set margin : larger right margin to fit legend
  par(mar = c(2,10,2,2))

  # Using plotrix package, plot 3D pie chart
  plotrix::pie3D(mut_gene$Freq, # frequeny variable represented as pie chart
        labels = mut_gene$Freq, # label each pieces with values
        main = "Most Frequent gene types: top 15", # set title
        radius = 0.8,
        col = colors, # set col using "colors" list
        labelcex = 0.6,
        explode = 0.2 # place gaps in between each pieces to easily detect size differences
        )

  # add legend to present gene names for each colors
  legend(x = 1.3, y = 1.4, # use trial$error to position legend
         mut_gene$symbol_gene,
         cex = 0.6,
         fill = colors,
         legend = mut_gene$symbol_gene,
         bty="n" # No background/border line
         )
}
#[END]

