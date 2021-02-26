#' **Observers**
#' Sometimes you need to reach outside of the app and cause side-effects to 
#' happen elsewhere like saving a file to a shared network drive, sending data 
#' to a web API, updating a database, or (most commonly) printing a debugging 
#' message to the console. 
#' These actions don’t affect how your app looks, so you shouldn’t use an output 
#' and a render function. Instead you need to use an *observer* via
#' **observeEvent()**.
#' Two important *differences* between *observeEvent()* and *eventReactive()*:

#' - You don’t assign the result of observeEvent() to a variable, so
#' - You can’t refer to it from other reactive consumers.
#' Observers and outputs are closely related. 
#' You can think of outputs as having a special side-effect: 
#' updating the HTML in the user’s browser.

#' EXAMPLE observer:
library(shiny)
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  string <- reactive(paste0("Hello ", input$name, "!"))
  
  output$greeting <- renderText(string())
  observeEvent(input$name, {
    message("Greeting performed")
  })
}
reactlog::reactlog_enable()
shinyApp(ui, server)
reactlogShow()