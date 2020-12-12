https://mb-pokedex.herokuapp.com/
API: https://mb-pokedex.herokuapp.com/api/v1/pokemons?page=1

# How to

Fork/clone project and run 

```rails db:migrate db:seed```

Start the server by running 

```rails s```

and open localhost:3000 in your browser.


# API End Points

 GET /api/pokemons
    list Pokemons

 GET /api/pokemons/5
    show a Pokemon

 POST /
    creates a Pokemon

 PUT /api/pokemons/1
    updates a Pokemon

 PATCH /api/pokemons/1
    updates a Pokemon

 DELETE /api/pokemons/722
    delete a Pokemon
