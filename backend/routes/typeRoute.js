const {
  createType,
  readAllType,
  updateType,
  deleteType,
} = require("../controllers/typeController");
const { authentication, restricted } = require("../controllers/authController");

const router = require("express").Router();

/**
 * @swagger
 * tags:
 *   - name: Types
 *     description: Type management
 */

/**
 * @swagger
 * /types:
 *   get:
 *     summary: Get all Types
 *     tags: [Types]
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad Request }
 *       404: { description: Not found }
 *   post:
 *     summary: Create a new Pokémon type
 *     tags: [Types]
 *     security: [{ bearerAuth: [] }]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name: { type: string, example: "Fire" }
 *               color: { type: string, example: "0xFF000000" }
 *               imgUrl: { type: string, example: "http://localhost:3000/assets/types/fire.png" }
 *               imgUrlOutline: { type: string, example: "http://localhost:3000/assets/types/fireOutline.png" }
 *     responses:
 *       201: { description: Created }
 *       400: { description: Bad request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Evolution not found }
 */
router
  .route("/types")
  .get(readAllType)
  .post(authentication, restricted, createType);

/**
 * @swagger
 * /types/{id}:
 *   delete:
 *     summary: Delete a Pokémon type by ID
 *     tags: [Types]
 *     security: [{ bearerAuth: [] }]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *         description: ID of the Pokémon type to delete
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Not found }
 *   patch:
 *     summary: Update a Pokémon type by ID
 *     tags: [Types]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID of the Pokémon type to update
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               color:
 *                 type: string
 *                 example: "0xFFFFFFFF"
 *                 description: New color of the Pokémon type (Hex code)
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Not found }
 */
router
  .route("/types/:id")
  .delete(authentication, restricted, deleteType)
  .patch(authentication, restricted, updateType);

module.exports = router;
