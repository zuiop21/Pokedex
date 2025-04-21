const {
  createRegion,
  readRegion,
  readAllRegions,
  updateRegion,
  deleteRegion,
} = require("../controllers/regionController");

const { restricted, authentication } = require("../controllers/authController");
const { uploadRegionPicture } = require("../controllers/assetController");

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
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 example: "Kanto"
 *               difficulty:
 *                 type: integer
 *                 example: 1
 *               image:
 *                 type: string
 *                 format: binary
 *                 description: The region image (multipart file)
 *     responses:
 *       201:
 *         description: Created
 *       400:
 *         description: Bad request
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden
 */
router
  .route("/regions")
  .get(readAllRegions)
  .post(authentication, restricted, uploadRegionPicture, createRegion);
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
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Success
 *       404:
 *         description: Not found
 *   delete:
 *     summary: Delete a region by its ID
 *     tags: [Regions]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       204:
 *         description: Deleted
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Not found
 *   patch:
 *     summary: Update a region by ID
 *     tags: [Regions]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID of the region to update
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 example: "Kanto"
 *                 description: New name of the region
 *               difficulty:
 *                 type: integer
 *                 example: 1
 *                 description: New difficulty of the region
 *     responses:
 *       200:
 *         description: Success
 *       400:
 *         description: Bad request
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Not found
 */

router
  .route("/regions/:id")
  .get(readRegion)
  .patch(authentication, restricted, updateRegion)
  .delete(authentication, restricted, deleteRegion);

module.exports = router;
