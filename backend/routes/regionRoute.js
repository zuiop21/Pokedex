const {
  createRegion,
  readRegion,
  readAllRegions,
  deleteRegion,
} = require("../controllers/regionController");

const { restricted, authentication } = require("../controllers/authController");

const router = require("express").Router();

/**
 * @swagger
 * tags:
 *   - name: Regions
 *     description: Pokémon region management
 */

/**
 * @swagger
 * /regions:
 *   get:
 *     summary: Get all Regions
 *     tags: [Regions]
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad Request }
 *       404: { description: Not found }
 *   post:
 *     summary: Create a new region
 *     tags: [Regions]
 *     security: [{ bearerAuth: [] }]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name: { type: string, example: "Kanto" }
 *               generation: { type: integer, example: 1 }
 *               imgUrl: { type: string, example: "http://localhost:3000/assets/regions/region1.png" }
 *     responses:
 *       201: { description: Created }
 *       400: { description: Bad request }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 */
router
  .route("/regions")
  .get(readAllRegions)
  .post(authentication, restricted, createRegion);

/**
 * @swagger
 * /regions/{id}:
 *   get:
 *     summary: Get a region by its ID
 *     tags: [Regions]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200: { description: Success }
 *       404: { description: Not found }
 *   delete:
 *     summary: Delete a region by its ID
 *     tags: [Regions]
 *     security: [{ bearerAuth: [] }]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       204: { description: Deleted }
 *       401: { description: Unauthorized }
 *       403: { description: Forbidden }
 *       404: { description: Not found }
 */
router
  .route("/regions/:id")
  .get(readRegion)
  .delete(authentication, restricted, deleteRegion);

module.exports = router;
