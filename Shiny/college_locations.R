library(tidyverse)
library(sf)

all_stars <- read_csv("./Data/all_star.csv", show_col_types = F) %>%
  filter(!(year == 1999 & str_detect(draft_pick, "20")))
colleges <- read_csv("./Data/colleges.csv", show_col_types = F)

data <- right_join(colleges, all_stars) %>%
  select(players, college, year) %>%
  filter(!is.na(college)) %>%
  select(players, college, year) %>%
  filter(!is.na(college)) %>%
  mutate(college = ifelse(str_detect(college, "Indiana, Georgetown"), "Georgetown", college)) %>%
  mutate(college = ifelse(str_detect(college, "Niagara"), "Niagara", college)) %>%
  mutate(college = ifelse(str_detect(college, "Midland College, Oklahoma"), "Oklahoma", college)) %>%
  mutate(college = ifelse(str_detect(college, "Bradley, New Mexico"), "Oklahoma", college)) %>%
  mutate(college = ifelse(str_detect(college, "Vincennes University, Michigan"), "Michigan", college)) %>%
  mutate(college = ifelse(str_detect(college, "Vincennes University, UNLV"), "UNLV", college)) %>%
  mutate(college = ifelse(str_detect(college, "Trinity Valley CC, Cincinnati"), "Cincinnati", college)) %>%
  filter(duplicated(players, college) == FALSE)

college_locations <- read_csv("college_locations.csv") %>%
  select(NAME, LAT, LON, STATE) %>%
  rename(college = NAME,
         lat1 = LAT) %>%
  janitor::clean_names()

  
locations_all_stars <- left_join(data, college_locations)

mapping <- map_data("state")

mapping$state <- state.abb[match(str_to_title(map_data("state")$region), state.name)]

mapping <- mapping %>%
  mutate(state = ifelse(is.na(state), "DC", state))

by_state <- locations_all_stars %>%
  group_by(state) %>%
  count()

mapping_data <- full_join(by_state, mapping, by = "state")

# also do per-capita, point mapping
mapping_data[c("n")][is.na(mapping_data[c("n")])] <- 0

merge(locations_all_stars, mapping, by = "state")

ggplot(mapping_data, aes(long, lat, group = group))+
  geom_polygon(aes(fill = n), color = "white") +
  scale_fill_gradient()

