#' ##Exercises
library(shiny)
#' 1. Re-create the Shiny app from Section 3.3.3, this time setting height to 
#' 300px and width to 700px
ui <- fluidPage(
  plotOutput("plot", height = "300px", width = "700px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}
shinyApp(ui, server)
#'
#' 2. Update the options for renderDataTable() below so that the table is displayed, 
#' but nothing else (i.e. remove the search, ordering, and filtering commands). 
#' You’ll need to read ?renderDataTable and review the options at 
#' https://datatables.net/reference/option/.
ui <- fluidPage(
  dataTableOutput("table")
)
server <- function(input, output, session) {
  output$table <- renderDataTable(
    expr = mtcars, 
    options = list(
      ordering = FALSE,
      searching = FALSE,
      info = FALSE,
      pageLength = 10,
      lengthChange = FALSE
    )
  )
}
shinyApp(ui, server)
