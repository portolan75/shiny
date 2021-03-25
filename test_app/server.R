function(input, output, session) {
  reactives <- reactiveValues()
  
  # 1. Validate user and password
  validate_login <- eventReactive(input$login_button, {
    reactives$login <- FALSE
  
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
  
  # 2 Login error message
  output$login_error <- renderText({
    req(validate_login(), cancelOutput = TRUE)
    #class(is_valid) <- append(class(is_valid), "character")
    #base::stop(safeError(is_valid))
  })
  
  # 3. Hide form (in case credentials are correct) and Update log table
  hide_login <- reactive({
    req(reactives$login)
    shinyjs::hide(id = "login-basic")
    UpdateLog(input$user)
  })
  
  # 4. Retrieve user session data
  user_session <- eventReactive(validate_login(), {
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
  
  # 5. Retrieve geolocation data
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
  
  # 6. Display app content
  output$display_content <- renderUI({
    hide_login()
    
    div(
      id = "display_content",
      class = "card text-white bg-info mb-3",
      h4("Access confirmed!"),
      p("Welcome to TYT"),
      h5(paste0("User ", input$user, " in action")),
      br(),
      h5("User session data"),
      user_session(),
      br(),
      h5("User geo data"),
      user_geo()
    )
  })
  
  session$onSessionEnded(stopApp)
}
