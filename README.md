
# indonesiaFootballScoutR

<!-- badges: start -->
<!-- badges: end -->

indonesiaFootballScoutR is an R port of the Indonesia Football Scout AI project. This package serves as an automated scouting assistant that harvests football market data (from Transfermarkt) and utilizes lightweight Machine Learning to identify suitable players, analyze market profiles, and detect potential talents across the Southeast Asian region.

📋 Key Features
1. The Collector (Automated Scraper):
  - Extracts squad data, age, position, and Market Value from Liga 1 Indonesia, Thai League, Malaysia Super League, and V.League 1 Vietnam.
  - Includes a User-Agent Rotator to prevent server blocking.

2. The Brain (Player Analysis):
  - Player Similarity Search: Finds players with similar market profiles (Age & Value) to a target player using Cosine Similarity.
  - Squad Planner: Recommends transfer targets based on a realistic club budget (calculated from current squad value).
  - Wonderkid Detector: Automated algorithm to filter U-23 players with market values above the league average.

## Installation

You can install the development version of indonesiaFootballScoutR from [GitHub](https://github.com/) with:

``` r
install.packages("devtools")
devtools::install_github("tioanta/indonesiaFootballScoutR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(indonesiaFootballScoutR)

liga1 <- scrape_league(
  "https://www.transfermarkt.co.id/super-league/startseite/wettbewerb/IN1L",
  league_country = "Indonesia - Liga 1"
)

cleaned <- clean_player_db(liga1)
head(cleaned)
```

