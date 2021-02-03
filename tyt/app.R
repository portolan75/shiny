library(shiny)

ui <- fluidPage(
  # App theme ----
  theme = bslib::bs_theme(version = 4, bootswatch = "cerulean"),
  
  # App title ----
  titlePanel("TYT- Take Your Time"),
  
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
    label = "Do you have specific activities/tag(s) you like to track time of?
    (Please list them below, each time you hit ENTER a new tag is created)",
    placeholder = "Volunteering, Holidays, Administration, etc."
  ),
  textOutput("tags_selected")
)

server <- function(input, output, session) {
  all_tags <- reactive({
    c(input$std_tags, input$oth_tags)
  })
  
  output$tags_selected <- renderText({
      all_tags()
  })
}

shinyApp(ui, server)
