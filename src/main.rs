#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
#[macro_use]
extern crate serde_derive;
extern crate dotenv;
extern crate rocket_contrib;

use rocket::{Request, Response};
use rocket::fairing::{Fairing, Info, Kind};
use rocket::http::Header;

pub mod game;
pub mod global_handlers;
pub mod pg_connection;

#[cfg(test)]
mod tests;

#[get("/")]
fn hello() -> &'static str {
    "Hello, world!"
}

pub struct CORS();

impl Fairing for CORS {
    fn info(&self) -> Info {
        Info {
            name: "Add CORS headers to requests",
            kind: Kind::Response
        }
    }

    fn on_response(&self, _request: &Request, response: &mut Response) {
        response.set_header(Header::new("Access-Control-Allow-Origin", "*"));
        response.set_header(Header::new("Access-Control-Allow-Methods", "POST, GET, PATCH, OPTIONS"));
        response.set_header(Header::new("Access-Control-Allow-Headers", "*"));
        response.set_header(Header::new("Access-Control-Allow-Credentials", "true"));
    }
}

pub fn rocket() -> rocket::Rocket {
    rocket::ignite()
        .register(catchers![
            global_handlers::not_found,
            global_handlers::internal_error,
            global_handlers::service_not_available,
        ])
        .mount(
            "/api",
            routes![
                game::handlers::get_all_games,
                game::handlers::get_game,
                game::handlers::create_game,
                game::handlers::play_game,
            ],
        )
        .mount("/", routes![hello])
        .attach(CORS())
}

fn main() {
    rocket().launch();
}
