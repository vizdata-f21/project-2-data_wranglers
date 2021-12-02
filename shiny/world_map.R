world_map_fn <- function(year_start = 1951, year_end = 2021){
  
  all_stars <- read_csv("data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  
  all_star_grouped <- all_stars %>%
    group_by(players)%>%
    filter(row_number() == 1)
  
  all_star_grouped <- all_star_grouped %>% mutate(nationality = str_remove_all(nationality, "United States|England|Greece|Canada|Switzerland"))
  
  all_star_countries <- all_star_grouped%>% mutate(nationality = str_replace(nationality, "^$", "United States"))
  
  all_star_states <- read_csv('data/states.csv', show_col_types = F)
  
  all_states <- all_star_states %>% mutate(players = str_remove_all(players, "\\*"))
  
  data <- left_join(all_star_countries, all_states, by = "players")
  
  data <- data%>% filter(year >= year_start, year <= year_end)
  
  #data has players, countries, and states, mapworld will have countries
  
  mapworld <- map_data("world")
  
  mapworld$nationality <- mapworld$region
  
  data$nationality <- replace(data$nationality, data$nationality == "United States", "USA")
  
  by_country <- data %>%
    group_by(nationality) %>%
    count()
  
  mapping_data <- full_join(by_country, mapworld, by = "nationality")
  
  world_map <- ggplot(mapping_data, aes(long, lat, group = group))+
    geom_polygon(aes(fill = n), color = "black") +
    scale_fill_continuous(low = "white",
                         high = "red",
                         guide = guide_legend(label.position = "bottom"),
                        trans = "log",
                        limits = c(1, max(mapping_data$n)%/%1)
                        ) +
    theme_void() +
    labs(fill = NULL) +
    theme(plot.background = element_rect(fill = "gainsboro"),
          legend.position = c(0.2, 0.15),
          legend.key.size = unit(0.1, "cm"), legend.direction="horizontal") +
    theme(aspect.ratio=0.6)
  
  world_map
    
}


