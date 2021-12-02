library(rvest)
library(tidyverse)

states <- NULL

for (state in state.abb) {
  page <- read_html(paste0("https://www.basketball-reference.com/friv/birthplaces.fcgi?country=US&state=", state))
  
  players <- page %>%
    html_nodes("th+ .left") %>%
    html_text()
  
  town <- page %>%
    html_nodes(".left+ .left") %>%
    html_text()
  
  states <- bind_rows(states, tibble(state, players, town))
  
}

states <- states %>%
  mutate(state_name = usdata::abbr2state(state))

readr::write_csv(states, "states.csv")
