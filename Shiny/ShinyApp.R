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
  title = "NBA Player Analysis",
  
  
  dashboardPage(skin = "green",
                dashboardHeader(title = "NBA",
                  titleWidth = '100%'),
                dashboardSidebar(
                  width = 150,
                  sidebarMenu(
                    menuItem("All-Stars", icon = icon("star"), startExpanded = TRUE,
                        menuSubItem("Colleges", tabName = "as_college"),
                        menuSubItem("College State", tabName = "as_state"),
                        menuSubItem("College Location", tabName = "as_loc")
                    )
                  )
                ),
                dashboardBody(
                  tabItems(
                    tabItem(
                      tabName = "as_college",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
                          material_column(
                            width = 4,
                            material_card(
                              title = '',
                              depth = 4,
                              radioButtons("duplicate_players", "Duplicate Players?",
                                           choices = c("Yes" = T, "No" = F), selected = T),
                              sliderInput("year_range_by_college", "Year Range",
                                          min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                              sliderInput("colleges_to_rank", "Colleges to Rank:",
                                          value = 10, min = 3, max = 20, ticks = FALSE),
                              sliderInput("duration_anim_by_college", "Duration:",
                                          value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                              sliderInput("fps_anim_by_college", "Frames per Second:",
                                          value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                              sliderInput("end_pause_anim_by_college", "End Pause:",
                                          value = 25, min = 5, max = 100, step = 5, ticks = FALSE),
                              actionButton("animate_by_college", "Animate!")
                            )
                          ),
                          material_column(
                            imageOutput("plot_anim_by_college")
                            )
                          )
                        )
                    ),
                    
                    tabItem(
                      tabName = "as_state",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
                            material_card(
                              title = '',
                              depth = 4,
                              radioButtons("per_capita", "Per million residents?",
                                           choices = c("Yes" = T, "No" = F), selected = T),
                              sliderInput("year_range_by_state_loc", "Year Range",
                                          min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE)
                            )
                          ),
                          material_row(
                            plotOutput("plot_result_by_state")
                          )
                        )
                      )
                    ,
                    
                    tabItem(
                      tabName = "as_loc",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
                          material_column(
                            width = 4,
                            material_card(
                              title = '',
                              depth = 4,
                              sliderInput("year_range_by_college_loc", "Year Range",
                                          min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                              sliderInput("duration_anim_loc", "Duration:",
                                          value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                              sliderInput("fps_anim_loc", "Frames per Second:",
                                          value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                              sliderInput("end_pause_anim_loc", "End Pause:",
                                          value = 25, min = 5, max = 100, step = 5, ticks = FALSE),
                              actionButton("anim_by_college_loc", "Animate!")
                            )
                          ),
                          material_column(
                            imageOutput("plot_anim_by_college_loc")
                          )
                        )
                      )
                    )
                )
                )
  )
)




server <- function(input, output, session) {

  # want to use eventReactive
  observeEvent(input$animate_by_college, {
    output$plot_anim_by_college <- renderImage({
    all_stars_by_college <- tempfile(fileext='.gif')
    
    all_stars_by_college_anim <- number_of_all_stars_by_college(year_start = input$year_range_by_college[[1]],
                                                                year_end = input$year_range_by_college[[2]])
    
    anim_save("all_stars_by_college.gif", animate(all_stars_by_college_anim,
                                                  fps = input$fps_anim_by_college,
                                                  end_pause = input$end_pause_anim_by_college,
                                                  duration = input$duration_anim_by_college))
    
    
    list(src = "all_stars_by_college.gif",
         contentType = 'image/gif'
    )}, deleteFile = TRUE)
  })
  
  output$plot_result_by_state <- renderPlot({
    all_stars_by_state(per_capita = input$per_capita, year_start = input$year_range_by_state_loc[[1]],
                         year_end = input$year_range_by_state_loc[[2]])
  })
  
  
  observeEvent(input$anim_by_college_loc, {
    output$plot_anim_by_college_loc <- renderImage({
      all_stars_by_location <- tempfile(fileext='.gif')

      all_stars_by_college_location <- all_stars_by_college_loc(year_start = input$year_range_by_college_loc[[1]],
                                                                  year_end = input$year_range_by_college_loc[[2]])

      anim_save("all_stars_by_location.gif", animate(all_stars_by_college_location,
                                                    fps = input$fps_anim_loc,
                                                    end_pause = input$end_pause_anim_loc,
                                                    duration = input$duration_anim_loc))


      list(src = "all_stars_by_location.gif",
           contentType = 'image/gif'
      )}, deleteFile = TRUE)
  })



  
  
  
}




# run the application 
shinyApp(ui = ui, server = server)