# The following app is very similar to one you’ve seen earlier in the chapter: 
# you select a dataset from a package (this time we’re using the ggplot2 package) 
# and the app prints out a summary and plot of the data. 
# It also follows good practice and makes use of reactive expressions to avoid 
# redundancy of code. 
# However there are three bugs in the code provided below. 
# Can you find and fix them?
library(ggplot2)
datasets <- data(package = "ggplot2")$results[c(2, 4, 10), "Item"]

ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  tableOutput("plot")
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summmry <- renderPrint({
    summary(dataset())
  })
  output$plot <- renderPlot({
    plot(dataset)
  }, res = 96)
}
# Solution
library(shiny)
library(ggplot2)
datasets <- data(package = "ggplot2")$results[c(2, 4, 10), "Item"]

ui <- fluidPage(
  selectInput(inputId = "dataset", label = "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  # 1. Change tableOutput to plotOutput.
  plotOutput("plot")
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  # 2. Change summry to summary.
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$plot <- renderPlot({
    # 3. Change dataset to dataset().
    plot(dataset())
  }, res = 96)
}

shinyApp(ui, server)
