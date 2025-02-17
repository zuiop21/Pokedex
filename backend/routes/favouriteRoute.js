const {createFavourite,readFavourite} = require('../controllers/favouriteController');

const router = require('express').Router();

router.route('/favourites').post(createFavourite);

router.route('/favourites/:id').get(readFavourite);

module.exports = router;