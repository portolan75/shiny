#' ##Exercises
library(shiny)
#' 1. Given this UI:
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)
#' Fix the simple errors found in each of the three server functions below. 
#' First try spotting the problem just by reading the code; 
#' then run the code to make sure you’ve fixed it.
server1 <- function(input, output, session) {
  output$greeting <- renderText(
    paste0("Hello ", input$name))
}

server2 <- function(input, output, session) {
  greeting <- reactive({paste0("Hello ", input$name)})
  output$greeting <- renderText(greeting())
}

server3 <- function(input, output, session) {
  output$greeting <- renderPrint({
    cat("Hello", "\n", input$name, sep = "")
  })
}
shinyApp(ui, server3)

#' 2. Draw the reactive graph for the following server functions:
server1 <- function(input, output, session) {
  c <- reactive(input$a + input$b)
  e <- reactive(c() + input$d)
  output$f <- renderText(e())
}
server2 <- function(input, output, session) {
  x <- reactive(input$x1 + input$x2 + input$x3)
  y <- reactive(input$y1 + input$y2)
  output$z <- renderText(x() / y())
}
server3 <- function(input, output, session) {
  d <- reactive(c() ^ input$d)
  a <- reactive(input$a * 10)
  c <- reactive(b() / input$c) 
  b <- reactive(a() + input$b)
}

#" 3. Why will this code fail?
var <- reactive(df[[input$var]])
range <- reactive(range(var(), na.rm = TRUE))

# The code fail because the reactive expression named range, calls a function
# called range, which ingenerate a loop (environment confusion)


# The bad names because is bad practice to call an object like a function.
# It can be tricky with environments, where in some we call the object and in
# others the function is called (parent/child dependencies)