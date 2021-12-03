all_stars_by_state <- function (per_capita = T,
                                            year_start = 1951,
                                            year_end = 2021) {
  all_stars <- read_csv("data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  colleges <- read_csv("data/colleges.csv", show_col_types = F)
  
  data <- right_join(colleges, all_stars) %>%
    select(players, college, year) %>%
    filter(!is.na(college)) %>%
    select(players, college, year) %>%
    filter(!is.na(college)) %>%
    mutate(college = ifelse(str_detect(college, "Indiana, Georgetown"), "Georgetown", college)) %>%
    mutate(college = ifelse(str_detect(college, "Niagara"), "Niagara", college)) %>%
    mutate(college = ifelse(str_detect(college, "Midland College, Oklahoma"), "Oklahoma", college)) %>%
    mutate(college = ifelse(str_detect(college, "Bradley, New Mexico"), "New Mexico", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, Michigan"), "Michigan", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, UNLV"), "UNLV", college)) %>%
    mutate(college = ifelse(str_detect(college, "Trinity Valley CC, Cincinnati"), "Cincinnati", college)) %>%
    filter(duplicated(players, college) == FALSE)
  
  college_locations <- read_csv("data/college_locations.csv", show_col_types = F) %>%
    select(NAME, LAT, LON, STATE) %>%
    rename(college = NAME,
           lat1 = LAT) %>%
    janitor::clean_names()
  
  
  locations_all_stars <- left_join(data, college_locations)
  
  locations_all_stars <- locations_all_stars %>%
    filter(year >= year_start & year <= year_end)
  
  

  pop <- read_csv("data/nst-est2020.csv", show_col_types = F)
  
  # Chloropleth -------------------------------------------------------------
  
  
  mapping <- map_data("state")
  
  mapping$state <- state.abb[match(str_to_title(map_data("state")$region), state.name)]
  
  mapping <- mapping %>%
    mutate(state = ifelse(is.na(state), "DC", state))
  
  by_state <- locations_all_stars %>%
    group_by(state) %>%
    count()
  
  mapping_data <- full_join(by_state, mapping, by = "state")
  
  mapping_data[c("n")][is.na(mapping_data[c("n")])] <- 0
  
  if(per_capita == F){
    if(max(mapping_data$n) >=20){
    state_map_as <- ggplot(mapping_data, aes(long, lat, group = group))+
      geom_polygon(aes(fill = n), color = "white") +
      scale_fill_gradient2(low = muted("#C9082A"), mid = "white",
                           high = muted("#17408B"), midpoint = mean(c(max(mapping_data$n), mean(mapping_data$n), 0)),
                           guide = guide_legend(label.position = "bottom"),
                           limits = c(0, 5*(max(mapping_data$n)%/%5+1)),
                           breaks = c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 10)),
                           labels = paste(c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 10)))) +
      theme_void() +
      labs(fill = NULL) +
      theme(panel.background = element_rect(fill = "gainsboro"),
            legend.position = c(0.2, 0.15),
            legend.key.size = unit(0.8, "cm"), legend.direction="horizontal",
            panel.border = element_rect(fill = NA, color = "black", size = 1),
            plot.title = element_text(family = "Times", size = 24, hjust = 0.02),
            plot.subtitle = element_text(family = "Times", size = 16, margin=margin(3,0,4,0), hjust = 0.015)) +
      labs(title = "Number of All-Stars by college state",
           subtitle = paste0("Per million residents, ", year_start, " to ", year_end)) +
      theme(aspect.ratio=0.6)
    }
    else if(max(mapping_data$n) < 20){
      state_map_as <- ggplot(mapping_data, aes(long, lat, group = group))+
        geom_polygon(aes(fill = n), color = "white") +
        scale_fill_gradient2(low = muted("#C9082A"), mid = "white",
                             high = muted("#17408B"), midpoint = mean(c(max(mapping_data$n), mean(mapping_data$n), 0)),
                             guide = guide_legend(label.position = "bottom"),
                             limits = c(0, 5*(max(mapping_data$n)%/%5+1)),
                             breaks = c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 5)),
                             labels = paste(c(seq(0, 5*(max(mapping_data$n)%/%5+1), by = 5)))) +
        theme_void() +
        labs(fill = NULL) +
        theme(panel.background = element_rect(fill = "gainsboro"),
              legend.position = c(0.2, 0.15),
              legend.key.size = unit(0.8, "cm"), legend.direction="horizontal",
            panel.border = element_rect(fill = NA, color = "black", size = 1),
            plot.title = element_text(family = "Times", size = 24, hjust = 0.02),
            plot.subtitle = element_text(family = "Times", size = 16, margin=margin(3,0,4,0), hjust = 0.015)) +
      labs(title = "Number of All-Stars by college state",
           subtitle = paste0("Per million residents, ", year_start, " to ", year_end)) +
        theme(aspect.ratio=0.6)
    }
  }
  
  # Per-Capita --------------------------------------------------------------
  
  else{
    pop <- pop %>% mutate(state = state.abb[match(pop$state, state.name)]) %>%
      mutate(state = ifelse(is.na(state), "DC", state))
    
    states_pop <- left_join(mapping_data, pop)
    
    
    state_map_as <- ggplot(states_pop, aes(long, lat, group = group))+
      geom_polygon(aes(fill = n/(pop2020/1000000)), color = "white") +
      scale_fill_gradient2(low = muted("#C9082A"), mid = "white",
                           high = muted("#17408B"), 
                           midpoint = mean(c(max(states_pop$n/(states_pop$pop2020/1000000)),
                                             mean(states_pop$n/(states_pop$pop2020/1000000)), 0)),
                           guide = guide_legend(label.position = "bottom"),
                           limits = c(0, max(states_pop$n/(states_pop$pop2020/1000000))+1),
                           breaks = c(seq(0, round(max(states_pop$n/(states_pop$pop2020/1000000))+1), by = 2)),
                           labels = c(seq(0, round(max(states_pop$n/(states_pop$pop2020/1000000))+1), by = 2))) +
      theme_void() +
      labs(fill = NULL) +
      theme(panel.background = element_rect(fill = "gainsboro"),
            legend.position = c(0.2, 0.15),
            legend.key.size = unit(0.8, "cm"), legend.direction="horizontal",
            panel.border = element_rect(fill = NA, color = "black", size = 1),
            plot.title = element_text(family = "Times", size = 20, hjust = 0.02),
            plot.subtitle = element_text(family = "Times", size = 16, margin=margin(3,0,4,0), hjust = 0.015)) +
      labs(title = "Number of All-Stars by college state",
           subtitle = paste0("Per million residents, ", year_start, " to ", year_end)) +
      theme(aspect.ratio=0.6)
  }
  
  state_map_as
  }


