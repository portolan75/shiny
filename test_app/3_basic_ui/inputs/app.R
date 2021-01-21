#' **Inputs**
#' We’ll dive deeper into the front end and explore the HTML inputs, outputs, 
#' and layouts provided by Shiny.
library(shiny)
#' **Common structure**
#' *inputId* identifier used to connect the front end (ui) with back end (server)
#' Has 2 constraints: 
#' - name like a R variable
#' - it must be unique
#' *label* label the inputId for more human-readability
#' *value* set the default value (when possible)
#' Example: sliderInput("min", "Limit (minimum)", value = 50, min = 0, max = 100)
#' 
#' **Built-in Inputs in Shiny**
#' **Free text**
#' 
#' *textInput* collect small amount of text
#' *passwordInput* passwords
#' *textAreaInput* collect paragraph of text
ui <- fluidPage(
  textInput("name", "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3)
)
#' To ensure text has certain properties is possible to use *validate()*
#'
#' **Numeric**
#' 
#' *sliderInput* If you supply a length-2 numeric vector for the default value of 
#' sliderInput(), you get a “range” slider with two ends. 
#' *numericInput* collect a single number
ui <- fluidPage(
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100)
)
#'
#' **Dates**
#' 
#' *dateInput* collect a single date
#' *dateRangeInput* provide a calendar picker and additional arguments like
#' (datesdisabled) and (daysofweekdisabled) allow you to restrict the set of inputs
ui <- fluidPage(
  dateInput("dob", "When were you born?"),
  dateInput(
    "dob_1", "Where again in Europe?", 
    format = "dd-mm-yyyy", # default is yyyy-mm-dd
    weekstart = 1, # start on monday instead of 0 default on sunday
    language = "it" # language used for month and day
  ),
  dateRangeInput("holiday", "When do you want to go on vacation next?")
)
#'
#' **Limited choices**
#' 
#' *selectInput* create a drop-down menu of choices. Argument multiple = TRUE
#' for allowing multiple choices
ui <- fluidPage(
  selectInput(
    "state", "What's your favourite state?", state.name,
    multiple = TRUE
  )
)
#' *radioButtons* create radio buttons
ui <- fluidPage(
  radioButtons("animal", "What's your favorite letter?", letters)
)
#' Radio buttons have two nice features: 
#' - they show all possible options, making them suitable for short lists
#' - via the choiceNames/choiceValues arguments, they can display options other 
#'   than plain text.
ui <- fluidPage(
  radioButtons("rb", "Choose one:",
    choiceNames = list(icon("angry"), icon("smile"), icon("sad-tear")),
    choiceValues = list("angry", "happy", "sad")
  )
)
#' *checkboxGroupInput* create checkboxes, also possible with multi-choices.
ui <- fluidPage(
  checkboxGroupInput("animal", "What's your favourite state?", state.name)
)
#'
#' **File uploads**
#' 
#' *fileInput* allow the user to upload a file
ui <- fluidPage(
  fileInput("upload", NULL)
)
#'
#' **Action buttons**
#' 
#' *actionButton* create an action button
#' *actionLink* create an action link
ui <- fluidPage(
  actionButton("click", "Click me!"),
  actionLink("drink", "Drink me!", icon = icon("cocktail"))
)
#' customizations are possible via the *class* argument using all of these
#' possibilities [CSS link](http://bootstrapdocs.com/v3.3.6/docs/css/#buttons)
ui <- fluidPage(
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionLink("drink", "Drink me!", class = "btn btn-link", icon = icon("cocktail"))
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block")
  )
)
server <- function(input, output, session) {
  
}
shinyApp(ui, server)
