# Design an app that allows the user to set a number (x) between 1 and 50, 
# displaying the result of multiplying this number by 5. 
# This is a first attempt with an error:
library(shiny)

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  "then 5 times x is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    x * 5
  })
}

# Can you find and correct the error?
ui <- fluidPage(
  sliderInput(inputId = "x", label = "If x is", min = 1, max = 50, value = 30),
  "then 5 times x is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({
    input$x * 5
  })
}

shinyApp(ui, server)
