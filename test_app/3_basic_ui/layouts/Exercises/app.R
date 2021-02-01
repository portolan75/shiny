#' ##Exercises
library(shiny)
#' 1. Create an app with that contains two plots, each of which takes up half of 
#' the app (regardless of what size the whole app is).
ui <- fluidPage(
  titlePanel(
    "App with 2 plots each taking half of the size of the app"
  ),
  fluidRow(
    column(6, plotOutput(outputId = "p1")),
    column(6, plotOutput(outputId = "p2"))
  )
)

server <- function(input, output, session) {
  output$p1 <- renderPlot(
    hist(rnorm(10))
  )
  
  output$p2 <- renderPlot(
    hist(rnorm(100))
  )
}
shinyApp(ui, server)
#'
#' 2. Modify the Central Limit Theorem app so that the sidebar is on the right 
#' instead of the left.
ui <- fluidPage(
  titlePanel("Central limit theorem"),
  sidebarLayout(
    sidebarPanel(
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("hist")
    ),
    position = "right"
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}
shinyApp(ui, server)
#'
#' 3. Browse the themes available in the shinythemes package, pick an attractive 
#' theme, and apply it the Central Limit Theorem app.

ui <- fluidPage(
  theme = shinythemes::shinytheme("flatly"),
  titlePanel("Central limit theorem"),
  sidebarLayout(
    sidebarPanel(
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("hist")
    ),
    position = "right"
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}
shinyApp(ui, server)
