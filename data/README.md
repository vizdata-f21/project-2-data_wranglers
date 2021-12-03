# Data

This data comes from [Basketball Reference](https://www.basketball-reference.com/), [Real GM](https://basketball.realgm.com/), [Wikipedia](https://en.wikipedia.org/wiki/Module:College_color/data), [The United States Census Bureau](https://www.census.gov/programs-surveys/popest/technical-documentation/research/evaluation-estimates/2020-evaluation-estimates/2010s-totals-national.html), & [The United States Department of Education](https://data.ed.gov/dataset/college-scorecard-all-data-files-through-6-2020/resources). Data from  Wikipedia, Basketball Reference, and RealGM was scraped by us. Prior to scraping data, we verified using the `robots.txt` file that the data was scrape-able.


## all_stars

NBA All-Stars from 1950-2021

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|year                  |character | Year |
|players               |character | Player Name |
|position              |character    | Position Played |
|height     |double    | Height (ft-in)|
|weight                  |character | Weight (lbs) |
|team                  |character | Team played for |
|draft_pick                  |character | Draft Pick |
|nationality                  |character | Nationality |

## colleges

Where NBA Players attended college

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|players               |character | Player Name |
|college              |character    | College Attended |

## states

Where NBA Players were born (American only)

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|state               |character | Home State Abbreviation |
|players               |character | Player Name |
|town              |character    | Birthplace |
|state_name               |character | Full State Name |

## stats

NBA Player Stats (1951-2021)

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|year                  |character | Year |
|players               |character | Player Name |
|team              |character    | Team played for |
|games     |double    | Games Played|
|threeatt                  |double | Three point shot attempts per game |
|threeperc                  |double | Three point shot percentage |
|ast                  |double | Assists per game |
|reb                  |double | Rebounds per game |
|pts                  |double | Points per game |


## college_colors

Colors of colleges


|variable              |class     |description |
|:---------------------|:---------|:-----------|
|college                  |character | College Name |
|color               |character | Hex code for primary color |
|secondary              |character    | Hex code for secondary color |

## college_locations

Mapping coordinates of colleges

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|college                  |character | College Name |
|lat               |character | Latitude |
|long              |character    | Longitude |
