state_map_fn <- function(per_capita = T, year_start = 1951, year_end = 2021){
  
  all_stars <- read_csv("data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  
  all_star_grouped <- all_stars %>%
    group_by(players)%>%
    filter(row_number() == 1)
  
  pop <- read_csv("data/nst-est2020.csv", show_col_types = F)
  
  all_star_grouped <- all_star_grouped %>% mutate(nationality = str_remove_all(nationality, "United States|England|Greece|Canada|Switzerland"))
  
  all_star_countries <- all_star_grouped%>% mutate(nationality = str_replace(nationality, "^$", "United States"))
  
  all_star_states <- read_csv('data/states.csv', show_col_types = F)
  
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
  
  pop$state_name <- tolower(pop$state)
  
  mapping_data
  
  pop
  
  states_pop <- left_join(mapping_data, pop, by = "state_name")
  
  states_pop$percap = states_pop$n/(states_pop$pop2020/1000000)
  
  if(per_capita == F){
    state_map <- ggplot(mapping_data, aes(long, lat, group = group))+
      geom_polygon(aes(fill = n), color = "white") +
      scale_fill_gradient2(low = muted("red"), mid = "white",
                           high = muted("green"), midpoint = mean(c(max(mapping_data$n), mean(mapping_data$n), 0)),
                           guide = guide_legend(label.position = "bottom"),
                           limits = c(0, 5*(max(mapping_data$n)%/%5+1)),
                           breaks = c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 10)),
                           labels = paste(c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 10)))) +
      theme_void() +
      theme(plot.background = element_rect(fill = "gainsboro"),
            legend.position = c(0.03, 0.3),
            legend.key.size = unit(0.3, "cm"), legend.direction="vertical") +
      theme(aspect.ratio=0.6)
  } 
  
  #+labs(fill = NULL, title = "All-Stars by birth state",subtitle = paste0("United States, ", year_start, " to ", year_end)) 
  
  else if(per_capita == T){
    
    state_map <- ggplot(states_pop, aes(long, lat, group = group))+
      geom_polygon(aes(fill = states_pop$percap), color = "white") +
      scale_fill_gradient2(low = muted("red"), mid = "white",
                           high = muted("green"), 
                           midpoint = mean(c(max(states_pop$percap, na.rm = TRUE),
                                             mean(states_pop$percap, na.rm = TRUE), 0)),
                           guide = guide_legend(label.position = "bottom"),
                           limits = c(0, max(states_pop$percap, na.rm = TRUE) + 1),
                           breaks = c(seq(0, round(max(states_pop$percap, na.rm = TRUE)+1), by = 1)),
                           labels = c(seq(0, round(max(states_pop$percap, na.rm = TRUE)+1), by = 1))) +
      labs(fill = NULL, title = "Number of All-Stars by birth state",
           subtitle = paste0("Per million residents, ", year_start, " to ", year_end))+
    theme_void() +
      theme(plot.background = element_rect(fill = "gainsboro"),
            legend.position = c(0.03, 0.3),
            legend.key.size = unit(0.3, "cm"), legend.direction="vertical") +
      theme(aspect.ratio=0.6)
    
  }
  
  state_map
  
}