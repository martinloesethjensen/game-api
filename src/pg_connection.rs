use dotenv::dotenv;
use postgres::{Client, Error, NoTls};
use std::env;

pub fn establish_connection() -> Result<Client, Error> {
    dotenv().ok();

    let db_host = env::var("DATABASE_HOST").expect("DATABASE_HOST must be set in .env");
    let db_user = env::var("DATABASE_USER").expect("DATABASE_USER must be set in .env");
    let db_name = env::var("DATABASE_NAME").expect("DATABASE_NAME must be set in .env");

    match Client::connect(
        &format!("host={} user={} dbname={}", db_host, db_user, db_name),
        NoTls,
    ) {
        Ok(client) => Ok(client),
        Err(err) => Err(err),
    }
}