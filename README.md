# Game API

## Description

This is an API made in [Rust](https://www.rust-lang.org/) :crab: using [Rocket](https://github.com/SergioBenitez/Rocket/) :rocket: and [postgres](https://docs.rs/postgres)

TODO: write about what it does

## Getting Started

TODO: how to run

## Adding Game Service

TODO: the general idea on how we should a new game service to the Game API

// new folder with new service
// handlers, models,
// mount new routes to the rocket

## Deployment

TODO

## Tests

TODO

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
