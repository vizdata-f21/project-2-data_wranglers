Project Proposal
================
Data Wranglers

### High Level Goal

We want to build a shiny app with visualizations based on NBA all-star
data, including where the athletes are originally from, what colleges
they went to, what team they played for, and important statistics from
their career. We will answer each of our three research questions
described below with separate visualizations in the shiny app, some of
which will be interactive.

### Motivation

Our motivation behind our ideas for this project are that we are all NBA
fans and thought it was an interesting, unique idea. We found many
relevant datasets to help us create effective and interesting
visualizations. These datasets are listed below:

### Data

1.  NBA all-stars 2000-2016 list

<https://data.world/gmoney/nba-all-stars-2000-2016/workspace/file?filename=NBA+All+Star+Games.xlsx>

This dataset includes NBA all stars from 2000-2016 and information on
the team they played for, their draft pick, and where they are from. We
will use this dataset for visualizations in the shiny app, including
players’ nationalities, when they were drafted, and all-stars by team.
The dataset has 9 variables and 439 rows.

2.  Extensive NBA player list and birthplace list

<https://data.world/gmoney/nba-players-birthplaces/workspace/file?filename=NBA+Players+by+State.xlsx>

This second dataset has 28 variables and 3,407 rows and includes more
information on NBA players through a large number of years. The most
important column in this dataset is `state`, as we will be using this to
visualize which state our all-stars are from; we will join this dataset
with the one above to achieve this visualization.

3.  NBA player colleges and season stats

<https://www.kaggle.com/drgilermo/nba-players-stats>

This third dataset includes three tables. These tables have player info
regarding their birthplace, birthday, the college they attended, and key
stats from the seasons they played in the NBA. We will primarily use
this dataset to visualize which colleges NBA all-stars attended, but can
also use this dataset to create interactive visualizations of stats and
other data.

### Research questions

1.  Where are NBA All-Stars originally from?

With the NBA becoming an increasingly international league, we are
curious to look into where the best players (the ones that made the
all-star game) were originally from. We also thought it would be
interesting to create a panel in the Shiny App first demonstrating where
NBA players are from globally, and then for those born in the US, what
states they were born in. We will join the first dataset, which lists
players and their nationalities, to the second dataset, which lists
which state players were born in.

2.  When were all-stars drafted and what team did they play for?

For a second question, we will create an animated bar chart where you
can manually switch between looking at what teams NBA All-Stars played
for and when players were drafted. We chose this because we wanted to
see which teams had the most players make the All-Star game in the
2000s, and also were curious how many late draft picks versus earlier
draft picks became good enough to make the all-star game.

3.  Which colleges did NBA all-stars attend?

Our final visualization will show which colleges NBA all stars attended
on a map and will allow users to search for a college and pull up a list
of all the all-stars from 2000-2016 that attended that college. We chose
this question do to our genuine interest in both college basketball and
the NBA, as well as wanting to know which colleges produced the most NBA
all stars.

### Weekly Plan of Attack

Week 1 (week of Mon, Oct 18): - Picked theme for project and found
relevant datasets that fit our theme - Assigned to entire group

Week 2 (week of Mon, Oct 25): - Finalized research questions and worked
on our project proposal and weekly plan of attack for the entire project
- Assigned to entire team

Week 3 (week of Mon, Nov 1):

-   Fix revisions and make correctiosn to finalize proposal - Assigned
    to entire group

Week 4 (week of Mon, Nov 8):

-   Make final updates to proposal and conduct peer review of other
    projects - Assigned to entire team
-   Clean up datasets and start working on different panels of shiny
    app- Each team member will clean one of the three datasets

Week 5 (week of Mon, Nov 15):

-   Each team member will work on one panel for the Shiny app and we
    will meet weekly (outside of lab) to discuss progress - Sarab will
    work on the map for “Where all-stars are originally from?”, Zach
    will work on “When were all-stars drafted and what team did they
    play for?”, and Owen will work on “Which colleges did NBA all-stars
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
