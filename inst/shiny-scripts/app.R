library(shiny)

#' @ references
#' ShinyApp Layout a sidebar and Main Area. Shiny. (n.d.). Retrieved December 9, 2021,
#' from https://shiny.rstudio.com/reference/shiny/1.7.0/sidebarLayout.html.
#'
#'

ui <- fluidPage(
  # Title
  titlePanel(tags$h1("CANMutVisual")),

  # layout - left bar for inputs
  sidebarLayout(
    sidebarPanel(

      tags$p("This program allow users to choose two input files: HGNC id file, COSMIC mutant data file,
             and calculate gene frequency and mutation frequency to visualize the data
             in plots."),
      tags$p("The shiny app can currently display two types of plots: Bar graph and Pie Chart"),

      #input
      fileInput("file1", "Select approved HGNC id file", accept = ".tsv"),
      fileInput("file2", "Select TSV COSMIC data file", accept = ".tsv"),

      # run the input files: actionButton
      actionButton(inputId = "runButton", label = "Run"),

      br(),

    ),

    mainPanel(

      #output in plot
      tabsetPanel(type = "tabs",
                  tabPanel("Bar Plot", plotOutput("bar"),
                           verbatimTextOutput('text1')),
                  tabPanel("Pie Chart", plotOutput("pie"),
                           verbatimTextOutput('text2')),
                  tabPanel("Gene Freq",  dataTableOutput('table1')),
                  tabPanel("Mutation Freq", dataTableOutput('table2'))
    )

  )
  )

)

server <- function(input, output){
  # This code run when "run" button is pressed

  inputF1 <- reactive({
    input$file1
  })
  inputF2 <- reactive({
    input$file2
  })

  # checking if file exists
  # input file of type .tsv will only be accepted b/c it is already restricted
  # in UI function above.
  if(is.null(inputF1) || is.null(inputF2)){
    return(NULL)
  }else{
    output$bar <- renderPlot({
      plot_cds(inputF1, inputF2)
    })

    output$pie <- renderPlot({
      plot_top_15(inputF1, inputF2)
    })

    output$table1 <- renderDataTable({
      countMut(inputF1, inputF2)
    })

    output$table2 <- renderDataTable({
      mut_cds(inputF1, inputF2)
    })

  }

}

# Create Shiny app
shinyApp(ui = ui, server = server)

# [END]
