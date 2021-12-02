library(shiny)
library(shinydashboard)
library(dashboardthemes)
#extrafont::loadfonts(device="win")
library(tidyverse)
library(gganimate)
library(scales)
library(shinymaterial)

source("all_star_colleges.R")
source("college_locations.R")
source("draft_position.R")
source("all_star_teams.R")


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
                        menuSubItem("College Location", tabName = "as_loc"),
                        menuSubItem("Draft Positions", tabName = "as_draft"),
                        menuSubItem("Team", tabName = "as_team"),
                        menuSubItem("World Map", tabName = "world_map"),
                        menuSubItem("U.S. Map", tabName = "us_map")
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
                    ),
                        tabItem(
                          tabName = "as_draft",
                          material_page(
                            nav_bar_color = 'black',
                            material_row(
                              material_column(
                                width = 4,
                                material_card(
                                  title = '',
                                  depth = 4,
                                  sliderInput("year_range_by_draft", "Year Range",
                                              min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                                  sliderInput("duration_anim_by_draft", "Duration:",
                                              value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                                  sliderInput("fps_anim_by_draft", "Frames per Second:",
                                              value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                                  sliderInput("end_pause_anim_by_draft", "End Pause:",
                                              value = 25, min = 5, max = 100, step = 5, ticks = FALSE),
                                  actionButton("animate_by_draft", "Animate!")
                                )
                              ),
                              material_column(
                                imageOutput("plot_anim_by_draft")
                              )
                            )
                          )
                        ),
                    
                    tabItem(
                      tabName = "as_team",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
                          material_column(
                            width = 4,
                            material_card(
                              title = '',
                              depth = 4,
                              sliderInput("year_range_by_team", "Year Range",
                                          min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                              sliderInput("teams_to_rank", "Teams to Rank (with the most All-Stars):",
                                          value = 30, min = 10, max = 30, ticks = FALSE),
                              sliderInput("duration_anim_by_team", "Duration:",
                                          value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                              sliderInput("fps_anim_by_team", "Frames per Second:",
                                          value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                              sliderInput("end_pause_anim_by_team", "End Pause:",
                                          value = 25, min = 5, max = 100, step = 5, ticks = FALSE),
                              actionButton("animate_by_draft", "Animate!")
                            )
                          ),
                          material_column(
                            imageOutput("plot_anim_by_team")
                          )
                        )
                      )
                    ),
                    tabItem(
                      tabName = "world_map",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
                          material_column(
                            width = 4,
                            material_card(
                              title = '',
                              depth = 1,
                              sliderInput("year_range_all_stars", "Year Range",
                                          min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                              actionButton("world_map", "Visualize!")
                            )
                          ),
                          material_column(
                            imageOutput("plot_world_map")
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

  observeEvent(input$anim_by_draft, {
    output$plot_anim_by_draft <- renderImage({
      all_stars_by_draft <- number_of_all_stars_by_draft(year_start = input$year_range_by_draft[[1]],
                                                                year_end = input$year_range_draft[[2]])
      
      anim_save("all_stars_by_draft.gif", animate(all_stars_by_draft,
                                                     fps = input$fps_anim_by_draft,
                                                     end_pause = input$end_pause_anim_by_draft,
                                                     duration = input$duration_anim_by_draft))
      
            list(src = "all_stars_by_draft.gif",
           contentType = 'image/gif'
      )}, deleteFile = TRUE)

  }) 
  
  observeEvent(input$anim_by_team, {
    output$plot_anim_by_team <- renderImage({
      all_stars_by_team <- number_of_all_stars_by_team(year_start = input$year_range_by_team[[1]],
                                                         year_end = input$year_range_team[[2]])
      
      anim_save("all_stars_by_team.gif", animate(all_stars_by_team,
                                                  fps = input$fps_anim_by_team,
                                                  end_pause = input$end_pause_anim_by_team,
                                                  duration = input$duration_anim_by_team))
      
      list(src = "all_stars_by_team.gif",
           contentType = 'image/gif'
      )}, deleteFile = TRUE)
    
  }) 
  
  observeEvent(input$world_map, {
    output$plot_world_map <- renderImage({
      world_map <- world_map_fn(year_start = input$year_range_by_team[[1]],
                                                       year_end = input$year_range_team[[2]])
      
      list(src = "world_map",
           contentType = 'image/gif'
      )}, deleteFile = TRUE)
    
  }) 
  
      
}




# run the application 
shinyApp(ui = ui, server = server)