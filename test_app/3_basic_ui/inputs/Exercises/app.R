#' ## Exercises 
#' 1. It’s useful to label text boxes using a placeholder that appears inside the 
#' text entry area. 
#' How do you call textInput() to generate the UI below?
library(shiny)
ui <- fluidPage(
  textInput("name", "", placeholder = "Your name")
)
#'
#' 2. Carefully read the documentation for sliderInput() to figure out how to 
#' create a date slider, as shown below with sliding dates.
ui <- fluidPage(
  sliderInput("date", "When should we deliver?",
    min = as.Date("2020-09-16"),
    max = as.Date("2020-09-23"),
    value = as.Date("2020-09-17")
  )
)
#'
#' 3. If you have a moderately long list, it’s useful to create sub-headings that 
#' break the list up into pieces. 
#' Read the documentation for selectInput() to figure out how. 
#' (Hint: the underlying HTML is called <optgroup>.)
ui <- fluidPage(
  selectInput("subs", "List of choices",
    choices = list(
      "DOGS" = list("Malinos", "Doberman", "Alano"),
      "CATS" = list("Persian", "Siamese", "Bengalese")
    ),
    multiple = TRUE
  )
)
#'
#' 4. Create a slider input to select values between 0 and 100 where the interval 
#' between each selectable value on the slider is 5. 
#' Then, add animation to the input widget so when the user presses play the 
#' input widget scrolls through automatically.
ui <- fluidPage(
  sliderInput("slide", "",
    min = 0,
    max = 100,
    value = c(0, 5),
    step = 5,
    ticks = TRUE,
    animate = animationOptions(interval = 300, loop = TRUE)
  )
)
#'
#' 5. Using the following numeric input box the user can enter any value between 
#' 0 and 1000. What is the purpose of the step argument in this widget?
#' numericInput("number", "Select a value", value = 150, min = 0, max = 1000, step = 50)
ui <- fluidPage(
  numericInput("number", "Select a value", value = 150, min = 0, max = 1000, step = 50)
)
#' The *step argument* is the amount by which the numericInput value is incremented 
server <- function(input, output, session) {
  
}
shinyApp(ui, server)
