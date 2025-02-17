const {createEvolution, readEvolution,deleteEvolution} = require("../controllers/evolutionController");

const router = require("express").Router();

router.route("/evolutions").post(createEvolution);

router.route("/evolutions/:id")
.get(readEvolution).
delete(deleteEvolution);

module.exports = router;