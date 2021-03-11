function(input, output, session) {
  
  # 1. Check credentials vs userbase
  validate_password_basic <- eventReactive(input$ab_login_button_basic, {
    validation <- FALSE
  
    validate(need(input$ti_user_basic != "", "User Name is missing"))
    validate(need(input$ti_password_basic != "", "Password is missing"))
    validate(
      need(
        input$ti_user_basic != "" && input$ti_password_basic != "" &&
        which(user_tbl$user == input$ti_user_basic) == 
            which(user_tbl$password == input$ti_password_basic)
        ,
        "Wrong User Name or Password"
      )
    )
    
    validation <- TRUE
  })
  
  # 2. Hide form (in case credentials are correct) and Update log table
  observeEvent(validate_password_basic(), {
    shinyjs::hide(id = "login-basic")
    UpdateLog(input$ti_user_basic)
  }) 
  
  # 3. Retrieve user session data
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
  
  # 4. Retrieve geolocation data
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
  
  # 5. Display app content
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
  
}