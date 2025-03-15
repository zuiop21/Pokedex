const { readAllPokemonType } = require("../controllers/pokemonTypeController");

const router = require("express").Router();

/**
 * @swagger
 * tags:
 *   - name: PokemonTypes
 *     description: PokemonType management
 */

/**
 * @swagger
 * /pokemontypes:
 *   get:
 *     summary: Get all Types
 *     tags: [PokemonTypes]
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad Request }
 *       404: { description: Not found }
 */
router.route("/pokemontypes").get(readAllPokemonType);

module.exports = router;
