function(input, output, session) {
  
  # 1. Validate user and password
  validate_password_basic <- eventReactive(input$ab_login_button_basic, {
    validation <- FALSE
  
    validate(need(input$ti_user_basic != "", "User Name is missing"))
    validate(need(input$ti_password_basic != "", "Password is missing"))
    validate(need(
      user_tbl[user_tbl$user == input$ti_user_basic, "id"] == 
        user_tbl[user_tbl$password == input$ti_password_basic, "id"]
      ,
      "Wrong User Name or Password"
    ))
    
    validation <- TRUE
  })
  
  # 2 Login error message
  output$login_error <- renderText({
    validate_password_basic()
    #class(is_valid) <- append(class(is_valid), "character")
    #base::stop(safeError(is_valid))
  })
  
  # 3. Hide form (in case credentials are correct) and Update log table
  observeEvent(validate_password_basic(), {
    shinyjs::hide(id = "login-basic")
    UpdateLog(input$ti_user_basic)
  })
  
  # 4. Retrieve user session data
  user_session <- eventReactive(validate_password_basic(), {
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
  output$display_content_basic <- renderUI({
    req(validate_password_basic())
    
    div(
      id = "display_content_basic",
      class = "alert alert-dismissible alert-success",
      h4("Access confirmed!"),
      p("Welcome to TYT"),
      h5(paste0("User ", input$ti_user_basic, " in action")),
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
