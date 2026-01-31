#' @examples
#' df <- data.frame(
#'   name = c("Player A", "Player B", "Player C"),
#'   age = c(21, 23, 22),
#'   market_value_est = c(500, 750, 600),
#'   club = c("Club A", "Club B", "Club C"),
#'   league_country = c("Indonesia", "Indonesia", "Indonesia")
#' )
#'
#' model <- train_scout_brain(df)
#' get_similar_players(model, "Player A", top_n = 1)
