const { register, login } = require("../controllers/authController");
const router = require("express").Router();

/**
 * @swagger
 * tags:
 *   - name: Authentication
 *     description: User authentication endpoints
 */

/**
 * @swagger
 * /register:
 *   post:
 *     summary: Register a new user
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email: { type: string, example: user@example.com }
 *               password: { type: string, example: "user" }
 *               confirmPassword: { type: string, example: "user" }
 *               role: { type: string, enum: [user, admin], example: user }
 *               region_id: { type: integer, example: 1 }
 *     responses:
 *       201: { description: Created }
 *       400: { description: Bad Request }
 */
router.route("/register").post(register);

/**
 * @swagger
 * /login:
 *   post:
 *     summary: User login
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email: { type: string, example: user@example.com }
 *               password: { type: string, example: "user" }
 *     responses:
 *       200: { description: Success }
 *       400: { description: Bad Request }
 *       401: { description: Unauthorized }
 */
router.route("/login").post(login);

module.exports = router;
