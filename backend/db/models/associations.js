const User = require("./user");
const Favourite = require("./favourite");
const Evolution = require("./evolution");
const Pokemon = require("./pokemon");
const PokemonType = require("./pokemontype");
const Type = require("./type");
const Region = require("./region");

// ┌───────────────┐      --|-----------|--      ┌───────────────┐
// │   Pokemon     │      --|-----------|--      │  Evolution    │
// └───────────────┘                             └───────────────┘
// Double one to one relation between Pokemon and Evolution
Evolution.belongsTo(Pokemon, {
  foreignKey: "pokemon_id",
  as: "pokemon",
});

Evolution.belongsTo(Pokemon, {
  foreignKey: "evolves_to_id",
  as: "evolves_to",
});

Pokemon.hasOne(Evolution, {
  foreignKey: "pokemon_id",
  as: "evolution",
});

// ┌───────────────┐          Favourite         ┌───────────────┐
// │    User       │      -->-----------<--     │   Pokemon     │
// └───────────────┘                            └───────────────┘
// Many to many relation between User and Pokemon through junction table Favourite
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
// │    Pokemon    │      -->-------------<--      │     Type      │
// └───────────────┘                               └───────────────┘
// Many to many relation between Pokemon and Type through junction table PokemonType
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

// ┌───────────────┐                          ┌───────────────┐
// │    Region     │      --|---------<--     │    Pokemon    │
// └───────────────┘                          └───────────────┘
// One to many relation between Region and Pokemon

Region.hasMany(Pokemon, {
  foreignKey: "region_id",
  as: "pokemons",
});

Pokemon.belongsTo(Region, {
  foreignKey: "region_id",
  as: "region",
});

// ┌───────────────┐                          ┌───────────────┐
// │    Region     │      --|---------<--     │     User      │
// └───────────────┘                          └───────────────┘
// One to many relation between Region and User

Region.hasMany(User, {
  foreignKey: "region_id",
  as: "users",
});

User.belongsTo(Region, {
  foreignKey: "region_id",
  as: "region",
});
