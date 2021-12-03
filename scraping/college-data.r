library(rvest)
library(tidyverse)

colleges <- NULL

for (letter in letters) {
  page <- read_html(paste0("https://www.basketball-reference.com/players/", letter))
  
  players <- page %>%
    html_nodes("th.left") %>%
    html_text()
  
  college <- page %>%
    html_nodes(".left+ .left") %>%
    html_text()
  
  colleges <- bind_rows(colleges, tibble(players, college))
  
}

readr::write_csv(colleges, "colleges.csv")
