library(shiny)
library(shinydashboard)
library(dashboardthemes)
extrafont::loadfonts(device="win")
library(tidyverse)
library(gganimate)
library(scales)
library(shinymaterial)

source("all_star_colleges.R")


ui <- fluidPage(
  title = "Spotify API Searcher",
  
  
  dashboardPage(skin = "green",
                dashboardHeader(title = "Spotify API Searcher",
                  titleWidth = '100%'),
                dashboardSidebar(
                  width = 150,
                  sidebarMenu(
                    menuItem("All-Stars", tabName = "all_stars", icon = icon("star"))
                  )
                ),
                dashboardBody(
                  tabItems(
                    tabItem(
                      tabName = "all_stars",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
                          material_column(
                            width = 4,
                            material_card(
                              title = '',
                              depth = 4,
                              sliderInput("duration_anim", "Duration:",
                                          value = 10, min = 5, max = 20, step = 5, ticks = FALSE),
                              sliderInput("fps_anim", "Frames per Second:",
                                          value = 10, min = 5, max = 20, step = 5, ticks = FALSE),
                              sliderInput("end_pause_anim", "End Pause:",
                                          value = 25, min = 5, max = 100, step = 5, ticks = FALSE),
                              actionButton("button", "An action button")
                            )
                          ),
                          material_column(
                            imageOutput("plot1")
                            )
                          )
                        )
                    )
                )
                )
  )
)




server <- function(input, output, session) {

  output$plot1 <- eventReactive(input$button, {
    renderImage({
    all_stars_by_college <- tempfile(fileext='.gif')
    
    # now make the animation
    plot <- number_of_all_stars_by_college()
    
    anim_save("all_stars_by_college.gif", animate(plot,
                                                  fps = input$fps_anim,
                                                  end_pause = input$end_pause_anim,
                                                  duration = input$duration_anim))
    
    # Return a list containing the filename
    
    
      list(src = "all_stars_by_college.gif",
         contentType = 'image/gif'
    )}, deleteFile = TRUE)
  })}


# run the application 
shinyApp(ui = ui, server = server)