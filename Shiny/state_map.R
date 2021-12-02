library(shiny)
library(shinydashboard)
library(tidyverse)
library(jsonlite)
library(DT)
library(shinymaterial)
library(httr)
library(rsconnect)


state_map_fn <- function(year_start = 1951, year_end = 2021){
  
  all_stars <- read_csv("../Data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  
  all_star_grouped <- all_stars %>%
    group_by(players)%>%
    filter(row_number() == 1)
  
  all_star_grouped <- all_star_grouped %>% mutate(nationality = str_remove_all(nationality, "United States|England|Greece|Canada|Switzerland"))
  
  all_star_countries <- all_star_grouped%>% mutate(nationality = str_replace(nationality, "^$", "United States"))
  
  all_star_states <- read_csv('../Data/states.csv', show_col_types = F)
  
  all_states <- all_star_states %>% mutate(players = str_remove_all(players, "\\*"))
  
  data <- left_join(all_star_countries, all_states, by = "players")
  
  data <- data%>%filter(nationality == "United States")
  
  data <- data%>% filter(year >= year_start, year <= year_end)
  
  data$state_name <- tolower(data$state_name)
  
  #data has players, countries, and states, mapworld will have countries
  
  mapus <- map_data("state")
  
  by_state <- data %>%
    group_by(state_name) %>%
    count()
  
  mapus$state_name <- mapus$region
  
  mapping_data <- full_join(by_state, mapus, by = "state_name")
  
  mapping_data[c("n")][is.na(mapping_data[c("n")])] <- 0
  
  state_map <- ggplot(mapping_data, aes(long, lat, group = group))+
    geom_polygon(aes(fill = n), color = "white") +
    scale_fill_gradient2(low = muted("red"), mid = "white",
                         high = muted("green"), midpoint = mean(c(max(mapping_data$n), mean(mapping_data$n), 0)),
                         guide = guide_legend(label.position = "bottom"),
                         limits = c(0, 5*(max(mapping_data$n)%/%5+1)),
                         breaks = c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 10)),
                         labels = paste(c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 10)))) +
    theme_void() +
    labs(fill = NULL) +
    theme(plot.background = element_rect(fill = "gainsboro"),
          legend.position = c(0.2, 0.15),
          legend.key.size = unit(0.1, "cm"), legend.direction="horizontal") +
    theme(aspect.ratio=0.6)
  
  state_map
  
}