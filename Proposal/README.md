Project Proposal
================
Data Wranglers

``` r
all_stars <- read_csv("../data/all_star.csv", show_col_types = F)
colleges <- read_csv("../data/colleges.csv", show_col_types = F)
states <- read_csv("../data/states.csv", show_col_types = F)
stats <- read_csv("../data/stats.csv", show_col_types = F)
```

### High Level Goal

We want to build a shiny app with visualizations based on NBA All-Star
data, including where the athletes are originally from, what colleges
they went to, what team they played for, and important statistics from
their career. We will answer each of our three research questions
described below with separate visualizations in the shiny app, some of
which will be interactive.

### Motivation

Our motivation behind our ideas for this project are that we are all NBA
fans and thought it was an interesting, unique idea. We found a lot of
relevant data to help us create effective and interesting
visualizations, which we were able to use by scraping the web. These
data are listed below:

### Data

1.  NBA All-Stars (1950-2021) - scraped from [Real
    GM](https://basketball.realgm.com/)

This dataset includes NBA All-Stars from 1950-2021 and information on
the team they played for, their draft pick, and where they are from. We
will use this dataset for visualizations in the shiny app, including
players’ nationalities, when they were drafted, and All-Stars by team.
The dataset has 8 variables and 1739 observations.

2.  NBA Player Birthplaces - scraped from [Basketball
    Reference](https://www.basketball-reference.com/)

This second dataset has 4 variables and 4071 observations and includes
more information on NBA players through a large number of years. The
most important column in this dataset is the state from which a player
hails, as we will be using this to visualize which state our All-Stars
are from; we will join this dataset with the one above to achieve this
visualization. The data only includes American born players at present,
which is something we may change later.

3.  NBA player stats - scraped from [Basketball
    Reference](https://www.basketball-reference.com/)

This third dataset includes 4 variables and 4071 observation. It
contains player statistics in each season played in the NBA since 1951.
We will use this dataset to create interactive visualizations of stats
and other data.

4.  NBA player colleges - scraped from [Basketball
    Reference](https://www.basketball-reference.com/)

This third dataset includes 2 variables and 4961 observation. It
contains the college that each NBA player has attended. This can be used
to show which players produce the most NBA players and NBA All-Stars.

### Research questions

1.  Where are NBA All-Stars originally from?

With the NBA becoming an increasingly international league, we are
curious to look into where the best players (the ones that made the
All-Star game) were originally from. We also thought it would be
interesting to create a panel in the Shiny App first demonstrating where
NBA players are from globally, and then for those born in the US, what
states they were born in. We will join the first dataset, which lists
players and their nationalities, to the second dataset, which lists
which state players were born in.

2.  When were All-Stars drafted and what team did they play for?

For a second question, we will create an animated bar chart where you
can manually switch between looking at what teams NBA All-Stars played
for and when players were drafted. We chose this because we wanted to
see which teams had the most players make the All-Star game in the
2000s, and also were curious how many late draft picks versus earlier
draft picks became good enough to make the All-Star game.

3.  Which colleges did NBA players and NBA All-Stars attend?

Our final visualization will show which colleges NBA All-Stars attended
on a map and will allow users to search for a college and pull up a list
of all the All-Stars from 2000-2016 that attended that college. We chose
this question do to our genuine interest in both college basketball and
the NBA, as well as wanting to know which colleges produced the most NBA
All-Stars.

### Weekly Plan of Attack

Week 1 (week of Mon, Oct 18): - Picked theme for project and found
relevant datasets that fit our theme - Assigned to entire group

Week 2 (week of Mon, Oct 25): - Finalized research questions and worked
on our project proposal and weekly plan of attack for the entire project
- Assigned to entire team

Week 3 (week of Mon, Nov 1):

  - Fix revisions and make correctiosn to finalize proposal - Assigned
    to entire group

Week 4 (week of Mon, Nov 8):

  - Make final updates to proposal and conduct peer review of other
    projects - Assigned to entire team
  - Combine datasets and start working on different panels of shiny app-
    Each team member will clean one of the three datasets and will
    establish one panel of the Shiny App

Week 5 (week of Mon, Nov 15):

  - Each team member will work on one panel for the Shiny app and we
    will meet weekly (outside of lab) to discuss progress - Sarab will
    work on the map for “Where All-Stars are originally from?”, Zach
    will work on “When were All-Stars drafted and what team did they
    play for?”, and Owen will work on “Which colleges did NBA All-Stars
    attend?”.

Week 6 (week of Mon, Nov 22):

  - Finish up visualizations and start working on write-up and
    presentation - Each team member will conduct the appropriate
    write-ups and interpretations/discussions (along with the slides in
    the presentation) for their own visualization, we will then
    appropriately split up the introduction and conclusion for the
    project as a whole between the 3 of us

Week 7 (week of Mon, Nov 29):

  - Finalize write-up and presentation and final edits
  - Conduct peer review - Assigned to entire group

### Repository Organization

1.  Data

<!-- end list -->

  - Contains files used to scrape data
  - Contains .csv files
  - Contains data dictionaries for all data files

<!-- end list -->

2.  Shiny

<!-- end list -->

  - Contains files for work done on Shiny app

<!-- end list -->

3.  Presentation

<!-- end list -->

  - Contains Shiny App output

<!-- end list -->

4.  Proposal

<!-- end list -->

  - Contains Proposal