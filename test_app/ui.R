# app backbone UI
navbarPage(
  title = "TYT - Take Your Time",
  theme = bslib::bs_theme(version = 4, bootswatch = "mint"),
  useShinyjs(),  # Include shinyjs
  
  # UI container
  div(
    class = "container",
    column(
      width = 12,
      
      # Inputs
      # Login form - ----
      div(
        id = "login-basic", 
        style = "width: 500px; max-width: 100%; margin: 0 auto;",
        div(
          class = "well",
          h4(class = "text-center", "Please login"),
          p(class = "text-center", tags$small("First approach login form")),
          
          # Tag to contain login error message when triggered
          tags$div(
            tags$style(HTML("
              .shiny-output-error-validation {
                color: #ffce67;
                width: 100%;
                padding-right: 15px;
                padding-left: 15px;
                margin-right: auto;
                margin-left: auto;
                max-width: 540px;
              }
            "))
          ),
          
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
          )
        )
      ),
      
      # Outputs
      # Display app content on authorization - ----
      htmlOutput(outputId = "display_content_basic")
    )
  )
)