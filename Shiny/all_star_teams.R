number_of_all_stars_by_team <- function (duplicate_players = T,
                                            year_start = 1951,
                                            year_end = 2021,
                                            number_to_rank = 10) {
  all_stars <- read_csv("../data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  colleges <- read_csv("../data/colleges.csv", show_col_types = F)
  
  data <- all_stars %>%
    mutate(team = str_replace(team, "Seattle SuperSonics", "Oklahoma City Thunder")) %>%
    mutate(team = str_replace(team, "Tri-Cities Blackhawks", "Atlanta Hawks")) %>%
    mutate(team = str_replace(team, "St. Louis Hawks", "Atlanta Hawks")) %>%
    mutate(team = str_replace(team, "Milwaukee Hawks", "Atlanta Hawks")) %>%
    mutate(team = str_replace(team, "Washington Bullets", "Washington Wizards")) %>%
    mutate(team = str_replace(team, "Minneapolis Lakers", "Los Angeles Lakers")) %>%
    mutate(team = str_replace(team, "Charlotte Bobcats", "Charlotte Hornets")) %>%
    mutate(team = str_replace(team, "Baltimore Bullets (BAA)", "Washington Wizards")) %>%
    mutate(team = str_replace(team, "Washington Wizards (BAA)", "Washington Wizards")) %>%
    mutate(team = str_replace(team, "Baltimore Bullets", "Washington Wizards")) %>%
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
    filter(rank <= number_to_rank) %>%
    ggplot() +
    aes(xmin = 0 , xmax = sum_all_stars) +
    aes(ymin = rank - .45, ymax = rank + .45, y = rank) +
    facet_wrap(~year) +  
    geom_rect(alpha = .8, show.legend = FALSE) +
    aes(fill = team) +
    scale_x_continuous(limits = c(-25, 100), breaks = c(10*(0:10))) +
    geom_text(hjust = "right", aes(label = team), x = -0.25, size = 3) +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(),
          axis.title.y = element_blank(), axis.ticks.x = element_blank()) +
    facet_null() +
    theme_minimal() +
    scale_fill_viridis_d(option = "magma", direction = -1) +
    aes(group = team) +
    transition_time(as.integer(year)) + 
    labs(title = "Number of Total All-Stars by Team", subtitle = "from 1980-2020", 
         y = NULL, fill = NULL, x = "Number of All-Stars (Continuous) {frame_time}")
  
  team_plot

}

#all_stars <- read_csv("./Data/all_star.csv", show_col_types = F)

#all_stars_n <- all_stars %>%
 # mutate(team = str_replace(team, "Seattle SuperSonics", "Oklahoma City Thunder")) %>%
#  mutate(team = str_replace(team, "Tri-Cities Blackhawks", "Atlanta Hawks")) %>%
 # mutate(team = str_replace(team, "St. Louis Hawks", "Atlanta Hawks")) %>%
  #mutate(team = str_replace(team, "Milwaukee Hawks", "Atlanta Hawks")) %>%
 # mutate(team = str_replace(team, "Washington Bullets", "Washington Wizards")) %>%
  #mutate(team = str_replace(team, "Minneapolis Lakers", "Los Angeles Lakers")) %>%
#  mutate(team = str_replace(team, "Charlotte Bobcats", "Charlotte Hornets")) %>%
 # mutate(team = str_replace(team, "Baltimore Bullets (BAA)", "Washington Wizards")) %>%
#  mutate(team = str_replace(team, "Washington Wizards (BAA)", "Washington Wizards")) %>%
 # mutate(team = str_replace(team, "Baltimore Bullets", "Washington Wizards")) %>%
#  mutate(team = str_replace(team, "Chicago Zephyrs", "Washington Wizards")) %>%
 # mutate(team = str_replace(team, "Fort Wayne Pistons", "Detroit Pistons")) %>%
#  mutate(team = str_replace(team, "Syracuse Nationals", "Philadelphia 76ers")) %>%
 # mutate(team = str_replace(team, "Rochester Royals", "Sacramento Kings")) %>%
#  mutate(team = str_replace(team, "New Jersey Nets", "Brooklyn Nets")) %>%
 # mutate(team = str_replace(team, "Indianapolis Olympians", "Indiana Pacers")) %>%
  #mutate(team = str_replace(team, "Kansas City Kings", "Sacramento Kings")) %>%
#  mutate(team = str_replace(team, "Buffalo Braves", "Los Angeles Clippers")) %>%
 # mutate(team = str_replace(team, "San Diego Clippers", "Los Angeles Clippers")) %>%
#  mutate(team = str_replace(team, "San Francisco Warriors", "Golden State Warriors")) %>%
 # mutate(team = str_replace(team, "Capital Bullets", "Washington Wizards")) %>%
#  mutate(team = str_replace(team, "San Diego Rockets", "Houston Rockets")) %>%
 # mutate(team = str_replace(team, "Philadelphia Sixers", "Philadelphia 76ers")) %>%
#  mutate(team = str_replace(team, "St. Louis Hawks", "Atlanta Hawks")) %>%
 # mutate(team = str_replace(team, "New Orleans Jazz", "Utah Jazz")) %>%
#  mutate(team = str_replace(team, "New Orleans Hornets", "New Orleans Pelicans")) %>%
 # mutate(team = str_replace(team, "Cincinnati Royals", "Sacramento Kings")) %>%
#  mutate(team = str_replace(team, "Chicago Packers", "Washington Wizards")) 
  
#all_stars_n <- all_stars_n %>%
#  filter(!(year == 1999 & str_detect(draft_pick, "20")))


#team_plot <- all_stars_n %>%
 # filter(year >= 1980, year <= 2020) %>%
 # select(team, year) %>%
#  group_by(year) %>%
#  count(team) %>% 
 # pivot_wider(names_from = team, values_from = n) %>%
#  pivot_longer(-1, names_to = "team", values_to = "n") %>% 
 # mutate(n = replace_na(n, 0)) %>%
  #group_by(team) %>%
#  mutate(sum_all_stars = cumsum(n)) %>%
 # ungroup() %>%
#  group_by(year) %>%  
 # arrange(year, sum_all_stars) %>%
  #mutate(rank = 1:n()) %>%
#  filter(rank <= number_to_rank) %>%
 # ggplot() +
  #aes(xmin = 0 , xmax = sum_all_stars) +
#  aes(ymin = rank - .45, ymax = rank + .45, y = rank) +
 # facet_wrap(~year) +  
  #geom_rect(alpha = .8, show.legend = FALSE) +
#  aes(fill = team) +
 # scale_x_continuous(limits = c(-25, 100), breaks = c(10*(0:10))) +
  #geom_text(hjust = "right", aes(label = team), x = -0.25, size = 3) +
#  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(),
 #       axis.title.y = element_blank(), axis.ticks.x = element_blank()) +
#  facet_null() +
 # theme_minimal() +
  #scale_fill_viridis_d(option = "magma", direction = -1) +
#  aes(group = team) +
 # transition_time(as.integer(year)) + 
#  labs(title = "Number of Total All-Stars by Team", subtitle = "from 1980-2020", 
 #      y = NULL, fill = NULL, x = "Number of All-Stars (Continuous) {frame_time}")

#animate(team_plot, duration = 20, end_pause = 20)