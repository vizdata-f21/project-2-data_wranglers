library(rvest)
library(tidyverse)

stats_data <- NULL

for (year in 1951:2021) {
  page <- read_html(paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_per_game.html"))
  
  players <- page %>%
    html_nodes("th+ .left") %>%
    html_text()
  
  team <- page %>%
    html_nodes("td+ .left") %>%
    html_text()
  
  
  games <- page %>%
    html_nodes(".left+ .right") %>%
    html_text()
  
  if(is.na(as.numeric(tail(games, 1)))) {
    games <- games %>% head(-1)
  }
  
  fgp <- page %>%
    html_nodes(".right:nth-child(11)") %>%
    html_text()
  
  threeatt <- page %>%
    html_nodes(".right:nth-child(13)") %>%
    html_text()
  
  threeperc <- page %>%
    html_nodes(".right:nth-child(14)") %>%
    html_text()
  
  ast <- page %>%
    html_nodes(".right:nth-child(25)") %>%
    html_text()
  
  reb <- page %>%
    html_nodes(".right:nth-child(24)") %>%
    html_text()
  
  pts <- page %>%
    html_nodes(".right:nth-child(30)") %>%
    html_text()
  
  
  stats_data <- bind_rows(stats_data, tibble(year, players, team, games, fgp, threeatt, threeperc, ast, reb, pts))
  
}

readr::write_csv(stats_data, "stats.csv")
