library(shiny)
library(shinydashboard)
library(tidyverse)
library(jsonlite)
library(DT)
library(shinymaterial)
library(httr)
library(rsconnect)

world_map_fn <- function(year_start = 1951, year_end = 2021){
  
  all_stars <- read_csv('./Data/all_star.csv')
  
  all_stars %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  
  all_star_grouped <- all_stars %>%
    group_by(players)%>%
    filter(row_number() == 1)
  
  all_star_grouped <- all_star_grouped %>% mutate(nationality = str_remove_all(nationality, "United States|England|Greece|Canada|Switzerland"))
  
  all_star_countries <- all_star_grouped%>% mutate(nationality = str_replace(nationality, "^$", "United States"))
  
  all_star_states <- read_csv('./Data/states.csv')
  
  all_states <- all_star_states %>% mutate(players = str_remove_all(players, "\\*"))
  
  data <- left_join(all_star_countries, all_states, by = "players")
  
  data <- data%>% filter(year >= year_start, year <= year_end)
  
  view(data)
  
    
}


