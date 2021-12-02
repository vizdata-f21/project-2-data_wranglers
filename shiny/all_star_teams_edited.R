number_of_all_stars_by_team <- function (year_start = 1951, year_end = 2021, number_to_rank = 30) {
  all_stars <- read_csv("data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  
  data <- all_stars %>%
    mutate(team = str_replace(team, "Seattle SuperSonics", "Oklahoma City Thunder")) %>%
    mutate(team = str_replace(team, "Tri-Cities Blackhawks", "Atlanta Hawks")) %>%
    mutate(team = str_replace(team, "St. Louis Hawks", "Atlanta Hawks")) %>%
    mutate(team = str_replace(team, "Milwaukee Hawks", "Atlanta Hawks")) %>%
    mutate(team = str_replace(team, "Washington Bullets", "Washington Wizards")) %>%
    mutate(team = str_replace(team, "Minneapolis Lakers", "Los Angeles Lakers")) %>%
    mutate(team = str_replace(team, "Charlotte Bobcats", "Charlotte Hornets")) %>%
    mutate(team = str_replace(team, "Baltimore Bullets (BAA)", "Washington Wizards")) %>%
    mutate(team = ifelse(str_detect(team, "Washington Wizards"), "Washington Wizards", team)) %>%
    mutate(team = ifelse(str_detect(team, "Baltimore Bullets"), "Washington Wizards", team)) %>%
    mutate(team = str_replace(team, "Chicago Zephyrs", "Washington Wizards")) %>%
    mutate(team = str_replace(team, "Fort Wayne Pistons", "Detroit Pistons")) %>%
    mutate(team = str_replace(team, "Syracuse Nationals", "Philadelphia 76ers")) %>%
    mutate(team = str_replace(team, "Rochester Royals", "Sacramento Kings")) %>%
    mutate(team = str_replace(team, "New Jersey Nets", "Brooklyn Nets")) %>%
    mutate(team = str_replace(team, "Indianapolis Olympians", "Indiana Pacers")) %>%
    mutate(team = str_replace(team, "Kansas City Kings", "Sacramento Kings")) %>%
    mutate(team = str_replace(team, "Buffalo Braves", "Los Angeles Clippers")) %>%
    mutate(team = str_replace(team, "San Diego Clippers", "Los Angeles Clippers")) %>%
    mutate(team = str_replace(team, "San Francisco Warriors", "Golden State Warriors")) %>%
    mutate(team = str_replace(team, "Capital Bullets", "Washington Wizards")) %>%
    mutate(team = str_replace(team, "San Diego Rockets", "Houston Rockets")) %>%
    mutate(team = str_replace(team, "Philadelphia Sixers", "Philadelphia 76ers")) %>%
    mutate(team = str_replace(team, "St. Louis Hawks", "Atlanta Hawks")) %>%
    mutate(team = str_replace(team, "New Orleans Jazz", "Utah Jazz")) %>%
    mutate(team = str_replace(team, "New Orleans Hornets", "New Orleans Pelicans")) %>%
    mutate(team = str_replace(team, "Cincinnati Royals", "Sacramento Kings")) %>%
    mutate(team = str_replace(team, "Chicago Packers", "Washington Wizards")) 
  
  data <- data %>%
    filter(year >= year_start & year <= year_end)
  
  team_plot <- data %>%
    select(team, year) %>%
    group_by(year) %>%
    count(team) %>% 
    pivot_wider(names_from = team, values_from = n) %>%
    pivot_longer(-1, names_to = "team", values_to = "n") %>% 
    mutate(n = replace_na(n, 0)) %>%
    group_by(team) %>%
    mutate(sum_all_stars = cumsum(n)) %>%
    ungroup() %>%
    group_by(year) %>%  
    arrange(year, sum_all_stars) %>%
    mutate(rank = 1:n()) %>%
    filter(rank > (30-number_to_rank)) %>%
    ggplot() +
    aes(xmin = 0 , xmax = sum_all_stars) +
    aes(ymin = rank - .45, ymax = rank + .45, y = rank) +
    facet_wrap(~year) +  
    geom_rect(alpha = .8, show.legend = FALSE) +
    aes(fill = team) +
    scale_x_continuous(limits = c(-50, 200), breaks = c(20*(0:10))) +
    geom_text(hjust = "right", aes(label = team), x = -0.25, size = 3) +
    theme_classic(base_family = "Times") +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), 
          axis.line.y = element_blank(), legend.background = element_rect(fill = "gainsboro"), 
          plot.background = element_rect(fill = "gainsboro"),
          panel.background = element_rect(fill = "gainsboro"),
          plot.title = element_text(size = 24),
          plot.subtitle = element_text(size = 16),
          axis.title.x = element_text(size = 20)) +
    facet_null() +
    scale_fill_viridis_d(option = "magma", direction = -1) +
    aes(group = team) +
    transition_time(as.integer(year)) + 
    
    labs(title = "Total All-Star Appearances",
         subtitle = paste0("By team, ", year_start, " to ", year_end), y = NULL, fill = NULL, x = "Number of All-Stars: {frame_time}")
  
  team_plot
  
}

number_of_all_stars_by_team()
