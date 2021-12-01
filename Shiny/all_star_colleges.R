number_of_all_stars_by_college <- function (duplicate_players = T,
                                            year_start = 1951,
                                            year_end = 2021,
                                            number_to_rank = 10
                                            ) {
  all_stars <- read_csv("../data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  colleges <- read_csv("../data/colleges.csv", show_col_types = F)
  
  data <- right_join(colleges, all_stars)
  
  data <- data %>% filter(year >= year_start & year <= year_end)
  
  if (duplicate_players){
    anim_w_duplicates <- data %>%
    select(players, college, year) %>%
    filter(!is.na(college)) %>%
    mutate(college = ifelse(str_detect(college, "Indiana, Georgetown"), "Georgetown", college)) %>%
    mutate(college = ifelse(str_detect(college, "Niagara"), "Niagara", college)) %>%
    mutate(college = ifelse(str_detect(college, "Midland College, Oklahoma"), "Oklahoma", college)) %>%
    mutate(college = ifelse(str_detect(college, "Bradley, New Mexico"), "Oklahoma", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, Michigan"), "Michigan", college)) %>%
    mutate(college = ifelse(str_detect(college, "Vincennes University, UNLV"), "UNLV", college)) %>%
    mutate(college = ifelse(str_detect(college, "Trinity Valley CC, Cincinnati"), "Cincinnati", college)) %>%
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
    filter(rank <= number_to_rank) %>%
    ggplot() +  
    aes(xmin = 0 ,  
        xmax = sum_all_stars) +  
    aes(ymin = rank - .45,  
        ymax = rank + .45,  
        y = rank) +  
    facet_wrap(~ year) +  
    geom_rect(alpha = .7, show.legend = F) +  
    aes(fill = college) +  
    scale_fill_viridis_d(option = "magma",  
                         direction = -1) +
    scale_x_continuous(
      limits = c(-12, 40),
      breaks = c(5*(0:8))
    ) +
    geom_text(
      hjust = "right",
      aes(label = college),
      x = -0.5, size = 5
    ) +
    theme_classic(base_family = "Times") +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), 
          axis.line.y = element_blank(), legend.background = element_rect(fill = "gainsboro"), 
          plot.background = element_rect(fill = "gainsboro"),
          panel.background = element_rect(fill = "gainsboro")) +  
    scale_y_reverse() +
    labs(fill = NULL, x = "All-Stars", y = NULL) +  
    facet_null() +
    scale_x_continuous(
      limits = c(-12, 40),
      breaks = c(5*(0:8))
    ) +
    geom_text(
      x = 30, y = -10,
      aes(label = as.character(year)),
      size = 25,  
      family = "Times"
    ) +
    aes(group = college) +  
    gganimate::transition_time(year)
  
  anim_w_duplicates
  
  }
  
  
  
  else {
    anim_no_duplicates <- data %>%
      select(players, college, year) %>%
      filter(!is.na(college)) %>%
      mutate(college = ifelse(str_detect(college, "Indiana, Georgetown"), "Georgetown", college)) %>%
      mutate(college = ifelse(str_detect(college, "Niagara"), "Niagara", college)) %>%
      mutate(college = ifelse(str_detect(college, "Midland College, Oklahoma"), "Oklahoma", college)) %>%
      mutate(college = ifelse(str_detect(college, "Bradley, New Mexico"), "Oklahoma", college)) %>%
      mutate(college = ifelse(str_detect(college, "Vincennes University, Michigan"), "Michigan", college)) %>%
      mutate(college = ifelse(str_detect(college, "Vincennes University, UNLV"), "UNLV", college)) %>%
      mutate(college = ifelse(str_detect(college, "Trinity Valley CC, Cincinnati"), "Cincinnati", college)) %>%
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
      filter(rank <= 10) %>%
      ggplot() +  
      aes(xmin = 0 ,  
          xmax = sum_all_stars) +  
      aes(ymin = rank - .45,  
          ymax = rank + .45,  
          y = rank) +  
      facet_wrap(~ year) +  
      geom_rect(alpha = .7, show.legend = F) +  
      aes(fill = college) +  
      scale_fill_viridis_d(option = "magma",  
                           direction = -1) +
      scale_x_continuous(
        limits = c(-5, 16),
        breaks = c(2*(0:8))
      ) +
      geom_text(
        hjust = "right",
        aes(label = college),
        x = -0.5, size = 5
      ) +
      theme_classic(base_family = "Times") +
      theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), 
            axis.line.y = element_blank(), legend.background = element_rect(fill = "gainsboro"), 
            plot.background = element_rect(fill = "gainsboro"),
            panel.background = element_rect(fill = "gainsboro")) +  
      scale_y_reverse() +
      labs(fill = NULL, x = "All-Stars", y = NULL) +  
      facet_null() +
      scale_x_continuous(
        limits = c(-4.5, 16),
        breaks = c(2*(0:8))
      ) +
      geom_text(
        x = 12, y = -10,
        aes(label = as.character(year)),
        size = 25,  
        family = "Times"
      ) +
      aes(group = college) +  
      gganimate::transition_time(year)
    
    anim_no_duplicates
    
  }
  
}