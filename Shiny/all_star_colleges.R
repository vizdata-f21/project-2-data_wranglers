
library(tidyverse)
library(gganimate)

all_stars <- read_csv("../Data/all_star.csv", show_col_types = F) %>%
  filter(!(year == 1999 & str_detect(draft_pick, "20")))
colleges <- read_csv("../Data/colleges.csv", show_col_types = F)
states <- read_csv("../Data/states.csv", show_col_types = F)
stats <- read_csv("../Data/stats.csv", show_col_types = F)

colleges
all_stars

all_stars_w_colleges <- right_join(colleges, all_stars)

all_stars_w_colleges %>%
  filter(!is.na(college)) %>%
  select(college, year) %>%
  arrange(year) %>%
  group_by(college, year) %>%
  mutate(rank_in_year = rank(college, ties.method = "first"))

all_stars_w_colleges %>%
  filter(!is.na(college)) %>%
  select(college, year) %>%
  arrange(year) %>%
  group_by(year) %>%
  count(college)

x1$cumsum <- ave(x1$n, x1$college, FUN=cumsum)

x %>%
  group_by(year) %>%
  mutate(rank_in_year = rank(cumsum, ties.method = "first"))

x1<-x %>%
  complete(nesting(college, year), fill = list(frequency = 0)) %>% 
  mutate(n = replace_na(n, 0))

x1$cumsum <- ave(x1$n, x1$college, FUN=cumsum)

x2 <- x1 %>%
  group_by(year) %>%
  mutate(rank_in_year = rank(cumsum, ties.method = "first"))

colleges_anim <- x2 %>%
  ungroup() %>%
  ggplot(aes(x = cumsum, y = factor(rank_in_year))) +
  geom_col(aes(fill = college), show.legend = F) +
  facet_wrap(~year) +
  facet_null() +
  coord_cartesian(clip = "off") +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    plot.margin = margin(1,0,0,6, "cm"),
    axis.text.x = element_text(size=15),
    plot.title = element_text(size=15),
    plot.title.position = "plot",
    plot.subtitle = element_text(size=12)
  ) +
  geom_text(
    hjust = "right",
    aes(label = college),
    x = -10, size = 5
  ) +
  geom_text(
    x = 275, y = 2,
    hjust = "left",
    aes(label = as.character(year)),
    size = 10
  ) +
  aes(group = college) +
  transition_time(as.integer(year))

animate(colleges_anim, end_pause = 20)

all_stars_w_colleges %>%
  select(college, year) %>%
  group_by(college, year) %>%
  mutate(rank_in_year = rank(cumsum, ties.method = "first")) %>%
  ungroup() %>%
  ggplot(aes(x = cumsum, y = factor(rank_in_year))) +
  geom_col(aes(fill = college), show.legend = F) +
  facet_wrap(~year)
  
  
  
all_stars_w_colleges %>%
  select(-country_code, -indicator_name, -indicator_code) %>%
  pivot_longer(!country_name, names_to = "year", values_to = "population") %>%
  mutate(year = as.numeric(str_replace(year, "x", ""))) %>%
  group_by(year) %>%
  mutate(rank_in_year = rank(population, ties.method = "first")) %>%
  ungroup() %>%
  ggplot(aes(x = population, y = factor(rank_in_year))) +
  geom_col(aes(fill = country_name), show.legend = F) +
  facet_wrap(~year) +
  scale_x_continuous(labels = unit_format(unit = "B", scale = 1e-9, accuracy = 0.1),
                     limits = c(0, 1750000000), 
                     expand = c(0, 0)) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    plot.margin = margin(1,0,0,6, "cm"),
    axis.text.x = element_text(size=15),
    plot.title = element_text(size=15),
    plot.title.position = "plot",
    plot.subtitle = element_text(size=12)
  ) +
  coord_cartesian(clip = "off") +
  geom_text(
    hjust = "right",
    aes(label = country_name),
    x = -20000000, size = 5
  ) +
  labs(x = NULL, y = NULL, title = "Populations of most populous countries", subtitle = "1961 to 2020") +
  facet_null() +
  geom_text(
    x = 1040000000, y = 1.5,
    hjust = "left",
    aes(label = as.character(year)),
    size = 10
  ) +
  aes(group = country_name) +
  transition_time(as.integer(year))


