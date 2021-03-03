#' **Reactive programming**
#' This is the big idea in Shiny: you don’t need to tell an output when to update, 
#' because Shiny automatically figures it out for you. 
#' The code doesn’t tell Shiny to create an output and send it to the browser, 
#' but instead, it informs Shiny how it could create it if it needs to. 
#' It’s Shiny’s responsibility to decide when code is executed, not yours.
library(shiny)
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name, "!")
  })
}
shinyApp(ui, server)
#'
#'
#' **Imperative vs Declarative programming**
#' - In *imperative programming*, you issue a specific command and it’s carried 
#'   out immediately. This is the style of programming you’re used to in your 
#'   analysis scripts.
#' - In *declarative programming*, you express higher-level goals or describe 
#'   important constraints, and rely on someone else to decide how and/or when 
#'   to translate that into action. 
#'   This is the style of programming you use in Shiny.
#'   
#'   
#' **Laziness**
#' One of the strengths of declarative programming in Shiny is that it allows 
#' apps to be extremely lazy. A Shiny app will only ever do the minimal amount 
#' of work needed to update the output controls that you can currently see.
#'
#'
#' **The reactive graph**
#' In Shiny, because code is only run when needed, to understand the order of 
#' execution you need to instead look at the *reactive graph*, which describes 
#' how inputs and outputs are connected.
reactlog::reactlog_enable()
shinyApp(ui, server)
reactlogShow()
#' This graph tells you that greeting (output) will need to be recomputed whenever 
#' name (input) is changed. 
#' We’ll often describe this relationship as greeting has a *reactive dependency* 
#' on name.
#'
#'  
#' ** Reactive expressions**
#' Think of them as a tool that *reduces duplication in your reactive code* by 
#' introducing additional nodes into the reactive graph.
server <- function(input, output, session) {
  string <- reactive(paste0("Hello ", input$name, "!")) # reactive expression
  output$greeting <- renderText(string())
}
reactlog::reactlog_enable()
shinyApp(ui, server)
reactlogShow()
#'
#'
#' **Execution order**
#' NB: The order in which reactive code is run is determined only by the 
#' reactive graph, not by its layout in the server function.
#' The below server function works exatcly the same as the one written above,
#' because Shiny is lazy, so that code is only run when the session starts,
#' after string() has been created.
server <- function(input, output, session) {
  output$greeting <- renderText(string())
  string <- reactive(paste0("Hello ", input$name, "!")) # reactive expression
}