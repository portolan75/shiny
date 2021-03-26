# UI
fluidPage(
  # HEADER + Re-style ----
  # Resize body
  tags$style(HTML("
    body {
      width: 90%;
      margin:auto;
    }
  ")),
  # Modify header to inherit navbar classes
  tags$header(
    `class` = "navbar navbar-dark bg-primary",
    tags$title(
      `class` = "navbar-brand",
      "Take Your Time - TYT"
    ),
    tags$style(HTML("
      .navbar {
        margin-top: 1rem;
        margin-bottom: 1rem;
      }
    "))
  ),
  title = "TYT",
  theme = bslib::bs_theme(version = 4, bootswatch = "minty"),
  useShinyjs(),  # Include shinyjs
  # UI container ----
  fluidRow(
    column(
      width = 12,
      
      # Login form ----
      column(
        width = 4, 
        offset = 4,
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
          
          # tag for hosting text output for login authentication message ----
          tags$div(
            `id` = "login_error",
            `class` = "shiny-text-output text-danger"
          ),
          tags$style(HTML("
            .shiny-output-error-login {
              font-size: 14px;
            }
          "))
        )
      ),
        
      
      # UI Inputs ----
      # To be filled-in
      
      # UI Output ----
      # Display app content on authorization
      htmlOutput(outputId = "display_content")
    )
  )
)
