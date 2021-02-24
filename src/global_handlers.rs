use rocket::{http::Status, Request};
use rocket_contrib::{json, json::Json, json::JsonValue};

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
