#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate dotenv;

#[macro_use]
extern crate rocket;
use rocket::{
    response::status::{Created, NotFound},
    Request, Rocket, State,
};
use rocket_contrib::{json, json::JsonValue};

pub mod models;

use dotenv::dotenv;
use postgres::{Client, Error, NoTls};
use std::env;

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
fn get_all_games() -> Result<String, NotFound<String>> {
    Ok(String::from("Hey"))
}

fn init_database() -> Result<(), Error> {
    let mut client = establish_connection().expect("Could not establish connection to database");
    client.execute(
        "
        CREATE TABLE IF NOT EXISTS games (
            id      SERIAL PRIMARY KEY,
            name    TEXT NOT NULL
        )
        ",
        &[],
    )?;
    Ok(())
}

fn establish_connection() -> Result<Client, Error> {
    dotenv().ok();

    let db_host = env::var("DATABASE_HOST").expect("DATABASE_HOST must be set in .env");
    let db_user = env::var("DATABASE_USER").expect("DATABASE_USER must be set in .env");
    let db_name = env::var("DATABASE_NAME").expect("DATABASE_NAME must be set in .env");

    let client = Client::connect(
        &format!("host={} user={} dbname={}", db_host, db_user, db_name),
        NoTls,
    )
    .expect("Could not connect to database");

    Ok(client)
}

fn main() {
    init_database().expect("Could not initialize database");
    rocket::ignite()
        .register(catchers![not_found, internal_error])
        .mount("/game", routes![get_all_games,])
        .launch();
}
