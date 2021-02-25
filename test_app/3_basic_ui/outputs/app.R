#' ** Outputs **  
#' 
#' Outputs in the UI create placeholders that are later filled by the server 
#' function.\
#' Each *output function* on the front end (UI) is coupled with a 
#' *render function* in the back end (Server).\
library(shiny)
#' 
#' 
#' ** Text Output **
#' 
#' Output regular text with *textOutput()* and     
#' fixed code and console output with *verbatimTextOutput()*
ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("code")
)
server <- function(input, output, session) {
  output$text <- renderText("Hello friend!")
  output$code <- renderPrint(summary(1:10))
}
shinyApp(ui, server)
#'
#' Two render functions that can be used with either of the text outputs:
#' 
#' - *renderText()* combines the result into a single string.
#' - *renderPrint()* prints the result.
#' 
#' This is equivalent to the difference between cat() and print() in base R.
#' 
#' 
#' ** Table Output **
#' 
#' There are two options for displaying data frames in tables:
#' 
#' - *tableOutput()* and *renderTable()* render a *static table* of data, 
#'   showing all the data at once.\
#'   It is most useful for small, fixed summaries (e.g. model coefficients)
#' - *dataTableOutput()* and *renderDataTable()* render a *dynamic table*, showing 
#'  a fixed number of rows along with controls to change which rows are visible.\
#'  It is most appropriate to expose a complete data frame to the user.\
#'  For greater control over dataTableOutput consider using **reactable** package
#'  or even better **DT** (create both client-side and server-side tables) packages.
ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
}
shinyApp(ui, server)
#'
#' DT package usage example:
ui <- fluidPage(
  DT::DTOutput("dynamic")
)
server <- function(input, output, session) {  
  output$dynamic <- DT::renderDT(
    DT::formatStyle(
      table = DT::datatable(mtcars), 
      columns = "cyl",
      backgroundColor = DT::styleInterval(
        cuts = c(4, 6), 
        values = c("red", "grey", "green")
      )
    )
  )
}
shinyApp(ui, server)
#'
#'
#' ** Plot Output **
#' 
#' It is possible to display base and ggplot2 graphics with *plotOutput()* (UI) 
#' and *renderPlot()* (Server) functions.
ui <- fluidPage(
  plotOutput("plot", width = "400px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5, cex = 2), res = 96)
}
shinyApp(ui, server)
#' NOTE: By default, plotOutput() will take up the full width of its container 
#' and will be 400 pixels high. Height and width arguments allow for editing.\ 
#' We recommend always setting res = 96 as that will make Shiny plots match what 
#' is produced in RStudio as closely as possible.
#' 
#' 
#' ** Downloads **
#' 
#' It is possible to allow users to download a file:
#' 
#'  - with a button *downloadButton()*
#'  - with a link *downloadLink()*
#' 
#' These requires new server techniques (please see chapter 9 Uploads and DL's)
