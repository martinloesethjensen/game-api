use crate::game::models::{Game, NewGame};
use crate::pg_connection as pg;
use postgres::Error;

pub fn add_game_to_db(game: &NewGame) -> Result<Game, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };

    let result = client.query_one(
        "INSERT INTO games (name) VALUES ($1) RETURNING id",
        &[&game.name],
    );

    match result {
        Ok(row) => {
            let id: i32 = row.get(0);
            return Ok(Game {
                id: id as u32,
                name: game.name.to_owned(),
            })
        }
        Err(err) => return Err(err),
    };
}

pub fn get_all_games_from_db() -> Result<Vec<Game>, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };

    let results = client.query("SELECT * FROM games", &[]);

    let mut games: Vec<Game> = Vec::new();

    for row in match results {
        Ok(res) => res,
        Err(err) => return Err(err)
    } {
        games.push(Game::from_row(&row))
    }

    Ok(games)
}

// pub fn get_game_by_id(id: i32) -> Result<Game, Error> {
//     let mut client = match pg::establish_connection() {
//         Ok(client) => client,
//         Err(err) => return Err(err),
//     };


// }
