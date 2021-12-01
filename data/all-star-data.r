library(rvest)
library(tidyverse)

all_star <- NULL

for (year in 1950:2021) {
  page <- read_html(paste0("https://basketball.realgm.com/nba/allstar/game/rosters/", year))
  
  players <- page %>%
    html_nodes(".nowrap:nth-child(1)") %>%
    html_text()
  
  positions <- page %>%
    html_nodes(".nowrap:nth-child(1)") %>%
    html_text()
  
  height <- page %>%
    html_nodes(".nowrap:nth-child(3)") %>%
    html_text()
  
  weight <- page %>%
    html_nodes(".nowrap:nth-child(4)") %>%
    html_text() %>%
    as.numeric()
  
  team <- page %>%
    html_nodes(".nowrap:nth-child(5)") %>%
    html_text()
  
  draft_pick <- page %>%
    html_nodes(".nowrap:nth-child(7)") %>%
    html_text()
  
  nationality <- page %>%
    html_nodes(".nowrap:nth-child(8)") %>%
    html_text()
  
  all_star <- bind_rows(all_star, tibble(year, players, positions, height, weight, team, draft_pick, nationality))
  
}

readr::write_csv(all_star, "all_star.csv")
