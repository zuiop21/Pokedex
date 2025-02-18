const { register, login } = require("../controllers/authController");

const router = require("express").Router();

//TODO add authentication middleware everywhere
router.route("/register").post(register);
router.route("/login").post(login);

module.exports = router;
