#' **The server function**
#' The *server* is more complicated than *ui* because every user needs to get an 
#' independent version of the app; when user A moves a slider, user B shouldn’t 
#' see their outputs change.
#' To achieve this independence, Shiny invokes your *server()* function each time 
#' a new session starts.
#' When the server function is called it creates a new local environment that is 
#' independent of every other invocation of the function. 
#' This allows each *session* to have a unique state, as well as isolating the 
#' variables created inside the function.
#' Server functions take **three parameters**: *input*, *output*, and *session*.
#' These parameters are created by Shiny when the session begins, connecting back 
#' to a specific session. 
#' 
#' **Input**
#' The input argument is a list-like object that contains all the 
#' *input data sent from the browser (ui)*, named according to the input ID.
#' It is possible to access the value of that input with *input$name(inputID)*.
#' Unlike a typical list, input objects are read-only. Not possible to modify an 
#' input inside the server function.
#' One more important thing about input: you *must be in a reactive context*
#' created by a function like renderText() or reactive() to access input in server.
#' 
#' **Output**
#' Output is very similar to input: it’s also a list-like object named according 
#' to the output ID. 
#' The main difference is that is used for sending output instead of receiving input. 
#' The output object is *always used in a render function*
#' The render function does two things:
#' - It sets up a special reactive context that automatically tracks what inputs 
#'   the output uses.
#' - It converts the output of your R code into HTML suitable for display on a 
#'   web page.