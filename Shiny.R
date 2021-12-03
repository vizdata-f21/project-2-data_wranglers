library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(tidyverse)
library(gganimate)
library(scales)
library(shinymaterial)
library(shinyWidgets)
# windowsFonts("Times" = windowsFont("Times"))
# NBA COLOR CODES: #17408B (blue) and #C9082A (red)

source("shiny/all_star_colleges.R")
source("shiny/college_locations.R")
source("shiny/draft_position.R")
source("shiny/all_star_teams.R")
source("shiny/world_map.R")
source("shiny/state_map.R")


ui <- fluidPage(
  title = "NBA All-Star Analysis",
  
  
  dashboardPage(skin = "black",
                dashboardHeader(title = span(
                  img(src="https://pngimg.com/uploads/nba/nba_PNG14.png", height = "100%", align = "left"),
                  strong("NBA All-Stars"),
                  img(src="https://i.guim.co.uk/img/media/86302dbcc55f07d65c45bb3baf8c864e36bd4320/0_155_3600_2159/master/3600.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=df936fc2e7b2b84a58f2e293ecde27de", height = "100%", align = "right"),
                  img(src="https://nypost.com/wp-content/uploads/sites/2/2021/06/Kevin-Durant-1.jpg?quality=80&strip=all", height = "100%", align = "right"),
                  img(src="https://ca-times.brightspotcdn.com/dims4/default/1ab5cea/2147483647/strip/true/crop/2048x1365+0+0/resize/1486x990!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F10%2F7c%2Ffaa3b146abc9a51ca5a5acf6219f%2Fla-sp-sn-dan-gilbert-lebron-james-20140707-001", height = "100%", align = "right"),
                  img(src="https://phantom-marca.unidadeditorial.es/68bef1f479f444ff1a1cc282ebfe9099/resize/1320/f/jpg/assets/multimedia/imagenes/2021/11/20/16373850780611.jpg", height = "100%", align = "right"),
                  img(src="https://kubrick.htvapps.com/htv-prod-media.s3.amazonaws.com/images/zion-cover-1618697232.jpg?crop=1.00xw:0.846xh;0,0.0147xh&resize=900:*", height = "100%", align = "right")),
                                titleWidth = '100%'),
                dashboardSidebar(
                  width = 150,
                  sidebarMenu(
                    menuItem("Home", tabName = "home", icon = icon("home")),
                    menuItem("All-Stars", icon = icon("star"), startExpanded = TRUE,
                             menuSubItem("Colleges", tabName = "as_college"),
                             menuSubItem("College State", tabName = "as_state"),
                             menuSubItem("College Location", tabName = "as_loc"),
                             menuSubItem("Draft Positions", tabName = "as_draft"),
                             menuSubItem("Team", tabName = "as_team"),
                             menuSubItem("World Map", tabName = "world_map"),
                             menuSubItem("U.S. Map", tabName = "state_map")
                    )
                  )
                ),
                dashboardBody(
                  tabItems(
                    tabItem(tabName = "home",
                            br(),
                            p("This Shiny App was created by the Data Wranglers, a group in Dr. Mine Çetinkaya-Rundel's class, Advanced Data Visualization.
                              Sarab Bhasin, Owen Henry, and Zach Khazzam contributed to the project."),
                            br(),
                            h1("Data"),
                            p("The data used in this project was accessed from",
                              tags$a(href="https://en.wikipedia.org/wiki/Module:College_color/data", 
                                     "Wikipedia"), ",",
                              tags$a(href="https://www.basketball-reference.com/", "Basketball Reference"), ",",
                              tags$a(href="https://basketball.realgm.com/", "RealGM"), ",",
                              tags$a(href="https://www.census.gov/programs-surveys/popest/technical-documentation/research/evaluation-estimates/2020-evaluation-estimates/2010s-totals-national.html",
                              "The United States Census Bureau"), ", and",
                              tags$a(href="https://data.ed.gov/dataset/college-scorecard-all-data-files-through-6-2020/resources",
                              "The United States Department of Education.")),
                            p("Prior to scraping data from Wikipedia, Basketball Reference, and RealGM, we verified using the",
                              code("robots.txt"), "file that scraping was scrape-able.")),
                    tabItem(
                      tabName = "as_college",
                      radioButtons("duplicate_players", "What would you like to count?",
                                   choices = c("Total All-Star Game appearances by players" = T,
                                               "Number of players who have made an All-Star Game" = F), selected = T),
                      p(span("Example:", style = "font-weight: bold; color: gray"), span(HTML("If you would like to count Michael Jordan's 14<br/>All-Star appearances 
                             14 times for UNC, choose"), style = "color: gray"), span("Option 1.", style = "font-weight: bold; color: gray"),
                        span(HTML("<br/>If you would like to count Michael Jordan being an NBA<br/>All-Star just 1 time 
                             for UNC, choose"), style = "color: gray"), span("Option 2.", style = "font-weight: bold; color: gray")),
                      sliderInput("year_range_by_college", "Year Range",
                                  min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE), 
                      sliderInput("colleges_to_rank", "Colleges to Rank:",
                                  value = 10, min = 3, max = 20, ticks = FALSE),
                      p(span("Caution:", style = "font-weight: bold; color: gray"),
                        span(HTML("Choosing higher animation length and FPS values<br/>will cause the animation to 
                             take longer to render!<br/>(But will look nicer)"), style = "color: gray")),
                      sliderInput("duration_anim_by_college", "Animation Length (seconds):",
                                  value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                      sliderInput("fps_anim_by_college", "Frames per Second: ",
                                  value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                      sliderTextInput("end_pause_anim_by_college_in", "Pause at End of Animation:",
                                      choices = c("Short", "Medium", "Long"), selected = "Medium"),
                      actionButton("animate_by_college", "Animate!"),
                      br(), br(),
                      imageOutput("plot_anim_by_college"),
                      br(), br(), br(),br(), br(), br(),br(), br(), br(),  style='width: 2000px'
                    ),
                    
                    tabItem(
                      tabName = "as_state",
                      radioButtons("per_capita", "Per million residents?",
                                   choices = c("Yes" = T, "No" = F), selected = T),
                      sliderInput("year_range_by_state_loc", "Year Range",
                                  min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                      actionButton("plot_by_state", "Plot!"),
                      br(), br(),
                      plotOutput("plot_result_by_state"),
                      br(), br(), br(),br(), br(), br(),br(), br(), br(),
                      br(), br(), br(),br(), br(), br(),br(), br(), br()
                    ),
                    
                    tabItem(
                      tabName = "as_loc",
                      sliderInput("year_range_by_college_loc", "Year Range",
                                  min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                        p(span("Caution:", style = "font-weight: bold; color: gray"),
                          span(HTML("Choosing higher animation length and FPS values<br/>will cause the animation to 
                             take longer to render!<br/>(But will look nicer)"), style = "color: gray")),
                      sliderInput("duration_anim_loc", "Animation Length (seconds):",
                                  value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                      sliderInput("fps_anim_loc", "Frames per Second:",
                                  value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                      sliderInput("end_pause_anim_loc", "End Pause:",
                                  value = 25, min = 5, max = 100, step = 5, ticks = FALSE),
                      actionButton("plot_anim_by_college_loc_button", "Animate!"),
                      br(), br(),
                      imageOutput("plot_anim_by_college_loc"),
                      br(), br(), br(),br(), br(), br(),br(), br(), br()
                    ),
                    tabItem(
                      tabName = "as_draft",
                      sliderInput("year_range_by_draft", "Year Range",
                                  min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                        p(span("Caution:", style = "font-weight: bold; color: gray"),
                          span(HTML("Choosing higher animation length and FPS values<br/>will cause the animation to 
                             take longer to render!<br/>(But will look nicer)"), style = "color: gray")),
                      sliderInput("duration_anim_by_draft", "Animation Length (seconds):",
                                  value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                      sliderInput("fps_anim_by_draft", "Frames per Second:",
                                  value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                      sliderTextInput("end_pause_anim_by_draft", "Pause at End of Animation:",
                                      choices = c("Short", "Medium", "Long"), selected = "Medium"),
                      actionButton("anim_by_draft_button", "Animate!"),
                      br(), br(),
                      imageOutput("plot_anim_by_draft"),
                      br(), br(), br(),br(), br(), br(),br(), br(), br()
                    ),
                    
                    tabItem(
                      tabName = "as_team",
                      sliderInput("year_range_by_team", "Year Range",
                                  min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                      sliderInput("teams_to_rank", "Teams to Rank (with the most All-Stars):",
                                  value = 30, min = 3, max = 30, ticks = FALSE),
                        p(span("Caution:", style = "font-weight: bold; color: gray"),
                          span(HTML("Choosing higher animation length and FPS values<br/>will cause the animation to 
                             take longer to render!<br/>(But will look nicer)"), style = "color: gray")),
                      sliderInput("duration_anim_by_team", "Animation Length (seconds):",
                                  value = 10, min = 5, max = 30, step = 5, ticks = FALSE),
                      sliderInput("fps_anim_by_team", "Frames per Second:",
                                  value = 10, min = 5, max = 40, step = 5, ticks = FALSE),
                      sliderTextInput("end_pause_anim_by_team", "Pause at End of Animation:",
                                      choices = c("Short", "Medium", "Long"), selected = "Medium"),
                      actionButton("anim_by_team_button", "Animate!"),
                      br(), br(),
                      imageOutput("plot_anim_by_team"),
                      br(), br(), br(),br(), br(), br(),br(), br(), br()
                    ),
                    tabItem(
                      tabName = "world_map",
                      sliderInput("year_range_world", "Year Range",
                                  min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                      actionButton("plot_world_button", "Plot!"),
                      plotOutput("plot_world")
                    ),
                    tabItem(
                      tabName = "state_map",
                      radioButtons("per_capita", "Per million residents?",
                                   choices = c("Yes" = T, "No" = F), selected = T),
                      sliderInput("year_range_state", "Year Range",
                                  min = 1951, max = 2021, value = c(1951, 2021), sep = "", ticks = FALSE),
                      actionButton("plot_usa_state_button", "Plot!"),
                      br(), br(),
                      plotOutput("plot_state"),
                      br(), br(), br(),br(), br(), br(),br(), br(), br()
                    )
                    
                  )
                )
  )
  
  
)





server <- function(input, output, session) {
  
  
  
  # ALL STARS BY COLLEGE ----------------------------------------------------
  
  
  func_out_by_college <- eventReactive(input$animate_by_college, {
    number_of_all_stars_by_college(duplicate_players = input$duplicate_players,
                                   year_start = input$year_range_by_college[[1]],
                                   year_end = input$year_range_by_college[[2]],
                                   number_to_rank = input$colleges_to_rank)
  })
  
  anim_inputs_by_college <- eventReactive(input$animate_by_college, {
    c(input$duration_anim_by_college,
      input$fps_anim_by_college)
  })
  
  end_by_college_pause_input <- eventReactive(input$animate_by_college, {
    input$end_pause_anim_by_college_in
  })
  
  output$plot_anim_by_college <- renderImage({
    all_stars_by_college <- tempfile(fileext='.gif')
    
    if(end_by_college_pause_input() == "Short"){
      end_by_college <- (anim_inputs_by_college()[1]*anim_inputs_by_college()[2])%/%10
    }
    else if(end_by_college_pause_input() == "Medium"){
      end_by_college <- (anim_inputs_by_college()[1]*anim_inputs_by_college()[2])%/%5
    }
    else {
      end_by_college <- (anim_inputs_by_college()[1]*anim_inputs_by_college()[2])%/%3
    }
    
    anim_save("all_stars_by_college.gif", animate(func_out_by_college(), duration = anim_inputs_by_college()[1],
                                                  fps = anim_inputs_by_college()[2],
                                                  end_pause = end_by_college))
    
    
    list(src = "all_stars_by_college.gif",
         contentType = 'image/gif'
    )}, deleteFile = TRUE)
  
  
  
  # ALL STARS BY COLLEGE STATE ----------------------------------------------
  
  func_out_by_state <- eventReactive(input$plot_by_state, {
    all_stars_by_state(per_capita = input$per_capita, year_start = input$year_range_by_state_loc[[1]],
                       year_end = input$year_range_by_state_loc[[2]])
  })
  
  output$plot_result_by_state <- renderPlot({
    func_out_by_state()
  })
  
  
  # ALL STARS BY COLLEGE LOCATION -------------------------------------------
  
  
  
  func_out_by_college_loc <- eventReactive(input$plot_anim_by_college_loc_button, {
    all_stars_by_college_loc(year_start = input$year_range_by_college_loc[[1]],
                             year_end = input$year_range_by_college_loc[[2]])
  })
  
  anim_inputs_by_college_loc <- eventReactive(input$plot_anim_by_college_loc_button, {
    c(input$duration_anim_loc,
      input$fps_anim_loc)
  })
  
  end_by_college_pause_input_loc <- eventReactive(input$plot_anim_by_college_loc_button, {
    input$end_pause_anim_loc
  })
  
  
  
  output$plot_anim_by_college_loc <- renderImage({
    all_stars_by_college_loc <- tempfile(fileext='.gif')
    
    if(end_by_college_pause_input_loc() == "Short"){
      end_by_college_loc <- (anim_inputs_by_college_loc()[1]*anim_inputs_by_college_loc()[2])%/%10
    }
    else if(end_by_college_pause_input_loc() == "Medium"){
      end_by_college_loc <- (anim_inputs_by_college_loc()[1]*anim_inputs_by_college_loc()[2])%/%5
    }
    else {
      end_by_college_loc <- (anim_inputs_by_college_loc()[1]*anim_inputs_by_college_loc()[2])%/%3
    }
    
    anim_save("all_stars_by_college_loc.gif", animate(func_out_by_college_loc(), duration = anim_inputs_by_college_loc()[1],
                                                      fps = anim_inputs_by_college_loc()[2],
                                                      end_pause = end_by_college_loc,
                                                      height = 450, width = 650))
    
    
    list(src = "all_stars_by_college_loc.gif",
         contentType = 'image/gif'
    )}, deleteFile = TRUE)
  
  
  # ALL STARS BY DRAFT ------------------------------------------------------
  
  func_all_stars_by_draft <- eventReactive(input$anim_by_draft_button, {
    number_of_all_stars_by_draft(year_start = input$year_range_by_draft[[1]],
                                 year_end = input$year_range_by_draft[[2]])
  })
  
  anim_inputs_by_draft <- eventReactive(input$anim_by_draft_button, {
    c(input$duration_anim_by_draft,
      input$fps_anim_by_draft)
  })
  
  end_by_college_pause_input_draft <- eventReactive(input$anim_by_draft_button, {
    input$end_pause_anim_by_draft
  })
  
  
  
  output$plot_anim_by_draft <- renderImage({
    all_stars_by_draft <- tempfile(fileext='.gif')
    
    if(end_by_college_pause_input_draft() == "Short"){
      end_by_draft <- (anim_inputs_by_draft()[1]*anim_inputs_by_draft()[2])%/%10
    }
    else if(end_by_college_pause_input_draft() == "Medium"){
      end_by_draft <- (anim_inputs_by_draft()[1]*anim_inputs_by_draft()[2])%/%5
    }
    else {
      end_by_draft <- (anim_inputs_by_draft()[1]*anim_inputs_by_draft()[2])%/%3
    }
    
    anim_save("all_stars_by_draft.gif", animate(func_all_stars_by_draft(),
                                                duration = anim_inputs_by_draft()[1],
                                                fps = anim_inputs_by_draft()[2],
                                                end_pause = end_by_draft))
    
    
    list(src = "all_stars_by_draft.gif",
         contentType = 'image/gif'
    )}, deleteFile = TRUE)
  
  
  # ALL STARS BY TEAM -------------------------------------------------------
  
  
  func_all_stars_by_team <- eventReactive(input$anim_by_team_button, {
    number_of_all_stars_by_team(year_start = input$year_range_by_team[[1]],
                                year_end = input$year_range_by_team[[2]],
                                number_to_rank = input$teams_to_rank)
  })
  
  anim_inputs_by_team <- eventReactive(input$anim_by_team_button, {
    c(input$duration_anim_by_team,
      input$fps_anim_by_team)
  })
  
  end_by_college_pause_input_team <- eventReactive(input$anim_by_team_button, {
    input$end_pause_anim_by_team
  })
  
  
  
  output$plot_anim_by_team <- renderImage({
    all_stars_by_team <- tempfile(fileext='.gif')
    
    if(end_by_college_pause_input_team() == "Short"){
      end_by_team <- (anim_inputs_by_team()[1]*anim_inputs_by_team()[2])%/%10
    }
    else if(end_by_college_pause_input_team() == "Medium"){
      end_by_team <- (anim_inputs_by_team()[1]*anim_inputs_by_team()[2])%/%5
    }
    else {
      end_by_team <- (anim_inputs_by_team()[1]*anim_inputs_by_team()[2])%/%3
    }
    
    anim_save("all_stars_by_team.gif", animate(func_all_stars_by_team(),
                                               duration = anim_inputs_by_team()[1],
                                               fps = anim_inputs_by_team()[2],
                                               end_pause = end_by_team))
    
    
    list(src = "all_stars_by_team.gif",
         contentType = 'image/gif'
    )}, deleteFile = TRUE)
  
  
  # ALL STARS BY BIRTHPLACE (WORLD) -------------------------------------------------------      
  
  func_out_world <- eventReactive(input$plot_world_button, {
    world_map_fn(year_start = input$year_range_world[[1]],
                 year_end = input$year_range_world[[2]])
  })
  
  output$plot_world <- renderPlot({
    func_out_world()
  })
  
  # ALL STARS BY BIRTHPLACE (US) -------------------------------------------------------            
  
  func_out_state_usa <- eventReactive(input$plot_usa_state_button, {
    state_map_fn(per_capita = input$per_capita, year_start = input$year_range_state[[1]],
                 year_end = input$year_range_state[[2]])
  })
  
  output$plot_state <- renderPlot({
    func_out_state_usa()
  })
}




# run the application 
shinyApp(ui = ui, server = server)