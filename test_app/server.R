function(input, output, session) {
  
  # 2. Check credentials vs userbase - ----
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
  
  # 3. Hide form (in case credentials are correct) - ----
  observeEvent(validate_password_basic(), {
    shinyjs::hide(id = "login-basic")
  }) 
  
  # 4. Display app content - ----
  #### BEGIN: This part is optional if i need to save user and session data
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
  #### END
  
  output$display_content_basic <- renderUI({
    req(validate_password_basic())
    
    div(
      id = "display_content_basic",
      class = "alert alert-dismissible alert-success",
      h4("Access confirmed!"),
      p("Welcome to TYT"),
      user_session()
    )
  })
  
}