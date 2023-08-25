#' Launch Shiny App for package CANMutVisual
#'
#' The shiny app allow user to choose two input files to process
#' the functions provided in the package. The visualization using Shiny app
#' help users to utilize this package with no prior knowledge on R.
#'
#' @return The function will launch the shiny app. No return value
#'
#' @examples
#'  \dontrun{
#'  CanMutVisual::runCanMutVisual()
#'  }
#'
#' @references
#' https://shiny.rstudio.com/tutorial/
#'
#' @export
#'
#' @importFrom shiny runApp
#'
#'
runCANMutVisual <- function(){
  app <- system.file("shiny-scripts",
                     package = "CanMutVisual")
  shiny::runApp(app, display.mode = "normal")
  return()
}

# [END]
