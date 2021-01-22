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
  verbatimTextOutput("std_selected"),
  textInput(
    inputId = "oth_tags",
    label = "Do you have specific activities/tag(s) you like to track time of?
    (Please list them below, each time you hit ENTER a new tag is created)",
    placeholder = "Volunteering, Holidays, Administration, etc."
  ),
  verbatimTextOutput("oth_selected")
)

server <- function(input, output, session) {
  #tags_list <- reactive({
  #  get(input$std_tags)
  #})
  #output$std_selected <- renderPrint({
  #  get(input$std_tags)
  #})
  #output$std_selected <- renderPrint({
  #  tags_list()
  #})
}
shinyApp(ui, server)
