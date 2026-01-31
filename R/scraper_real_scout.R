#' Initialize Real Scout directories
#' @export
init_real_scout <- function() {
  dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
  dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
}


#' Scrape one league from Transfermarkt
#'
#' @param league_url URL liga Transfermarkt
#' @param league_country Nama liga / negara
#'
#' @return tibble
#' @export
scrape_league <- function(
    league_url,
    league_country = "Unknown League"
) {

  page <- rvest::read_html(league_url)

  clubs <- page |>
    rvest::html_nodes("td.hauptlink a") |>
    rvest::html_attr("href") |>
    unique()

  club_links <- paste0("https://www.transfermarkt.co.id", clubs)

  purrr::map_dfr(club_links, function(club_url) {
    scrape_club(
      club_url = club_url,
      league_country = league_country
    )
  })
}

#' Scrape all players from a club
#'
#' @param club_url URL of the club page
#' @param league_country Character. League or country name
#'
#' @return A tibble of players
#' @export
scrape_club <- function(club_url, league_country) {

  Sys.sleep(stats::runif(1, 2, 4))

  page <- rvest::read_html(club_url)

  club_name <- page |>
    rvest::html_node("h1") |>
    rvest::html_text(trim = TRUE)

  players <- page |>
    rvest::html_nodes("tr.odd, tr.even")

  purrr::map_dfr(players, function(p) {
    scrape_player(p) |>
      dplyr::mutate(
        club = club_name,
        league_country = league_country
      )
  })
}


#' Scrape a single player row
#'
#' @param node HTML node corresponding to a player row
#'
#' @return A tibble with player information
#' @export
scrape_player <- function(node) {

  tibble::tibble(
    name = node |> rvest::html_node(".hauptlink a") |> rvest::html_text(trim=TRUE),
    age  = node |> rvest::html_node("td.zentriert:nth-child(3)") |> rvest::html_text(),
    market_value_est = node |> rvest::html_node(".rechts.hauptlink") |> rvest::html_text()
  )
}

#' Save raw scouting data to CSV
#'
#' @param df A data frame containing raw scouting results
#'
#' @return File path of saved CSV
#' @export
save_raw_data <- function(df) {
  dir.create("inst/extdata/raw", recursive = TRUE, showWarnings = FALSE)
  fname <- paste0("inst/extdata/raw/real_scout_", Sys.Date(), ".csv")
  readr::write_csv(df, fname)
  fname
}
