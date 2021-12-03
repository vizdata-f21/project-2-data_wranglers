number_of_all_stars_by_college <- function (duplicate_players = T,
                                            year_start = 1951,
                                            year_end = 2021,
                                            number_to_rank = 10
                                            ) {
  all_stars <- read_csv("data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  colleges <- read_csv("data/colleges.csv", show_col_types = F)
  
  data <- right_join(colleges, all_stars) %>%
    filter(!is.na(college)) %>%
    mutate(college = ifelse(str_detect(college, "Indiana, Georgetown"), "Georgetown", college)) %>%
    mutate(college = ifelse(str_detect(college, "Niagara"), "Niagara", college)) %>%
    mutate(college = ifelse(str_detect(college, "Midland College, Oklahoma"), "Oklahoma", college)) %>%
    mutate(college = ifelse(str_detect(college, "Bradley, New Mexico"), "New Mexico", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, Michigan"), "Michigan", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, UNLV"), "UNLV", college)) %>%
    mutate(college = ifelse(str_detect(college, "Trinity Valley CC, Cincinnati"), "Cincinnati", college))
  
  colors <- read_csv("data/college_colors.csv", show_col_types = F) %>%
    mutate(secondary = case_when(
      secondary == "transpa" ~ "#000000",
      TRUE ~ secondary
    ))
  
  data <- data %>% filter(year >= year_start & year <= year_end)
  
  if (duplicate_players){
  data <- data %>%
    select(college, year) %>%
    group_by(year) %>%
    count(college) %>% 
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
    ungroup() %>%
    group_by(year) %>%  
    arrange(year, -sum_all_stars) %>%
    mutate(rank = 1:n()) %>%
    filter(rank <= number_to_rank)
      
      
  data <- left_join(data, colors) %>%
    mutate(college = case_when(
      str_detect(college, "American") ~ "American",
      str_detect(college, "Fullerton") ~ "CSU Fullerton",
      str_detect(college, "Central Michigan") ~ "Central Michigan",
      str_detect(college, "Columbia") ~ "Columbia",
      str_detect(college, "Dartmouth") ~ "Dartmouth",
      str_detect(college, "Eastern Illinois") ~ "Eastern Illinois",
      str_detect(college, "Furman") ~ "Furman",
      str_detect(college, "Gardner-Webb") ~ "Gardner-Webb",
      str_detect(college, "Guilford") ~ "Guilford",
      str_detect(college, "Iona") ~ "Iona",
      str_detect(college, "Long Island") ~ "Long Island",
      str_detect(college, "Marist") ~ "Marist",
      str_detect(college, "Louisiana-Monroe") ~ "UL-Monroe",
      str_detect(college, "Miami University") ~ "Miami (OH)",
      str_detect(college, "Northeastern") ~ "Northeastern",
      str_detect(college, "Rice") ~ "Rice",
      str_detect(college, "Saint Francis") ~ "Saint Francis",
      str_detect(college, "Seattle") ~ "Seattle",
      str_detect(college, "Southern University") ~ "Southern",
      str_detect(college, "Evansville") ~ "Evansville",
      str_detect(college, "Texas Rio Grande Valley") ~ "Texas Rio Grande Valley",
      str_detect(college, "Wisconsin-Stevens Point") ~ "UW-Stevens Point",
      str_detect(college, "Virginia Union") ~ "Virginia Union",
      str_detect(college, "Hartford") ~ "Hartford",
      TRUE ~ college
    ))
  
  
  color_codes <- setNames(data$colors, c(data$college))
  secondary_codes <- setNames(data$secondary, c(data$college))

    
  anim_w_duplicates <- ggplot(data) +
    aes(xmin = 0,
        xmax = sum_all_stars) +
    aes(ymin = rank - .45,
        ymax = rank + .45,
        y = rank,
        fill = college,
        color = college) +
    geom_rect(alpha = 1, show.legend = F, size = 0.8) +  
    facet_wrap(~ year) +
    scale_fill_manual(name = "college",values = color_codes) +
    scale_color_manual(name = "college",values = secondary_codes) +
    scale_x_continuous(
      limits = c(-12, 40),
      breaks = c(5*(0:8))
    ) +
    geom_text(
      hjust = "right",
      aes(label = college),
      x = -0.5, size = 5,
      color = "black"
    ) +
    theme_classic(base_family = "Times") +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(),
          axis.line.y = element_blank(), legend.background = element_rect(fill = "gainsboro"),
          plot.background = element_rect(fill = "gainsboro"),
          panel.background = element_rect(fill = "gainsboro"),
          plot.title = element_text(size = 20),
          plot.subtitle = element_text(size = 16)) +
    scale_y_reverse() +
    labs(fill = NULL, x = "All-Stars", y = NULL, title = "Number of All-Star Game appearances",
         subtitle = paste0("By college, ", year_start, " to ", year_end)) +
    facet_null() +
    scale_x_continuous(
      limits = c(-12, 40),
      breaks = c(5*(0:8))
    ) +
    geom_text(
      x = 30, y = -(as.numeric(number_to_rank)),
      aes(label = as.character(year)),
      size = 25,  
      family = "Times",
      color = "black"
    ) +  
    gganimate::transition_time(year)
  
  anim_w_duplicates
  
  }
  
  
  
  else {
    data <- data %>%
      select(players, college, year) %>%
      filter(duplicated(players, college) == FALSE) %>%
      select(college, year) %>%
      group_by(year) %>%
      count(college) %>% 
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
      ungroup() %>%
      group_by(year) %>%  
      arrange(year, -sum_all_stars) %>%
      mutate(rank = 1:n()) %>%  
      filter(rank <= number_to_rank)
    
    
    data <- left_join(data, colors) %>%
      mutate(college = case_when(
        str_detect(college, "American") ~ "American",
        str_detect(college, "Fullerton") ~ "CSU Fullerton",
        str_detect(college, "Central Michigan") ~ "Central Michigan",
        str_detect(college, "Columbia") ~ "Columbia",
        str_detect(college, "Dartmouth") ~ "Dartmouth",
        str_detect(college, "Eastern Illinois") ~ "Eastern Illinois",
        str_detect(college, "Furman") ~ "Furman",
        str_detect(college, "Gardner-Webb") ~ "Gardner-Webb",
        str_detect(college, "Guilford") ~ "Guilford",
        str_detect(college, "Iona") ~ "Iona",
        str_detect(college, "Long Island") ~ "Long Island",
        str_detect(college, "Marist") ~ "Marist",
        str_detect(college, "Louisiana-Monroe") ~ "UL-Monroe",
        str_detect(college, "Miami University") ~ "Miami (OH)",
        str_detect(college, "Northeastern") ~ "Northeastern",
        str_detect(college, "Rice") ~ "Rice",
        str_detect(college, "Saint Francis") ~ "Saint Francis",
        str_detect(college, "Seattle") ~ "Seattle",
        str_detect(college, "Southern University") ~ "Southern",
        str_detect(college, "Evansville") ~ "Evansville",
        str_detect(college, "Texas Rio Grande Valley") ~ "Texas Rio Grande Valley",
        str_detect(college, "Wisconsin-Stevens Point") ~ "UW-Stevens Point",
        str_detect(college, "Virginia Union") ~ "Virginia Union",
        TRUE ~ college
      ))
    
    color_codes <- setNames(data$colors, c(data$college))
    secondary_codes <- setNames(data$secondary, c(data$college))
    
    anim_no_duplicates <- ggplot(data) +  
      aes(xmin = 0 ,  
          xmax = sum_all_stars) +  
      aes(ymin = rank - .45,  
          ymax = rank + .45,  
          y = rank) +  
      facet_wrap(~ year) +  
      geom_rect(alpha = 1, show.legend = F, size = 0.8) +  
      aes(fill = college,
          color = college) +
      scale_fill_manual(name = "college",values = color_codes) +
      scale_color_manual(name = "college",values = secondary_codes) +
      scale_x_continuous(
        limits = c(-5, 16),
        breaks = c(2*(0:8))
      ) +
      geom_text(
        hjust = "right",
        aes(label = college),
        x = -0.5, size = 5,
        color = "black"
      ) +
      theme_classic(base_family = "Times") +
      theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), 
            axis.line.y = element_blank(), legend.background = element_rect(fill = "gainsboro"), 
            plot.background = element_rect(fill = "gainsboro"),
            panel.background = element_rect(fill = "gainsboro"),
            plot.title = element_text(size = 20),
            plot.subtitle = element_text(size = 16)) +  
      scale_y_reverse() +
      labs(fill = NULL, x = "All-Stars", y = NULL, title = "Total number of All-Star players",
           subtitle = paste0("By college, ", year_start, " to ", year_end)) +  
      facet_null() +
      scale_x_continuous(
        limits = c(-4.5, 16),
        breaks = c(2*(0:8))
      ) +
      geom_text(
        x = 12, y = -10,
        aes(label = as.character(year)),
        size = 25,  
        family = "Times",
        color = "black"
      ) +
      aes(group = college) +  
      gganimate::transition_time(year)
    
    anim_no_duplicates
    
  }
  
}

