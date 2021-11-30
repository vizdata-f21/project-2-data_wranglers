library(tidyverse)
library(gganimate)
library(colorspace)
library(scales)
library(dplyr)
all_stars <- read_csv("./Data/all_star.csv", show_col_types = F)

all_stars <- all_stars %>%
  mutate(team = str_replace(team, "Seattle SuperSonics", "Oklahoma City Thunder")) %>%
  mutate(team = str_replace(team, "Tri-Cities Blackhawks", "Atlanta Hawks")) %>%
  mutate(team = str_replace(team, "St. Louis Hawks", "Atlanta Hawks")) %>%
  mutate(team = str_replace(team, "Milwaukee Hawks", "Atlanta Hawks")) %>%
  mutate(team = str_replace(team, "Washington Bullets", "Washington Wizards")) %>%
  mutate(team = str_replace(team, "Minneapolis Lakers", "Los Angeles Lakers")) %>%
  mutate(team = str_replace(team, "Charlotte Bobcats", "Charlotte Hornets")) %>%
  mutate(team = str_replace(team, "Baltimore Bullets (BAA)", "Washington Wizards")) %>%
  mutate(team = str_replace(team, "Washington Wizards (BAA)", "Washington Wizards"))
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

all_stars <- all_stars %>%
  filter(!(year == 1999 & str_detect(draft_pick, "20"))) %>%
  mutate()


plot <- all_stars %>%
  ggplot(mapping = aes(y = team)) +
  geom_bar(show.legend = FALSE, mapping = aes(fill = team)) +
  facet_wrap(~year) +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        axis.title.y = element_blank(), axis.ticks.x = element_blank()) +
  facet_null() +
  theme_minimal() +
  aes(group = team) +
  transition_time(as.integer(year), range = c(1980L, 2020L)) + 
  labs(title = "Number of Total All-Stars by Team", subtitle = "from 1980-2020", 
       y = NULL, x = "Number of All-Stars (Continuous) {frame_time}")

animate(plot, duration = 18)

