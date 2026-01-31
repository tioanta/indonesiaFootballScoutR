
# indonesiaFootballScoutR

<!-- badges: start -->
<!-- badges: end -->

The goal of indonesiaFootballScoutR is to ...

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

