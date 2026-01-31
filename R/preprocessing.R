#' Clean and standardize player database
#'
#' @param df A data frame containing raw player data
#'
#' @return A cleaned tibble
#' @export
clean_player_db <- function(df) {

  df_clean <- df |>
    dplyr::mutate(
      # age: buang karakter aneh, ubah ke numeric
      age = stringr::str_trim(age),
      age = dplyr::na_if(age, "-"),
      age = suppressWarnings(as.numeric(age)),

      # market value: parse angka
      market_value_est = stringr::str_trim(market_value_est),
      market_value_est = dplyr::na_if(market_value_est, "-"),
      market_value_est = suppressWarnings(
        readr::parse_number(market_value_est)
      )
    )

  # JANGAN drop semuanya — hanya buang baris yang nama kosong
  df_clean |>
    dplyr::filter(!is.na(name), name != "")
}
