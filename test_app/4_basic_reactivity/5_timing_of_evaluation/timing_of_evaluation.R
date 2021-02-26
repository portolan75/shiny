#' **Controlling timing evaluation**
#' - *time invalidation* --> via
#'   **reactiveTimer(milliseconds)** in server
#'   is a reactive expression that has a dependency on a hidden input: 
#'   the current time. 
#'   You can use a reactiveTimer() when you want a reactive expression to 
#'   invalidate itself more often than it otherwise would. 
#'   For example, the plot will update every milliseconds specified.
#'   
#' OR very used and efficient:   
#' - *on click* --> via
#'   **actionButton()** in UI + **eventReactive()** in server