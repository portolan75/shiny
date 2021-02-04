library(shiny)
profvis::profvis({
ui <- navbarPage(
  title = "TYT - Take Your Time",
  theme = bslib::bs_theme(version = 4, bootswatch = "mint"),
  
  # Input: Tab with input data (input tags, input time) ----
  tabPanel("Tags", #fluid = TRUE,
    # Fluidrow layout for the first input question 1st tabset----
    fluidRow(
      column(width = 12,
        checkboxGroupInput(
          inputId = "std_tags",
          label = "Which activities/tag(s) would you like to track time of?",
          choices = list(
            "Eating and Cooking", "Work", "Social-Network", "Social-Out", 
            "Sport", "Entertainment", "Sleeping"
          ),
          width = "100%"
        )
      )
    ),
    # Fluidrow layout for the second input question 1st tabset----
    fluidRow(
      column(width = 12,
        textInput(
          inputId = "oth_tags",
          label = HTML(
            "Do you have specific activities/tag(s) you like to track time of?",
            "<br/>(Please list them below, each time you hit ENTER a new tag is created)"
          ),
          placeholder = "Volunteering, Holidays, Administration, etc.",
          width = "100%"
        )
      )
    ),
    # Main panel (output) for displaying selected inputs ----
    fluidRow(
      column(width = 12,
        h5("Currently selected tags:"), 
        htmlOutput("tags_selected"),
      )
    )
  ),
  # Output: Tabset w/ plot, summary, and table ----
  tabPanel("Time", tableOutput("time_table"))
)


server <- function(input, output, session) {
  all_tags <- reactive({
    c(input$std_tags, input$oth_tags)
  })
  
  output$tags_selected <- renderUI({
      HTML(paste(all_tags(), sep = "", collapse = "<br/>"))
  })
}

shinyApp(ui, server)
})
