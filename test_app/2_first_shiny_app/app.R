#' The simpliest way to create a Shiny app is to create a new directory for the
#' app and then put a file called **app.R** in it.
#' ## Initialize the app
library(shiny)
ui <- fluidPage(
  "Hello, this is Paolo speaking!"
)
server <- function(input, output, session) {
}
#' shinyApp(ui, server)
#' Listening on http://127.0.0.1:6940 tells where the app can be found:
#' - 127.0.0.1 is a standard address that means “this computer”
#' - 6940 is a randomly assigned port number

#' ## Add inputs and outputs for the UI.
#' **fluidPage** is a layout control that setup the basic of the visual 
#' structure of the page.\
#' **selectInput** is an input control, let the user interact with the app by
#' providing a value.
#' **verbatimTextOutput** and **tableOutput** are output controls, that tells
#' Shiny where to put rendered output.\
#' **verbatimTextOutput** displays code\
#' **tableOutput** displays tables\
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)
#' All functions generate HTML code under the hood.
#'
#' ## Bring output to life (server function)
#' Shiny uses *reactive programming* that means telling Shiny *how to perform* a
#' computation, not to actually do it.
#' Outputs are reactive: they automatically recalculate when their inputs change.
#' We will tell Shiny *how* to fill-in the summary and table outputs in UI.
server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })
  
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}
#' Almost every output in Shiny will follow this same pattern:
#' > output$ID <- renderTYPE({
    # Expression that generates whatever kind of output
    # renderTYPE expects
#' > })
#' With output$ID I'm providing the recipe for the Shiny output macthing ID
#' (summary and table in my example.)
#' Each render* function is designed to work with a particular type of output
#' that is passed to an *Output function.
#'
#' ## Reducing duplication with reactive expressions
#' Two ways of dealing with it in traditional R:
#' - capture the value in a variable
#' - capture the computation using a function
#' Here neither of the 2 works, we need *reactive expressions* which are written
#' by wrapping a block of code in reactive({...}) and assign it to a variable,
#' which can then be called as a function.
#' A reactive expression is different from a function because it runs only the
#' first time is called and then caches its results until needs to be updated.
server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}
shinyApp(ui, server)
