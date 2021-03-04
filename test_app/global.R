library(shiny)          # web app framework 
library(shinyjs)        # improve user experience with JavaScript
#library(shinyFeedback)  # improve user experience with feedbacks (warnings too)
#library(tidyverse)     # data manipulation
library(DBI)            # database driver and communications

#' Db path and connection - ----
db_path <- file.path("/Users/DjBlue/Documents/R", "SQLite_databases", "TYT.db")
conn <- dbConnect(RSQLite::SQLite(), db_path)

#' Function to extract the current userbase from db - ----
GetCurrentUsers <- function() {
  user_tbl <- dbGetQuery(conn, "SELECT user, password FROM user")
  dbDisconnect(conn)
  user_tbl
}

#' 1. Get existing userbase from db - ----
user_tbl <- GetCurrentUsers()
