const {
  uploadImage,
  uploadProfilePicture,
} = require("../controllers/assetController");
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

/**
 * @swagger
 * /upload/profile:
 *   post:
 *     summary: Upload a Profile picture
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
 *                 description: The image file to upload (Profile image).
 *     responses:
 *       201:
 *         description: Created
 *       400:
 *         description: Bad Request
 *       401:
 *         description: Unauthorized
 */
router.route("/upload/profile").post(authentication, uploadProfilePicture);

module.exports = router;
