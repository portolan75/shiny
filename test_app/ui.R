# UI
navbarPage(
  title = "TYT - Take Your Time",
  collapsible = TRUE, 
  theme = bslib::bs_theme(version = 4, bootswatch = "minty"),
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
            inputId     = "user",
            label       = tagList(icon("user"), "User Name"),
            placeholder = "Enter user name"
          ),
          
          passwordInput(
            inputId     = "pass", 
            label       = tagList(icon("unlock-alt"), "Password"), 
            placeholder = "Enter password"
          ),
          
          actionButton(
            inputId = "login_button", 
            label = "Log in",
            class = "btn btn-primary"
          ),
          
          # tag for hosting text output for login authentication message - ----
          tags$div(
            `id` = "login_error",
            `class` = "shiny-text-output text-warning"
          ),
          tags$style(HTML("
            .shiny-output-error-login {
              font-size: 16px;
            }
          "))
        )
      ),
        
      # UI Inputs - ----
      # To be filled-in
      
      # UI Output - ----
      # Display app content on authorization
      htmlOutput(outputId = "display_content")
    )
  )
)
