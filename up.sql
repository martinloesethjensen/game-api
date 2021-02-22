DROP TABLE IF EXISTS game_prices CASCADE;
DROP TABLE IF EXISTS games CASCADE;
DROP TABLE IF EXISTS game_images CASCADE;
DROP TABLE IF EXISTS game_price_images CASCADE;

CREATE TABLE IF NOT EXISTS game_prices (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT,
    available_prices INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS games (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT,
    daily_prices INTEGER NOT NULL DEFAULT 0,
    winning_chance INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS game_images (
    game_id INTEGER NOT NULL REFERENCES games(id),
    image VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS game_price_images (
    game_price_id INTEGER NOT NULL REFERENCES game_prices(id),
    image VARCHAR(255)
);