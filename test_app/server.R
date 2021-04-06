function(input, output, session) {
  reactives <- reactiveValues()
  reactives$login <- FALSE
  
  # 1. Validate user and password
  validate_login <- eventReactive(input$login_button, {
  
    validate(
      need(input$user != "", "User Name is missing"), 
      errorClass = "login"
    )
    validate(
      need(input$pass != "", "Password is missing"), 
      errorClass = "login"
    )
    validate(
      need(
        user_tbl[user_tbl$user == input$user, "id"] == 
          user_tbl[user_tbl$password == input$pass, "id"],
        "Wrong User Name or Password"
      ),
      errorClass = "login"
    )
    
    reactives$login <- TRUE
  })
  
  # 2 Output - Login error message
  output$login_error <- renderText({
    req(validate_login(), cancelOutput = TRUE)
    #class(is_valid) <- append(class(is_valid), "character")
    #base::stop(safeError(is_valid))
  })
  
  # 3. Hide form (in case credentials are correct) and Update log table
  observeEvent(validate_login(), {
    shinyjs::hide(id = "login-basic")
    UpdateLog(input$user)
  })
  
  # 4. Reactive expression to retrieve user session data
  user_session <- reactive({
    HTML(paste0(
      "<b>",
      "protocol: ", session$clientData$url_protocol, "<br>",
      "hostname: ", session$clientData$url_hostname, "<br>",
      "pathname: ", session$clientData$url_pathname, "<br>",
      "port: ",     session$clientData$url_port, "<br>",
      "search: ",   session$clientData$url_search, 
      "</b>"
    ))
  })
  
  # 5. Reactive expression to retrieve geolocation data
  user_geo <- reactive({
    geo <- GeolocateUser()
    HTML(paste0(
      "<b>",
      "ip: ", geo$ip, "<br>",
      "country_name: ", geo$country_name, "<br>",
      "country_code: ", geo$country_code, "<br>",
      "time_zone: ", geo$time_zone, "<br>",
      "latitude: ", geo$latitude, "<br>",
      "longitude: ", geo$longitude, "<br>",
      "</b>"
    ))
  })
  
  # 6. App content on authorization ----
  output$display_content <- renderUI({
    req(reactives$login)
    div(
      `id` = "display_content",
      `class` = "shiny-html-output container-fluid",
      navlistPanel(
        tabPanel("Tags Management"),
        tabPanel("Track Time"),
        tabPanel("Stats",
          tags$div(
            `class` = "card text-white bg-success mb-3",
            `id` = "stats_card_session",
            tags$div(`class` = "card-header", "User session data"),
            tags$div(
              `class` = "card-body",
              h5(paste0("Welcome to TYT")),
              p("Access confirmed!"),
              user_session()
            )
          ),
          tags$div(
            `class` = "card text-white bg-info mb-3",
            `id` = "stats_card_geo",
            tags$div(`class` = "card-header", "User Geo data"),
            tags$div(
              `class` = "card-body",
              user_geo()
            )
          )
        ),
        id = "tabset",
        selected =  "Stats",
        well = TRUE
        
      )
      
    )
  })
  
  session$onSessionEnded(stopApp)
}
