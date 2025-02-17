const User = require("./user");
const Favourite = require("./favourite");
const Evolution = require("./evolution");
const Pokemon = require("./pokemon");
const PokemonType = require("./pokemontype");
const Type = require("./type");

// ┌───────────────┐      --|-----------|--      ┌───────────────┐
// │   Pokemon     │      --|-----------|--      │  Evolution    │
// └───────────────┘                             └───────────────┘
// Double one to one relation between Pokemon and Evolution
  Evolution.belongsTo(Pokemon, { 
    foreignKey: "pokemon_id", 
    as: "pokemon" 
  });
  Evolution.belongsTo(Pokemon, { 
    foreignKey: "evolves_to_id", 
    as: "evolves_to" 
  });


// ┌───────────────┐          Favourite         ┌───────────────┐
// │    User       │      -->-----------<--     │   Pokemon     │
// └───────────────┘                            └───────────────┘
//Many to many relation between User and Pokemon through junction table Favourite
Pokemon.belongsToMany(User, {
  through: Favourite,
  foreignKey: "pokemon_id",
  otherKey: "user_id",
  as: "users",
});
User.belongsToMany(Pokemon, {
  through: Favourite,
  foreignKey: "user_id",
  otherKey: "pokemon_id",
  as: "pokemons",
});

// ┌───────────────┐          PokemonType          ┌───────────────┐
// │   Pokemon     │      -->-------------<--      │     Type      │
// └───────────────┘                               └───────────────┘
//Many to many relation between Pokemon and Type through junction table PokemonType
// A Pokemon és Type közötti many-to-many kapcsolat
Pokemon.belongsToMany(Type, {
  through: PokemonType,
  foreignKey: "pokemon_id",
  otherKey: "type_id",
  as: "types",
});

Type.belongsToMany(Pokemon, {
  through: PokemonType,
  foreignKey: "type_id",
  otherKey: "pokemon_id",
  as: "pokemons",
});
