# Game API

This is a WIP and should only be used as is.

## Description

This is an API made in [Rust](https://www.rust-lang.org/) :crab: using [Rocket](https://github.com/SergioBenitez/Rocket/) :rocket: and [postgres](https://docs.rs/postgres)

The idea is to use this API as a game service. Client applications should call a "play game" endpoint with appropriate query paths. 
The response should return whether a game has been won or lost and also what reward for the win. These entries should be saved in the postgres database in table for played games. 

Furthermore, there will be a CRUD for games, rewards, and played games, so that an external CMS could access this and make changes to the service.

## Getting Started

TODO: Write a script to init db with the sql_dump file. 

## Deployment

TODO: Could deploy an instance on Digital Ocean (that could be the cheapest option)

## Tests

Run `cargo test` to run all the tests.

## API Documentation

[API documentation online here](https://martinloesethjensen.github.io/game-api/)

You can import the [Insomnia documentation json file](insomnia.json) into Insomnia.

Or use the cURL commands defined below.

Remember to have postgres installed and running.

Note: You can generate API documentation like Swagger with [insomnia-documenter](https://www.npmjs.com/package/insomnia-documenter).

### Play Game

```sh
curl --request GET \
  --url http://localhost:8000/api/game/play/1/23284323
```

### Create a Game

```sh
curl --request POST \
  --url http://localhost:8000/api/game \
  --header 'Content-Type: application/json' \
  --data '{
 "title": "nfjdnf",
 "body": "body thingyfdjvcd",
 "daily_prices": 100,
 "winning_chance": 5,
 "images": [
  {
   "image": "https://cataas.com/cat"
  },
  {
   "image": "https://cataas.com/cat"
  }
 ]
}'
```

### Get All Games

```sh
curl --request GET \
  --url http://localhost:8000/api/game/
```

### Get a Game by Id

```sh
curl --request GET \
  --url http://localhost:8000/api/game/2
```
