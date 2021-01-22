library(shiny)

ui <- fluidPage(
  checkboxGroupInput(
    inputId = "std_tags",
    label = "Which activities/tag(s) would you like to track time of?",
    choices = list(
      "Eating and Cooking", "Work", "Social-Network", "Social-Out", "Sport", 
      "Entertainment", "Sleeping"
    )
  ),
  textInput(
    inputId = "oth_tags",
    label = "Do you have specific activities/tag(s) you like to track time of?\
    (Please list them below, each time you hit ENTER a new tag is created)",
    placeholder = "Volunteering, Holidays, Administration, etc."
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)
