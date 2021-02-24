use rocket::{delete, get, http::Status, post, put, response::status};
use rocket_contrib::json::Json;

use crate::game::models::{Game, NewGame, PlayedGame};
use crate::game::repository;

#[get("/game")]
pub fn get_all_games() -> Result<Json<Vec<Game>>, Status> {
    match repository::get_all_games_from_db() {
        Ok(games) => Ok(Json(games)),
        Err(_err) => Err(Status::InternalServerError),
    }
}

#[get("/game/<id>")]
pub fn get_game(id: String) -> Result<Json<Game>, Status> {
    match repository::get_game_by_id(id.parse().unwrap()) {
        Ok(game) => Ok(Json(game)),
        Err(_err) => Err(Status::InternalServerError),
    }
}

#[post("/game", format = "json", data = "<game>")]
pub fn create_game(game: Json<NewGame>) -> Result<status::Created<Json<Game>>, Status> {
    match repository::add_game_to_db(&game.into_inner()) {
        Ok(game) => {
            let location = uri!("/api", get_game: game.id.to_string());
            Ok(status::Created(location.to_string(), Some(Json(game))))
        }
        Err(_err) => Err(Status::InternalServerError),
    }
}

#[get("/game/play/<game_id>/<player_id>")]
pub fn play_game(game_id: String, player_id: String) -> Result<Json<PlayedGame>, Status> {
    match repository::play_game(game_id.parse().unwrap(), player_id) {
        Ok(res) => Ok(Json(res)),
        Err(err) => Err(Status::InternalServerError),
    }
}
