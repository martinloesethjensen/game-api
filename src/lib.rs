#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use] extern crate rocket;
#[macro_use] extern crate rocket_contrib;

use rocket_contrib::json::{Json, JsonValue};

#[get("/")]
fn hello() -> &'static str {
    "Hello, world!"
}

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
    rocket::ignite()
        .mount("/api", routes![hello])
        .register(catchers![not_found, internal_error])
}