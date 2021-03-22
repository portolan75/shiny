# UI
navbarPage(
  title = "TYT - Take Your Time",
  collapsible = TRUE, 
  theme = bslib::bs_theme(version = 4, bootswatch = "mint"),
  useShinyjs(),  # Include shinyjs
  # UI container
  tags$div(
    class = "container",
    column(
      width = 12,
      
      # Login form - ----
      column(
        width = 6, 
        offset = 3,
        wellPanel(
          id = "login-basic",
          tags$h5("Please login", class = "text-center"),
          
          textInput(
            inputId     = "ti_user_basic",
            label       = tagList(icon("user"), "User Name"),
            placeholder = "Enter user name"
          ),
          
          passwordInput(
            inputId     = "ti_password_basic", 
            label       = tagList(icon("unlock-alt"), "Password"), 
            placeholder = "Enter password"
          ),
          
          actionButton(
            inputId = "ab_login_button_basic", 
            label = "Log in",
            class = "btn btn-primary"
          ),
          
          # tag for hosting text output for login authentication message - ----
          #textOutput(outputId = "login_error"),
          tags$style(HTML("
              .shiny-output-error-validation {
                font-size: 0px;
              }
          ")),
          tags$div(
            `id` = "login_error",
            `class` = "shiny-text-output"
          ),
          tags$style(HTML("
            .shiny-text-output {
              display: block;
              color: #ffce67;
              font-size: 16px;
            }
          "))
        )
      ),
        
      # UI Inputs - ----
      # To be filled-in
      
      # UI Output - ----
      # Display app content on authorization
      htmlOutput(outputId = "display_content_basic")
    )
  )
)
