const {
  createFavourite,
  readFavourite,
  deleteFavourite,
} = require("../controllers/favouriteController");

const router = require("express").Router();
/**
 * @swagger
 * tags:
 *   - name: Favourites
 *     description: Favourite Pokémon management
 */

/**
 * @swagger
 * /favourites:
 *   get:
 *     summary: Get the user's favourite Pokémons
 *     tags: [Favourites]
 *     security: [{ bearerAuth: [] }]
 *     responses:
 *       201: { description: Created }
 *       400: { description: Bad Request }
 *       401: { description: Unauthorized }
 *       404: { description: Not found }
 */
router.route("/favourites").get(readFavourite);
/**
 * @swagger
 * /favourites/{pokemon_id}:
 *   post:
 *     summary: Create a user's favourite by ID
 *     tags: [Favourites]
 *     security: [{ bearerAuth: [] }]
 *     parameters:
 *       - in: path
 *         name: pokemon_id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       201: { description: Created }
 *       400: { description: Bad Request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Not found }
 *   delete:
 *     summary: Delete favourite for user by ID
 *     tags: [Favourites]
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
  .route("/favourites/:pokemon_id")
  .post(createFavourite)
  .delete(deleteFavourite);
module.exports = router;
