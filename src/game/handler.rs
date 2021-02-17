use crate::game;
use crate::mongo_connection::Conn;
use game::Game;
use mongodb::{doc, error::Error, oid::ObjectId};
use rocket::{delete, get, http::Status, post, put, response::status};
use rocket_contrib::json::Json;

fn error_status(error: Error) -> Status {
    match error {
        Error::CursorNotFoundError => Status::NotFound,
        _ => Status::InternalServerError,
    }
}

#[get("/")]
pub fn all(connection: Conn) -> Result<Json<Vec<Game>>, Status> {
    match game::repository::all(&connection) {
        Ok(res) => Ok(Json(res)),
        Err(err) => Err(error_status(err)),
    }
}

#[get("/<id>")]
pub fn get(id: String, connection: Conn) -> Result<Json<Game>, Status> {
    match ObjectId::with_string(&String::from(&id)) {
        Ok(res) => match game::repository::get(res, &connection) {
            Ok(res) => Ok(Json(res.unwrap())),
            Err(err) => Err(error_status(err)),
        },
        Err(_) => Err(error_status(Error::DefaultError(String::from(
            "Couldn't parse ObjectId",
        )))),
    }
}

#[post("/", format = "application/json", data = "<game>")]
pub fn post(game: Json<Game>, connection: Conn) -> Result<status::Created<Json<ObjectId>>, Status> {
    match game::repository::insert(game.into_inner(), &connection) {
        Ok(res) => {
            let location = uri!("/game", get: res.to_string());
            Ok(status::Created(
                location.to_string(),
                Some(Json(res)),
            ))
        }
        Err(err) => Err(error_status(err)),
    }
}

#[put("/<id>", format = "application/json", data = "<game>")]
pub fn put(id: String, game: Json<Game>, connection: Conn) -> Result<Json<Game>, Status> {
    match ObjectId::with_string(&String::from(&id)) {
        Ok(res) => match game::repository::update(res, game.into_inner(), &connection) {
            Ok(res) => Ok(Json(res)),
            Err(err) => Err(error_status(err)),
        },
        Err(_) => Err(error_status(Error::DefaultError(String::from(
            "Couldn't parse ObjectId",
        )))),
    }
}

#[delete("/<id>")]
pub fn delete(id: String, connection: Conn) -> Result<Json<String>, Status> {
    match ObjectId::with_string(&String::from(&id)) {
        Ok(res) => match game::repository::delete(res, &connection) {
            Ok(_) => Ok(Json(id)),
            Err(err) => Err(error_status(err)),
        },
        Err(_) => Err(error_status(Error::DefaultError(String::from(
            "Couldn't parse ObjectId",
        )))),
    }
}

#[delete("/")]
pub fn delete_all(connection: Conn) -> Result<Json<bool>, Status> {
    match game::repository::delete_all(&connection) {
        Ok(_) => Ok(Json(true)),
        Err(err) => Err(error_status(err)),
    }
}
