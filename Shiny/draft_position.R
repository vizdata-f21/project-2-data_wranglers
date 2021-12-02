number_of_all_stars_by_draft <- function(year_start = 1951,
                               year_end = 2021) {
  all_stars <- read_csv("../Data/all_star.csv", show_col_types = F) %>%
    filter(!(year == 1999 & str_detect(draft_pick, "20")))
  
  data <- all_stars %>%
    mutate(draft_range = case_when(str_detect(draft_pick, "Undrafted") ~ "Undrafted",
                                   str_detect(draft_pick, "Rnd 1") ~ "First Round",
                                   str_detect(draft_pick, "Rnd 2") ~ "Second Round"))
  
  #all_stars$y <- stringr::str_split(all_stars$draft_pick, "Rnd 1 Pick ")
  #all_stars$z <- stringr::str_split(all_stars$draft_pick, "Rnd 2 Pick ")
  
#  all_stars <- all_stars %>%
 #   mutate(draft_range_n = case_when(str_detect(draft_pick, "Undrafted") ~ "Undrafted",
  #                                   as.numeric(y[1]) <= 10 ~ "Top 10", 
   #                                  as.numeric(y[1]) <= 20 ~ "10-20",
    #                                 as.numeric(y[1]) <= 30 ~ "20-30"))
           
                          
  
  data <- data %>%
    filter(year >= year_start & year <= year_end)
  
  draft_plot <- data %>%
    select(draft_range, year) %>%
    filter(draft_range != "NA") %>%
    group_by(year) %>%
    count(draft_range) %>% 
    pivot_wider(names_from = draft_range, values_from = n) %>%
    pivot_longer(-1, names_to = "draft_range", values_to = "n") %>% 
    mutate(n = replace_na(n, 0)) %>%
    group_by(draft_range) %>%
    mutate(sum_all_stars = cumsum(n)) %>%
    ungroup() %>%
    group_by(year) %>%  
    arrange(year, sum_all_stars) %>%
    mutate(rank = 1:n()) %>%
    ggplot() +
    aes(xmin = 0 , xmax = sum_all_stars) +
    aes(ymin = rank - .45, ymax = rank + .45, y = rank) +
    facet_wrap(~year) +  
    geom_rect(alpha = .8, show.legend = FALSE) +
    aes(fill = draft_range) +
    scale_x_continuous(limits = c(-150, 1400), breaks = c(100*(0:14))) +
    geom_text(hjust = "right", aes(label = draft_range), x = -0.50, size = 3) +
    theme_classic(base_family = "Times") +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), 
          axis.line.y = element_blank(), legend.background = element_rect(fill = "gainsboro"), 
          plot.background = element_rect(fill = "gainsboro"),
          panel.background = element_rect(fill = "gainsboro")) +
    facet_null() +
    scale_fill_viridis_d(option = "magma") +
    aes(group = draft_range) +
    transition_time(as.integer(year)) + 
    labs(title = "Number of Total All-Stars by Draft Round", 
         y = NULL, fill = NULL, x = "Number of All-Stars (Continuous) {frame_time}")
  
  draft_plot

}

#all_stars_n <- all_stars %>%
 #   mutate(draft_range = case_when(str_detect(draft_pick, "Undrafted") ~ "Undrafted",
  #                               str_detect(draft_pick, "Rnd 1") ~ "First Round",
   #                              str_detect(draft_pick, "Rnd 2") ~ "Second Round"))



#all_stars_n <- all_stars_n %>%
#  filter(draft_range != "NA")


#draft_plot <- all_stars_n %>%
 # filter(year >= 1980, year <= 2020) %>%
  #select(draft_range, year) %>%
  #group_by(year) %>%
  #count(draft_range) %>% 
  #pivot_wider(names_from = draft_range, values_from = n) %>%
  #pivot_longer(-1, names_to = "draft_range", values_to = "n") %>% 
  #mutate(n = replace_na(n, 0)) %>%
  #group_by(draft_range) %>%
  #mutate(sum_all_stars = cumsum(n)) %>%
  #ungroup() %>%
  #group_by(year) %>%  
  #arrange(year, sum_all_stars) %>%
  #mutate(rank = 1:n()) %>%
  #ggplot() +
  #aes(xmin = 0 , xmax = sum_all_stars) +
  #aes(ymin = rank - .45, ymax = rank + .45, y = rank) +
  #facet_wrap(~year) +  
  #geom_rect(alpha = .8, show.legend = FALSE) +
  #aes(fill = draft_range) +
  #scale_x_continuous(limits = c(-100, 1000), breaks = c(100*(0:10))) +
  #geom_text(hjust = "right", aes(label = draft_range), x = -0.50, size = 3) +
  #theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(),
  #      axis.title.y = element_blank(), axis.ticks.x = element_blank()) +
  #facet_null() +
  #theme_minimal() +
  #scale_fill_viridis_d(option = "magma") +
  #aes(group = draft_range) +
  #transition_time(as.integer(year)) + 
  #labs(title = "Number of Total All-Stars by Draft Round", subtitle = "from 1980-2020", 
   #    y = NULL, fill = NULL, x = "Number of All-Stars (Continuous) {frame_time}")

#animate(draft_plot, duration = 20, end_pause = 20)

