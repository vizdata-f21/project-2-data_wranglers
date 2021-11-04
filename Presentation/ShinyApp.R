library(shiny)
library(shinydashboard)
library(tidyverse)
library(jsonlite)
library(DT)
library(shinymaterial)
library(httr)
library(rsconnect)

# load api helper functions

# user interface
ui<- fluidPage(
  
  # App title
  titlePanel("Shiny App")
)

server <- function(input, output) {
}

# run the application 
shinyApp(ui = ui, server = server)