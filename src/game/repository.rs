use crate::game::models::{Game, GamePrice, Image, NewGame, PlayedGame};
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
                id: game_id,
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
        images.push(Image::from_row(&row))
    }
    Ok(images)
}

pub fn get_game_by_id(id: i32) -> Result<Game, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };

    let query = "SELECT * FROM games WHERE id = $1";
    let results = client.query_one(query, &[&id]);

    match results {
        Ok(row) => {
            let game_id = row.get(0);

            let game_images = get_images_from_game_id(game_id).unwrap();

            let mut game = Game::from_row(&row);

            game.images = game_images;

            Ok(game)
        }
        Err(err) => return Err(err),
    }
}

pub fn fetch_game(game_id: i32) {
    // fetch game information
    // fetch game price information for game
    // fetch game images
    // fetch game price images
    // TODO: model to send to client
}

pub fn play_game(game_id: i32, player_id: String) -> Result<PlayedGame, Error> {
    let mut client = match pg::establish_connection() {
        Ok(client) => client,
        Err(err) => return Err(err),
    };
    // fetch game information and price information along with images
    // add entry into db table `played_games`
    // Return model

    let query = "SELECT * FROM games WHERE id = $1";
    let result = client.query_one(query, &[&game_id]);




    // let game: Game = match result {
    //     Ok(row) => {
    //         let game_id = row.get(0);
    //         Game {
    //             id: game_id,
    //             title: row.get(1),
    //             body: row.get(2),
    //             daily_prices
    //         }

    //     },
    //     Err(err) => return Err(err),
    // };

    // game winning_chance logic (could maybe use rand crate for randomizing?)

    // Update daily price in db

    Ok(PlayedGame {
        has_won: false,
        game_price: Some(GamePrice {
            id: 1i32,
            title: "bdhsbhsdfj".to_string(),
            body: "fndhbfsd".to_string(),
            available_prices: 100i32,
            images: Vec::new(),
        }),
    })
}
