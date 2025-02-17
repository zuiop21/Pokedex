const {createPokemon, readPokemon, updatePokemon, deletePokemon} = require("../controllers/pokemonController");

const router = require("express").Router();

router.route("/pokemons").post(createPokemon);

router.route("/pokemons/:name")
.get(readPokemon)
.patch(updatePokemon)
.delete(deletePokemon);

module.exports = router;