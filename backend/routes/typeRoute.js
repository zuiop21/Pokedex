const { createType, deleteType } = require("../controllers/typeController");
const { authentication, restricted } = require("../controllers/authController");

const router = require("express").Router();

router.route("/types").post(createType);

router.route("/types/:name").delete(deleteType);

module.exports = router;
