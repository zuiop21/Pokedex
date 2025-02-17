const { createType, deleteType} = require("../controllers/typeController");
const {authentication,restricted} = require("../controllers/authController");


const router = require("express").Router();

router.route("/types")
    .post(authentication,restricted,createType);

router.route("/types/:name")
    .delete(authentication,deleteType); 

module.exports = router;
