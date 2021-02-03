library(shiny)

ui <- navbarPage(
  title = "TYT- Take Your Time",
  theme = bslib::bs_theme(version = 4, bootswatch = "dark"),
  
  # Input: Tab with input data (input tags, input time) ----
  tabPanel("Create/Edit Tags", fluid = TRUE,
    # Fluidrow layout for the first input tabset----
    fluidRow(
      # Sidebar panel for inputs ----
      column(6,
        checkboxGroupInput(
          inputId = "std_tags",
          label = "Which activities/tag(s) would you like to track time of?",
          choices = list(
            "Eating and Cooking", "Work", "Social-Network", "Social-Out", 
            "Sport", "Entertainment", "Sleeping"
          )
        )
      ),
      br(),
      column(6, 
        textInput(
          inputId = "oth_tags",
          label = "Do you have specific activities/tag(s) you like to track time of?
          (Please list them below, each time you hit ENTER a new tag is created)",
          placeholder = "Volunteering, Holidays, Administration, etc."
        )
      ),
      # Main panel for displaying outputs ----
      mainPanel(tabPanel("Create/Edit Tags", textOutput("tags_selected")))
    )
  ),
  # Output: Tabset w/ plot, summary, and table ----
  tabPanel("Insert Time", tableOutput("time_table"))
)


server <- function(input, output, session) {
  all_tags <- reactive({
    c(input$std_tags, input$oth_tags)
  })
  
  output$tags_selected <- renderText({
    paste(
      "These are your current tags",
      all_tags()
    )
  })
}

shinyApp(ui, server)
