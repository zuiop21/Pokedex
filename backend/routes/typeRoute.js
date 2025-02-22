const { createType, deleteType } = require("../controllers/typeController");
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
 *     responses:
 *       201: { description: Created }
 *       400: { description: Bad request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Evolution not found }
 */
router.route("/types").post(restricted, createType);

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
 */
router.route("/types/:id").delete(restricted, deleteType);

module.exports = router;