# Point-mapping -----------------------------------------------------------
all_stars_by_college_loc <- function (year_start = 1951,
                                year_end = 2021) {
  all_stars <- read_csv("data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  colleges <- read_csv("data/colleges.csv", show_col_types = F)
  
  data <- right_join(colleges, all_stars) %>%
    select(players, college, year) %>%
    filter(!is.na(college)) %>%
    select(players, college, year) %>%
    filter(!is.na(college)) %>%
    mutate(college = ifelse(str_detect(college, "Indiana, Georgetown"), "Georgetown", college)) %>%
    mutate(college = ifelse(str_detect(college, "Niagara"), "Niagara", college)) %>%
    mutate(college = ifelse(str_detect(college, "Midland College, Oklahoma"), "Oklahoma", college)) %>%
    mutate(college = ifelse(str_detect(college, "Bradley, New Mexico"), "New Mexico", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, Michigan"), "Michigan", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, UNLV"), "UNLV", college)) %>%
    mutate(college = ifelse(str_detect(college, "Trinity Valley CC, Cincinnati"), "Cincinnati", college)) %>%
    filter(duplicated(players, college) == FALSE)
  

  college_locations <- read_csv("data/college_locations.csv", show_col_types = F) %>%
    select(NAME, LAT, LON, STATE) %>%
    rename(college = NAME,
           lat1 = LAT) %>%
    janitor::clean_names()
  
  
  locations_all_stars <- left_join(data, college_locations)
  
  locations_all_stars <- locations_all_stars %>%
    filter(year >= year_start & year <= year_end)
  
  by_college <- locations_all_stars %>%
    group_by(year, college) %>%
    count() %>% 
    pivot_wider(
      names_from = college,
      values_from = n
    ) %>%
    pivot_longer(-1, 
                 names_to = "college",
                 values_to = "n") %>% 
    mutate(n = replace_na(n, 0)) %>%
    group_by(college) %>%
    mutate(sum_all_stars = cumsum(n)) %>%
    ungroup()
  
  
  cumulative_college_data <- left_join(by_college, college_locations, by = "college") %>%
    filter(sum_all_stars > 0)
  
  
  point_map <- ggplot(cumulative_college_data) + 
    geom_polygon(data = map_data("state"), aes(x=long, y=lat, group=group),
                 color="black", fill = "white") +
    geom_point(data = cumulative_college_data, 
               aes(x = lon, y = lat1, size = sum_all_stars+1),color = "red", show.legend = F) +
    geom_point(data = (cumulative_college_data %>% filter(n > 0)),
               aes(x = lon, y = lat1, size = n+1), color = "blue", show.legend = F) + 
    scale_x_continuous(limits = c(-125, -66)) +
    scale_y_continuous(limits = c(25, 50)) +  
    facet_wrap(~ year) +
    facet_null() +
    theme_void() +
    theme(panel.background = element_rect(fill = "gainsboro"),
          panel.border = element_rect(fill = NA, color = "black", size = 1),
          plot.title = element_text(family = "Times", size = 24, hjust = 0.01),
          plot.subtitle = element_text(family = "Times", size = 16, margin=margin(3,0,4,0), hjust = 0.01)) +
    labs(fill = NULL, x = NULL, y = NULL, title = "All-Stars by college location",
         subtitle = paste0("By college, ", year_start, " to ", year_end)) +
    geom_text(data = (cumulative_college_data %>% filter(n > 0)),
              x = -115, y = 27,
              aes(label = as.character(year)),
              size = 25,  
              family = "Times"
    ) +
    gganimate::transition_time(year)
  
  point_map
}

  