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
which will be interactive plots (including animations, buttons, and
sliders) that allow the user to specify year ranges and specific player
information that they want to explore.

### Motivation

Our motivation behind our ideas for this project are that we are all NBA
fans and thought it was an interesting, unique idea to make a Shiny app
that looked at NBA All-Star data. We wanted to explore the prevalence of
NBA players and NBA All-Stars from around the country and the world. We
found a lot of relevant data to help us create effective and interesting
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

1.  NBA Player Birthplaces - scraped from [Basketball
    Reference](https://www.basketball-reference.com/)

This second dataset has 4 variables and 4071 observations and includes
more information on NBA players through a large number of years. The
most important column in this dataset is the state from which a player
hails, as we will be using this to visualize which state our All-Stars
are from; we will join this dataset with the one above to achieve this
visualization. The data only includes American born players at present,
which is something we may change later.

1.  NBA player stats - scraped from [Basketball
    Reference](https://www.basketball-reference.com/)

This third dataset includes 4 variables and 4071 observation. It
contains player statistics in each season played in the NBA since 1951.
We will use this dataset to create interactive visualizations of stats
and other data.

1.  NBA player colleges - scraped from [Basketball
    Reference](https://www.basketball-reference.com/)

This third dataset includes 2 variables and 4961 observation. It
contains the college that each NBA player has attended. This can be used
to show which colleges produce the most NBA players and NBA All-Stars.

### Research questions

1.  Where are NBA All-Stars originally from geographically? How many
    All-Stars, on average, are there from outside the United States per
    year?

With the NBA becoming an increasingly international league, we are
curious to look into where the best players (the ones that made the
All-Star game) were originally from. We initially chose this question
because we were curious to see how many All-Stars are typically not from
the United States and, if so, where they originated from. This would be
interested as, historically, most of the greatest basketball players
have been born in the US, but the NBA has grown dramatically globally
and an increasing number of players were born internationally. We also
thought it would be interesting to create a panel in the Shiny App first
demonstrating where NBA players are from globally, and then for those
born in the US, what states they were born in. We will join the first
dataset, listing players and their nationalities, to the dataset that
holds information regarding a players’ birth state. With this, we
anticipate plotting the players’ origin locations on a map. An animation
of where players come from over time is another goal of ours.

1.  When were All-Stars drafted and what team did they play for?

For a second question, we will create an animated bar chart where you
can manually switch between looking at what teams NBA All-Stars played
for and when players were drafted. We chose this because we wanted to
see which teams had the most players make the All-Star game in the
2000s, and also were curious how many late draft picks versus earlier
draft picks became good enough to make the All-Star game. This was
interesting to us especially because we wanted to see how important it
is to get a top pick in the NBA draft for a player to turn out to be an
All-Star. A racing bar chart of the amount of cumulative All-Stars by
team could be used here. Additionally, we plan to plot where All-Stars
were drafted using a simple plot like a density plot. We may also
include an animated proportion chart showing what percentage of players
drafted at each pick make an All-Star game over time.

1.  Which colleges did the most NBA players attend? Geographically,
    which regions in the US are those colleges in that produce the most
    NBA players?

Our final visualization will show which colleges NBA All-Stars attended
on a map and will allow users to search for a college and pull up a list
of all the All-Stars from 2000-2016 that attended that college. We chose
this question do to our genuine interest in both college basketball and
the NBA, as well as wanting to know which colleges produced the most NBA
All-Stars. Our goal is to see which colleges are the greatest feeders
into the NBA. Plotting a map object would again be useful here, and
animations would illuminate trends of where players emerge out of
colleges.

### Weekly Plan of Attack

Week 4 (week of Mon, Nov 8):

-   Combine datasets and start working on different panels of shiny app-
    Each team member will clean one of the three datasets and will
    establish one panel of the Shiny App

Week 5 (week of Mon, Nov 15):

-   Each team member will work on one panel for the Shiny app and we
    will meet weekly (outside of lab) to discuss progress - Sarab will
    work on the map for “Where All-Stars are originally from?”, Zach
    will work on “When were All-Stars drafted and what team did they
    play for?”, and Owen will work on “Which colleges did NBA All-Stars
    attend?”.

Week 6 (week of Mon, Nov 22):

-   Finish up visualizations and start working on write-up and
    presentation - Each team member will conduct the appropriate
    write-ups and interpretations/discussions (along with the slides in
    the presentation) for their own visualization, we will then
    appropriately split up the introduction and conclusion for the
    project as a whole between the 3 of us

Week 7 (week of Mon, Nov 29):

-   Finalize write-up and presentation and final edits
-   Conduct peer review - Assigned to entire group

### Repository Organization

1.  Data

-   Contains files used to scrape data
-   Contains .csv files
-   Contains data dictionaries for all data files

1.  Shiny

-   Contains files for work done on Shiny app

1.  Presentation

-   Contains Shiny App output

1.  Proposal

-   Contains Proposal
