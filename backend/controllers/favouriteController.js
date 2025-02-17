const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const Favourite = require("../db/models/favourite");
const Pokemon = require("../db/models/pokemon");
const User = require("../db/models/user");


const createFavourite = catchAsync(async (req, res, next) => {
    const { user_id, pokemon_name } = req.body;

    const user = await User.findByPk(user_id);
    if (!user) {
        return next(new AppError(`User with id ${user_id} not found`, 404));
    }


    const pokemon = await Pokemon.findOne({
        where: {
            name: pokemon_name,
        },
    });
    if(!pokemon) {
        return next(new AppError(`Pokémon with name ${pokemon_name} not found`, 404));
    }

    const existingFavourite = await Favourite.findOne({
        where: {
            user_id: user_id,
            pokemon_id: pokemon.id,
        },
    });
    if (existingFavourite) {
        return next(new AppError(`User with id ${user_id} has already liked the Pokémon called ${pokemon_name}`, 400));
    }


    const favourite = await Favourite.create({
        user_id: user_id,
        pokemon_id: pokemon.id,
    });

    if (!favourite) {
        return next(new AppError("Failed to add Pokémon to favourites", 400));
    }

    return res.status(201).json({
        status: "Success",
        data: favourite,
    });
});


const readFavourite = catchAsync(async (req, res, next) => {
    const { id } = req.params;

    const user = await User.findByPk(id, {
        attributes: [], 
        include: [{
          model: Pokemon,
          as: "pokemons",
          attributes: ['name'], 
          through: {
            attributes: [] 
          }
        }]
      });
      

    if (!user) {
        return next(new AppError(`User with id ${id} not found`, 404));
    }

    if (!user.pokemons || !user.pokemons.length) {
        return next(new AppError(`No favourite Pokémon found for user with id ${id}`, 404));
    }

    return res.json({
        status: "Success",
        data: user, // ez tartalmazza a user id-t és a pokemons tömböt, ahol minden elem csak a "name" mezőt tartalmazza
    });
});


const deleteFavourite = catchAsync(async (req, res, next) => {
    const { user_id, pokemon_id } = req.body;

    const favourite = await Favourite.findOne({
        where: {
            user_id: user_id,
            pokemon_id: pokemon_id,
        },
    });

    if (!favourite) {
        return next(new AppError(`Favourite with user_id ${user_id} and pokemon_id ${pokemon_id} not found`, 404));
    }

    const pokemon = await Pokemon.findByPk(pokemon_id);
    if (!pokemon) {
        return next(new AppError(`Pokémon with id ${pokemon_id} not found`, 404));
    }

    await favourite.destroy();

    return res.json({
        status: "Success",
        message: `User with id ${user_id} no longer likes ${pokemon.name}`,
    });
});



module.exports = {createFavourite , readFavourite, deleteFavourite};