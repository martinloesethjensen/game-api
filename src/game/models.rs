use postgres::Row;

#[derive(Serialize, Debug)]
pub struct Game {
    pub id: i32,
    pub title: String,
    pub body: String,
    pub daily_prices: i32,
    pub winning_chance: i32,
    pub images: Vec<Image>,
}

#[derive(Deserialize, Debug)]
pub struct NewGame {
    pub title: String,
    pub body: String,
    pub daily_prices: i32,
    pub winning_chance: i32,
    pub images: Vec<NewImage>,
}

#[derive(Serialize, Debug)]
pub struct Image {
    pub id: i32,
    pub image: String,
}

#[derive(Deserialize, Debug)]
pub struct NewImage {
    pub image: String,
}

#[derive(Serialize, Debug)]
pub struct GamePrice {
    pub id: i32,
    pub title: String,
    pub body: String,
    pub available_prices: i32,
    pub images: Vec<Image>,
}

#[derive(Deserialize, Debug)]
pub struct NewGamePrice {
    pub title: String,
    pub body: String,
    pub available_prices: i32,
    pub images: Vec<NewImage>,
}

#[derive(Serialize, Debug)]
pub struct PlayedGame {
    pub has_won: bool,
    pub game_reward: Option<GamePrice>,
}

impl Image {
    pub fn from_row(row: &Row) -> Image {
        let id = row.get(0);
        Image {
            id: id,
            image: row.get(1),
        }
    }
}

impl Game {
    pub fn from_row(row: &Row) -> Game {
        let id: i32 = row.get(0);

        Game {
            id: id,
            title: row.get(1),
            body: row.get(2),
            daily_prices: row.get(3),
            winning_chance: row.get(4),
            images: Vec::new(),
        }
    }
}

impl GamePrice {
    pub fn from_row(row: &Row) -> GamePrice {
        let id = row.get(0);
        GamePrice {
            id: id,
            title: row.get(1),
            body: row.get(2),
            available_prices: row.get(3),
            images: Vec::new(),
        }
    }
}
