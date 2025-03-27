const {
  readAllUser,
  updateUser,
  updateUserById,
} = require("../controllers/userController");
const { authentication, restricted } = require("../controllers/authController");

const router = require("express").Router();

/**
 * @swagger
 * tags:
 *   - name: Users
 *     description: User management
 */

/**
 * @swagger
 * /users:
 *   get:
 *     summary: Get all Users
 *     tags:
 *       - Users
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Success
 *       400:
 *         description: Bad Request
 *       404:
 *         description: Not found
 *   patch:
 *     summary: Update a User
 *     tags:
 *       - Users
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               password:
 *                 type: string
 *                 example: "newPassword"
 *     responses:
 *       200:
 *         description: Success
 *       400:
 *         description: Bad Request
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Not found
 */
router
  .route("/users")
  .get(authentication, restricted, readAllUser)
  .patch(authentication, updateUser);

/**
 * @swagger
 * /users/{id}:
 *   patch:
 *     summary: Update a User by ID
 *     tags:
 *       - Users
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: The ID of the user to update
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               role:
 *                 type: string
 *                 example: "admin"
 *               is_locked:
 *                 type: boolean
 *                 example: true
 *     responses:
 *       200:
 *         description: Success
 *       400:
 *         description: Bad Request
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Not Found
 */
router.route("/users/:id").patch(authentication, restricted, updateUserById);

module.exports = router;
