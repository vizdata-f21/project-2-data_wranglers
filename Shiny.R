library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(tidyverse)
library(gganimate)
library(scales)
library(shinymaterial)
library(shinyWidgets)
# windowsFonts("Times" = windowsFont("Times"))

source("shiny/all_star_colleges.R")
source("shiny/college_locations.R")
source("shiny/draft_position_edited.R")
source("shiny/all_star_teams_edited.R")


ui <- fluidPage(
  title = "NBA All-Star Analysis",
  
  
  dashboardPage(skin = "green",
                dashboardHeader(title = "NBA All-Stars",
                                titleWidth = '100%'),
                dashboardSidebar(
                  width = 150,
                  sidebarMenu(
                    menuItem("All-Stars", icon = icon("star"), startExpanded = TRUE,
                             menuSubItem("Colleges", tabName = "as_college"),
                             menuSubItem("College State", tabName = "as_state"),
                             menuSubItem("College Location", tabName = "as_loc"),
                             menuSubItem("Draft Positions", tabName = "as_draft"),
                             menuSubItem("Team", tabName = "as_team")
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
                            material_card(
                              title = NULL,
                              depth = 6,
                              radioButtons("duplicate_players", "What would you like to count?",
                                           choices = c("Total All-Star Game appearances by players" = T,
                                                       "Number of players who have made an All-Star Game" = F), selected = T),
                              sliderInput("year_range_by_college", "Year Range",
                                          min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                              sliderInput("colleges_to_rank", "Colleges to Rank:",
                                          value = 10, min = 3, max = 20, ticks = FALSE),
                              sliderInput("duration_anim_by_college", "Duration:",
                                          value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                              sliderInput("fps_anim_by_college", "Frames per Second:",
                                          value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                              sliderTextInput("end_pause_anim_by_college_in", "Pause at End of Animation:",
                                          choices = c("Short", "Medium", "Long"), selected = "Medium"),
                              submitButton("Animate!")
                          ),
                          material_row(
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
                                        min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                            submitButton("Plot!")
                          )
                        ),
                        material_row(
                          plotOutput("plot_result_by_state")
                        )
                      )
                    ),
                    
                    tabItem(
                      tabName = "as_loc",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
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
                              submitButton("Animate!")
                            )
                          ),
                          material_row(
                            imageOutput("plot_anim_by_college_loc")
                          )
                        )
                      ),
                    tabItem(
                      tabName = "as_draft",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
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
                              submitButton("Animate!")
                            )
                          ),
                          material_row(
                            imageOutput("plot_anim_by_draft")
                          )
                        )
                      ),
                    
                    tabItem(
                      tabName = "as_team",
                      material_page(
                        nav_bar_color = 'black',
                        material_row(
                            material_card(
                              title = '',
                              depth = 4,
                              sliderInput("year_range_by_team", "Year Range",
                                          min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                              sliderInput("teams_to_rank", "Teams to Rank (with the most All-Stars):",
                                          value = 30, min = 3, max = 30, ticks = FALSE),
                              sliderInput("duration_anim_by_team", "Duration:",
                                          value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                              sliderInput("fps_anim_by_team", "Frames per Second:",
                                          value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                              sliderInput("end_pause_anim_by_team", "End Pause:",
                                          value = 25, min = 5, max = 100, step = 5, ticks = FALSE),
                              submitButton("Animate!")
                            )
                          ),
                          material_row(
                            imageOutput("plot_anim_by_team")
                          )
                        
                      )
                    )
                    )
                    
                  )
                )
  )





server <- function(input, output, session) {
  
  

# ALL STARS BY COLLEGE ----------------------------------------------------

  
    output$plot_anim_by_college <- renderImage({
      all_stars_by_college <- tempfile(fileext='.gif')
      
      all_stars_by_college_anim <- number_of_all_stars_by_college(duplicate_players = input$duplicate_players, 
                                                                  year_start = input$year_range_by_college[[1]],
                                                                  year_end = input$year_range_by_college[[2]])
      
      if(input$end_pause_anim_by_college_in == "Short"){
        end_pause_anim_by_college <- (input$fps_anim_by_college*input$duration_anim_by_college)%/%10
      }
      else if(input$end_pause_anim_by_college_in == "Medium"){
        end_pause_anim_by_college <- (input$fps_anim_by_college*input$duration_anim_by_college)%/%5
      }
      else {
        end_pause_anim_by_college <- (input$fps_anim_by_college*input$duration_anim_by_college)%/%3
      }
      
      anim_save("all_stars_by_college.gif", animate(all_stars_by_college_anim,
                                                    fps = input$fps_anim_by_college,
                                                    end_pause = end_pause_anim_by_college,
                                                    duration = input$duration_anim_by_college))
      
      
      list(src = "all_stars_by_college.gif",
           contentType = 'image/gif'
      )}, deleteFile = TRUE)
  
    

# ALL STARS BY COLLEGE STATE ----------------------------------------------

    
  output$plot_result_by_state <- renderPlot({
    all_stars_by_state(per_capita = input$per_capita, year_start = input$year_range_by_state_loc[[1]],
                       year_end = input$year_range_by_state_loc[[2]])
  })
  

# ALL STARS BY COLLEGE LOCATION -------------------------------------------

  
  
    output$plot_anim_by_college_loc <- renderImage({
      all_stars_by_location <- tempfile(fileext='.gif')
      
      all_stars_by_college_location <- all_stars_by_college_loc(year_start = input$year_range_by_college_loc[[1]],
                                                                year_end = input$year_range_by_college_loc[[2]])
      
      anim_save("all_stars_by_location.gif", animate(all_stars_by_college_location,
                                                     fps = input$fps_anim_loc,
                                                     end_pause = input$end_pause_anim_loc,
                                                     duration = input$duration_anim_loc,
                                                     height = 450, width = 650))
      
      
      list(src = "all_stars_by_location.gif",
           contentType = 'image/gif'
      )}, deleteFile = TRUE)
    

# ALL STARS BY DRAFT ------------------------------------------------------

    
    
      output$plot_anim_by_draft <- renderImage({
        all_stars_by_draft <- number_of_all_stars_by_draft(year_start = input$year_range_by_draft[[1]],
                                                           year_end = input$year_range_by_draft[[2]])
        
        anim_save("all_stars_by_draft.gif", animate(all_stars_by_draft,
                                                    fps = input$fps_anim_by_draft,
                                                    end_pause = input$end_pause_anim_by_draft,
                                                    duration = input$duration_anim_by_draft))
        
        list(src = "all_stars_by_draft.gif",
             contentType = 'image/gif'
        )}, deleteFile = TRUE)
    

# ALL STARS BY TEAM -------------------------------------------------------
    
    
      output$plot_anim_by_team <- renderImage({
        all_stars_by_team <- number_of_all_stars_by_team(year_start = input$year_range_by_team[[1]],
                                                         year_end = input$year_range_by_team[[2]],
                                                         number_to_rank = input$teams_to_rank)
        
        anim_save("all_stars_by_team.gif", animate(all_stars_by_team,
                                                   fps = input$fps_anim_by_team,
                                                   end_pause = input$end_pause_anim_by_team,
                                                   duration = input$duration_anim_by_team))
        
        list(src = "all_stars_by_team.gif",
             contentType = 'image/gif'
        )}, deleteFile = TRUE)
    
  
}




# run the application 
shinyApp(ui = ui, server = server)