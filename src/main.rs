#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
#[macro_use]
extern crate rocket_contrib;
use rocket::{
    response::status::{Created, NotFound},
    Request,
};
use rocket_contrib::databases::postgres;
use rocket_contrib::{json, json::JsonValue};

pub mod models;

#[database("games_db")]
struct GamesDbConn(postgres::Connection);

#[catch(500)]
fn internal_error() -> &'static str {
    "Whoops! Looks like we messed up."
}

#[catch(404)]
fn not_found(req: &Request) -> JsonValue {
    json!({
        "status": "error",
        "reason": format!("Resource '{}' was not found.", req.uri())
    })
}

#[get("/")]
fn get_all_games(conn: GamesDbConn) -> Result<String, NotFound<String>> {
    conn.execute("insert into games (name) values ('8ball')", &[])
        .unwrap();

    Ok(String::from("Hey"))
}

fn main() {
    rocket::ignite()
        .attach(GamesDbConn::fairing())
        .register(catchers![not_found, internal_error])
        .mount("/game", routes![get_all_games,])
        .launch();
}
