#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
#[macro_use]
extern crate serde_derive;
extern crate dotenv;
extern crate rocket_contrib;

pub mod game;
pub mod global_handlers;
pub mod global_repository;
pub mod pg_connection;

fn main() {
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
        .launch();
}
