#' ** Layouts **  
#' 
#' Layouts is about how to arrange inputs and outputs on the page.\
#' Here we focus on *fluidPage()* which provides the layout style used by most 
#' apps.
#'
library(shiny)
#'
#'
#' **Overview**
#' Layouts are created by a hierarchy of function calls, where the hierarchy in R 
#' matches the hierarchy in the generated HTML. When you see complex layout code 
#' like this:
fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Observations:", min = 0, max = 1000, value = 500)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
#' First skim it by focusing on the hierarchy of the function calls:
fluidPage(
  titlePanel(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs")
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
#' This code will generate a classic app design:\
#' a title bar at top, followed by a sidebar (containing a slider), with the 
#' main panel containing a plot. 
#' 
#' 
#' **Page functions**
#' 
#' The most important, but least interesting, layout function is *fluidPage()*\
#' The page function sets up all the HTML, CSS, and JS that Shiny needs. 
#' *fluidPage()* uses a layout system called Bootstrap <https://getbootstrap.com>
#' that provides attractive defaults.
#' 
#' Technically, fluidPage() is all one need for an app, but while this is fine for 
#' learning the basics of Shiny, dumping all the inputs and outputs in one place 
#' doesn’t look very good, so we need to learn more layout functions.
#' Two common layouts are *Page with sidebar* and *Multirow app*.
#' 
#' **Page with sidebar**
#' 
#' *sidebarLayout()*, along with *titlePanel()*, *sidebarPanel()* & *mainPanel()*
#' makes it easy to create a two-column layout with inputs on the left and 
#' outputs on the right.
fluidPage(
  titlePanel(
    # app title/description
  ),
  sidebarLayout(
    sidebarPanel(
      # inputs
    ),
    mainPanel(
      # outputs
    )
  )
)
#' Example: Central Limit Theorem usage
ui <- fluidPage(
  titlePanel("Central limit theorem"),
  sidebarLayout(
    sidebarPanel(
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}
shinyApp(ui, server)
#' 
#' 
#' **Multi-row**
#' 
#' Under the hood, *sidebarLayout()* is built on top of a flexible multi-row 
#' layout, which can be used directly to create more visually complex apps.\
#' Start with *fluidPage()*, then create rows with *fluidRow()* and columns with 
#' *column()*.\
#' Note: the first argument to column() is the width, and the width of each 
#' row must add up to 12.
fluidPage(
  fluidRow(
    column(4, 
      ...
    ),
    column(8, 
      ...
    )
  ),
  fluidRow(
    column(6, 
      ...
    ),
    column(6, 
      ...
    )
  )
)
#'
#'
#' **Themes**
#' 
#' Creating a complete theme from scratch is a lot of work (but often worth it!), 
#' but you can get some easy wins by using the *shinythemes* package.
#' Theming an app is quite straightforward: just use the *theme()* argument inside 
#' fluidPage()\
#' The *fresh* package, which provides even more themes.
#' 
theme_demo <- function(theme) {
fluidPage(
  theme = shinythemes::shinytheme(theme),
  sidebarLayout(
    sidebarPanel(
      textInput("txt", "Text input:", "text here"),
      sliderInput("slider", "Slider input:", 1, 100, 30)
    ),
    mainPanel(
      h1("Header 1"),
      h2("Header 2"),
      p("Some text")
    )
  )
)
}
ui <- theme_demo("darkly")
ui <- theme_demo("flatly")
ui <- theme_demo("sandstone")
ui <- theme_demo("united")
server <- function(input, output, session) {
}
shinyApp(ui, server)
#' 