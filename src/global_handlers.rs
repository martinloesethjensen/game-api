use rocket::Request;
use rocket_contrib::{json, json::JsonValue};

use crate::pg_connection;

#[catch(500)]
pub fn internal_error() -> &'static str {
    "Whoops! Looks like we messed up."
}

#[catch(503)]
pub fn service_not_available(req: &Request) -> JsonValue {
    json!({
        "status": "error",
        "reason": req.to_string(),
    })
}

#[catch(404)]
pub fn not_found(req: &Request) -> JsonValue {
    json!({
        "status": "error",
        "reason": format!("Resource '{}' was not found.", req.uri())
    })
}

#[get("/init")]
pub fn init_database() {
    if let Ok(mut client) = pg_connection::establish_connection(){
        client.execute(
            "CREATE TABLE IF NOT EXISTS games (
                id      SERIAL PRIMARY KEY,
                name    TEXT NOT NULL
            )",
            &[],
        )
        .expect("create games table");
    } 
}
