library(rvest)
library(tidyverse)
# robotstxt::paths_allowed("https://en.wikipedia.org/wiki/")

url <- "https://en.wikipedia.org/wiki/Module:College_color/data"

html <- read_html(url)
nodes <- html %>%   html_nodes('td') %>%
  html_attr("style")

colors <- nodes[seq(6, length(nodes), 10)]

nodes <- html %>%   html_nodes('td') %>%
  html_attr("style")


teams <- html %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div[1]/div/div/div[1]/table[3]/tbody') %>%
  html_table()

teams <- teams[[1]] %>% tail(-1)

teams <- teams$Team

colors <- substr(colors, start = 12, stop = 18)

x <- cbind(teams = teams[1:1041], colors = colors[1:1041]) %>%
  as_tibble()

