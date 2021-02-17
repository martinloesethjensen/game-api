#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use] 
extern crate rocket;
extern crate dotenv;
extern crate mongodb;
extern crate r2d2;
extern crate r2d2_mongodb;
extern crate rocket_contrib;
#[macro_use] 
extern crate serde_derive;
extern crate serde_json;

use rocket_contrib::json;
use rocket_contrib::json::JsonValue;

pub mod game;
mod mongo_connection;

#[catch(500)]
fn internal_error() -> &'static str {
    "Whoops! Looks like we messed up."
}

#[catch(404)]
fn not_found(req: &rocket::Request) -> JsonValue {
    json!({
        "status": "error",
        "reason": format!("Resource '{}' was not found.", req.uri())
    })
}

pub fn rocket() -> rocket::Rocket {
    dotenv::dotenv().ok();
    rocket::ignite()
        .register(catchers![not_found, internal_error])
        .manage(mongo_connection::init_pool())
        .mount(
            "/game",
            routes![
                game::handler::all,
                game::handler::get,
                game::handler::post,
                game::handler::put,
                game::handler::delete,
                game::handler::delete_all
            ],
        )
}
