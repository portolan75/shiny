library(shiny)          # web app framework 
library(shinyjs)        # improve user experience with JavaScript
#library(shinyFeedback) # improve user experience with feedbacks (warnings too)
#library(tidyverse)     # data manipulation
library(DBI)            # database driver and communications

# Db path - ----
#options(shiny.sanitize.errors = TRUE)
db_path <- file.path("/Users/DjBlue/Documents/R", "SQLite_databases", "TYT.db")

# Function to connect to url and extract geolocation info
GeolocateUser <- function() {
  url <- "https://freegeoip.app/json"
  geo <- jsonlite::fromJSON(readLines(url, warn = FALSE))
  geo
}

# Function to extract the current userbase from db
GetCurrentUsers <- function() {
  conn <- dbConnect(RSQLite::SQLite(), db_path)
  user_tbl <- dbGetQuery(conn, "SELECT id, user, password FROM user")
  dbDisconnect(conn)
  user_tbl
}
# Get existing userbase from db
user_tbl <- GetCurrentUsers()

# Function to add a new user in the db
AddNewUser <- function(new_user, new_pass) {
  conn <- dbConnect(RSQLite::SQLite(), db_path)
  query_insert <- sprintf(
    "INSERT INTO user (user, password) VALUES ('%s', '%s')", 
    new_user,
    new_pass
  )
  
  # Update the database
  dbExecute(conn, query_insert)
  dbDisconnect(conn)
}

# Function to upload logs in log table
UpdateLog <- function(user) {
  conn <- dbConnect(RSQLite::SQLite(), db_path)
  query_insert <- sprintf(
    "INSERT INTO log (logtime, logtext, user_id) VALUES ('%s', '%s', %d)",
    Sys.time(),
    jsonlite::toJSON(GeolocateUser()),
    user_tbl[user_tbl$user == user, "id"]
  )
  # Update the database
  dbExecute(conn, query_insert)
  dbDisconnect(conn)
}
