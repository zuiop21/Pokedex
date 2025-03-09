const { uploadImage } = require("../controllers/assetController");
const router = require("express").Router();
const { restricted, authentication } = require("../controllers/authController");

/**
 * @swagger
 * tags:
 *   - name: Assets
 *     description: File upload endpoints
 */

/**
 * @swagger
 * /upload/pokemon:
 *   post:
 *     summary: Upload a Pokémon image
 *     tags: [Assets]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               image:
 *                 type: string
 *                 format: binary
 *                 description: The image file to upload (Pokemon image).
 *     responses:
 *       201:
 *         description: Created
 *       400:
 *         description: Bad Request
 *       401:
 *         description: Unauthorized
 */
router.route("/upload/pokemon").post(authentication, restricted, uploadImage);

/**
 * @swagger
 * /upload/region:
 *   post:
 *     summary: Upload a Region image
 *     tags: [Assets]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               image:
 *                 type: string
 *                 format: binary
 *                 description: The image file to upload (Region image).
 *     responses:
 *       201:
 *         description: Created
 *       400:
 *         description: Bad Request
 *       401:
 *         description: Unauthorized
 */
router.route("/upload/region").post(authentication, restricted, uploadImage);

module.exports = router;
