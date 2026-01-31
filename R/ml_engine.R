#' Train similarity-based scout model
#'
#' @param df A cleaned player data frame
#'
#' @return A scout brain model object
#' @export
train_scout_brain <- function(df) {

  features <- df |> dplyr::select(age, market_value_est)
  scaled <- scale(features)

  list(
    data = df,
    features = scaled
  )
}

#' Find similar players using cosine similarity
#'
#' @param model A trained scout brain model
#' @param player_name Character. Name of the reference player
#' @param top_n Integer. Number of similar players to return
#'
#' @return A tibble of similar players
#' @export
get_similar_players <- function(model, player_name, top_n = 5) {

  idx <- which(model$data$name == player_name)
  if (length(idx) == 0) stop("Player not found")

  sim <- proxy::simil(
    model$features,
    model$features[idx, , drop = FALSE],
    method = "cosine"
  )

  model$data |>
    dplyr::mutate(similarity = as.numeric(sim)) |>
    dplyr::arrange(dplyr::desc(similarity)) |>
    dplyr::slice(2:(top_n + 1))
}
