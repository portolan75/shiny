# UI
fluidPage(
  # HEADER + RESIZE + RE-STYLE ----
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
  `theme` = bslib::bs_theme(version = 4, bootswatch = "yeti"),
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
          id = "login-panel",
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
          ")),
          
          
          tags$div(
            `class` = "text-center",
            br(), 
            tags$small("Don't have an account?"),
            tags$div(
              `class` = "text-center",
              actionLink(inputId = "register_user", label = "Create one")
            )
          )
        )
      ),
      # Register form ----
      column(
        width = 4, 
        offset = 4,
        wellPanel(
          id = "signup_panel",
          tags$h5("TYT - Sign-Up", class = "text-center"),
          
          textInput(
            inputId     = "signup_user",
            label       = tagList(icon("user"), "User Name"),
            placeholder = "min. 4 characters"
          ),
          
          passwordInput(
            inputId     = "signup_pass", 
            label       = tagList(icon("unlock-alt"), "Password"), 
            placeholder = "min. 8 characters"
          ),
          
          passwordInput(
            inputId = "signup_verify_pass", 
            tagList(icon("unlock-alt"), "Verify Password"),
            placeholder = "Re-type Password"
          ),
          
          actionButton(
            inputId = "signup_button", 
            label = "Create",
            class = "btn btn-primary"
          )
        )
      ),
      # On authorization app content ----
      htmlOutput(outputId = "display_content")
      
    )
  )
  
)
