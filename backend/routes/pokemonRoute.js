const {
  createPokemon,
  readPokemon,
  updatePokemon,
  deletePokemon,
} = require("../controllers/pokemonController");

const router = require("express").Router();

const { restricted, authentication } = require("../controllers/authController");
/**
 * @swagger
 * tags:
 *   - name: Pokemons
 *     description: Pokémon management
 */

/**
 * @swagger
 * /pokemons:
 *   post:
 *     summary: Create a Pokémon
 *     tags: [Pokemons]
 *     security: [{ bearerAuth: [] }]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               level: { type: integer, example: 69 }
 *               gender: { type: integer, example: 69 }
 *               height: { type: number, format: float, example: 69.9 }
 *               weight: { type: number, format: float, example: 69.6 }
 *               name: { type: string, example: "Pikachu" }
 *               ability: { type: string, example: "Lightning" }
 *               category: { type: string, example: "Rat" }
 *               description: { type: string, example: "Cute" }
 *               region: { type: string, example: "Pokeland" }
 *               is_base_form: { type: boolean, example: true }
 *               types:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     name: { type: string, example: "Fire" }
 *                     is_weakness: { type: boolean, example: true }
 *     responses:
 *       200: { description: Evolution found }
 *       201: { description: Created }
 *       400: { description: Bad Request }
 *       401: { description: Unauthorized }
 *       404: { description: Evolution not found }
 */

router.route("/pokemons").post(authentication, restricted, createPokemon);

/**
 * @swagger
 * /pokemons/{id}:
 *   get:
 *     summary: Get Pokémon by ID
 *     tags: [Pokemons]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *         description: The id of the Pokémon
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad Request }
 *       404: { description: Not found }
 *   patch:
 *     summary: Update a Pokémon by ID
 *     tags: [Pokemons]
 *     security: [{ bearerAuth: [] }]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *         description: The ID of the Pokémon to update
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               level: { type: integer, example: 69 }
 *               gender: { type: integer, example: 69 }
 *               height: { type: number, format: float, example: 69.9 }
 *               weight: { type: number, format: float, example: 69.6 }
 *               name: { type: string, example: "Pikachu" }
 *               ability: { type: string, example: "Lightning" }
 *               category: { type: string, example: "Rat" }
 *               description: { type: string, example: "Cute" }
 *               region: { type: string, example: "Pokeland" }
 *               is_base_form: { type: boolean, example: true }
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad Request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Not found }
 *   delete:
 *     summary: Delete a Pokémon by ID
 *     tags: [Pokemons]
 *     security: [{ bearerAuth: [] }]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string }
 *         description: The ID of the Pokémon to delete
 *     responses:
 *       204: { description: Deleted }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Not found }
 */
router
  .route("/pokemons/:id")
  .get(readPokemon)
  .patch(authentication, restricted, updatePokemon)
  .delete(authentication, restricted, deletePokemon);

module.exports = router;
