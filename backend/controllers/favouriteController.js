const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const Favourite = require("../db/models/favourite");
const Pokemon = require("../db/models/pokemon");

const getFavouritePokemonsForUser = catchAsync(async (req, res, next) => {
    const { id } = req.params;

    const result = await Favourite.findAll({
        where: {
            user_id: id, 
        },
        include: [
            {
                model: Pokemon,
            },
        ],
    });

    if (!result.length) {
        return next(new AppError(`No favourite Pokémon found for user with id ${id}`, 404));
    }

    return res.json({
        status: "Success",
        data: result,
    });
});


module.exports = { getFavouritePokemonsForUser };