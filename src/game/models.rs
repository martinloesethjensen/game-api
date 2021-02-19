use postgres::Row;

#[derive(Serialize, Debug)]
pub struct Game {
    pub id: u32,
    pub name: String,
}

#[derive(Deserialize, Debug)]
pub struct NewGame {
    pub name: String,
}

impl Game {
    pub fn from_row(row: &Row) -> Game {
        let id: i32 = row.get(0);
        
        Game {
            id: id as u32,
            name: row.get(1),
        }
    }
}