use rocket::Request;
use rocket_contrib::{json, json::JsonValue};

fn error(reason: String) -> JsonValue {
    json!({
        "status": "error",
        "reason": reason,
    })
}

#[catch(500)]
pub fn internal_error(req: &Request) -> JsonValue {
    error(req.to_string())
}

#[catch(503)]
pub fn service_not_available(req: &Request) -> JsonValue {
    error(req.to_string())
}

#[catch(404)]
pub fn not_found(req: &Request) -> JsonValue {
    error(format!("Resource '{}' was not found.", req.uri()))
}
