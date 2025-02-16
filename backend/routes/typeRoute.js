const { createType, updateType, deleteType} = require("../controllers/typeController");
const {authentication,restricted} = require("../controllers/authController");


const router = require("express").Router();

router.route("/types")
    .post(authentication,restricted,createType);

router.route("/types/:name")
    .patch(authentication,updateType)
    .delete(authentication,deleteType); 

module.exports = router;
