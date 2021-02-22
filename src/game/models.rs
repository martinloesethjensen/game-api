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
    pub game_id: i32,
    pub image: String
}

#[derive(Deserialize, Debug)]
pub struct NewImage {
    pub image: String
}

// impl Game {
//     pub fn from_row(row: &Row) -> Game {
//         let id: i32 = row.get(0);
        
//         // Game {
//         //     id: id as u32,
//         //     title: row.get(1),
//         //     body: row.get(2),
//         //     daily_prices: row.get(3),
//         //     winning_chance: row.get(4),
//         // }
//     }
// }