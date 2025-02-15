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
Pokemon.hasOne(Evolution, {foreignKey: "pokemon_id"});
Pokemon.hasOne(Evolution, {foreignKey: "evolves_to_id:"});
Evolution.belongsTo(Pokemon);

// ┌───────────────┐          Favourite         ┌───────────────┐
// │    User       │      -->-----------<--     │   Pokemon     │
// └───────────────┘                            └───────────────┘
//Many to many relation between User and Pokemon through junction table Favourite
Pokemon.belongsToMany(User, {through: Favourite});
User.belongsToMany(Pokemon, {through: Favourite});


// ┌───────────────┐          PokemonType          ┌───────────────┐
// │   Pokemon     │      -->-------------<--      │     Type      │
// └───────────────┘                               └───────────────┘
//Many to many relation between Pokemon and Type through junction table PokemonType
Pokemon.belongsToMany(Type, {through: PokemonType});
Type.belongsToMany(Pokemon, {through: PokemonType});




