use rocket::{delete, get, http::Status, post, put, response::status};
use rocket_contrib::json::Json;

use crate::game::models::{Game, NewGame};
use crate::game::repository;

#[get("/game")]
pub fn get_all_games() -> Result<Json<Vec<Game>>, Status> {
    return match repository::get_all_games_from_db() {
        Ok(res) => Ok(Json(res)),
        Err(_err) => return Err(Status::InternalServerError),
    };
}

#[post("/game", format = "json", data = "<game>")]
pub fn create_game(game: Json<NewGame>) -> Result<status::Created<Json<Game>>, Status> {
    return match repository::add_game_to_db(&game.into_inner()) {
        Ok(game) => Ok(status::Created(game.id.to_string(), Some(Json(game)))),
        Err(_err) => return Err(Status::InternalServerError),
    };
}
