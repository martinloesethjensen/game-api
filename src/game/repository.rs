use crate::game::models::{Game, Image, NewGame};
use crate::pg_connection as pg;
use postgres::Error;

pub fn add_game_to_db(game: &NewGame) -> Result<Game, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };

    // Creates a row in the table `games` and returns the id that is used to create images to the table `game_images`
    let query = "INSERT INTO games (title, body, daily_prices, winning_chance) VALUES ($1, $2, $3, $4) RETURNING id";
    let result = client.query_one(
        query,
        &[
            &game.title,
            &game.body,
            &game.daily_prices,
            &game.winning_chance,
        ],
    );

    let game_id: i32 = match result {
        Ok(row) => row.get(0),
        Err(err) => return Err(err),
    };

    let mut images: Vec<Image> = Vec::new();

    for new_image in &game.images {
        let result = client.execute(
            "INSERT INTO game_images (game_id, image) VALUES ($1, $2)",
            &[&game_id, &new_image.image],
        );
        match result {
            Ok(_) => images.push(Image {
                game_id,
                image: new_image.image.to_owned(),
            }),
            Err(err) => return Err(err),
        }
    }

    Ok(Game {
        id: game_id,
        title: game.title.to_owned(),
        body: game.body.to_owned(),
        daily_prices: game.daily_prices.to_owned(),
        winning_chance: game.winning_chance.to_owned(),
        images: images,
    })
}

pub fn get_all_games_from_db() -> Result<Vec<Game>, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };

    let results = client.query("SELECT * FROM games", &[]);

    let mut games: Vec<Game> = Vec::new();

    for game_row in match results {
        Ok(res) => res,
        Err(err) => return Err(err),
    } {
        let game_id = game_row.get(0);

        let game_images = get_images_from_game_id(game_id).unwrap();

        games.push(Game {
            id: game_id,
            title: game_row.get(1),
            body: game_row.get(2),
            daily_prices: game_row.get(3),
            winning_chance: game_row.get(4),
            images: game_images,
        })
    }

    Ok(games)
}

fn get_images_from_game_id(game_id: i32) -> Result<Vec<Image>, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };

    let mut images: Vec<Image> = Vec::new();
    let query = "SELECT * FROM game_images WHERE game_id = $1";
    let results = client.query(query, &[&game_id]);

    for row in match results {
        Ok(result) => result,
        Err(err) => return Err(err),
    } {
        images.push(Image {
            game_id: row.get(0),
            image: row.get(1),
        })
    }
    Ok(images)
}

pub fn get_game_by_id(id: i32) -> Result<Game, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };

    let results = client.query_one("SELECT * FROM games WHERE id = $1", &[&id]);

    match results {
        Ok(row) => {
            let game_id = row.get(0);

            println!("{}", game_id);

            let game_images = get_images_from_game_id(game_id).unwrap();

            Ok(Game {
                id: game_id,
                title: row.get(1),
                body: row.get(2),
                daily_prices: row.get(3),
                winning_chance: row.get(4),
                images: game_images,
            })
        }
        Err(err) => {
            println!("{}", err);
            return Err(err)},
    }
}
