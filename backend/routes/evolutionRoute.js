const {
  createEvolution,
  readEvolution,
  readAllEvolutions,
  deleteEvolution,
} = require("../controllers/evolutionController");

const { restricted, authentication } = require("../controllers/authController");

const router = require("express").Router();

/**
 * @swagger
 * tags:
 *   - name: Evolutions
 *     description: Pokémon evolution management
 */

/**
 * @swagger
 * /evolutions:
 *   get:
 *     summary: Get all Evolutions
 *     tags: [Evolutions]
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad Request }
 *       404: { description: Not found }
 *   post:
 *     summary: Create an evolution for a pokemon
 *     tags: [Evolutions]
 *     security: [{ bearerAuth: [] }]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               pokemon_id: { type: integer, example: 1 }
 *               evolves_to_id: { type: integer, example: 2 }
 *               condition: { type: string, example: "Level 16" }
 *     responses:
 *       201: { description: Created }
 *       400: { description: Bad request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 */
router
  .route("/evolutions")
  .get(readAllEvolutions)
  .post(authentication, restricted, createEvolution);

/**
 * @swagger
 * /evolutions/{pokemon_id}:
 *   get:
 *     summary: Get evolution by a pokemon's ID
 *     tags: [Evolutions]
 *     parameters:
 *       - in: path
 *         name: pokemon_id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200: { description: Success }
 *       404: { description: Not found }
 *   delete:
 *     summary: Delete evolution by a pokemon's ID
 *     tags: [Evolutions]
 *     security: [{ bearerAuth: [] }]
 *     parameters:
 *       - in: path
 *         name: pokemon_id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       204: { description: Deleted }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Not found }
 */

router
  .route("/evolutions/:pokemon_id")
  .get(readEvolution)
  .delete(authentication, restricted, deleteEvolution);

module.exports = router;
