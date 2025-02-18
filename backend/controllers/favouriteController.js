const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const Favourite = require("../db/models/favourite");
const Pokemon = require("../db/models/pokemon");
const User = require("../db/models/user");
//TODO validációk kiszervezése
/**
 * @file favouriteController.js
 * @description Controller for handling favourite-related operations.
 */

/**
 * Creates a favourite Pokémon for a user.
 *
 * @function createFavourite
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.body - Request body.
 * @param {number} req.body.user_id - ID of the user.
 * @param {string} req.body.pokemon_name - Name of the Pokémon.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const createFavourite = catchAsync(async (req, res, next) => {
  const { user_id, pokemon_name } = req.body;

  // Check if the user exists
  const user = await User.findByPk(user_id);

  // If the user does not exist, return an error
  if (!user) {
    return next(new AppError(`User with id ${user_id} not found`, 404));
  }

  // Check if the Pokémon exists
  const pokemon = await Pokemon.findOne({
    where: {
      name: pokemon_name,
    },
  });

  // If the Pokémon does not exist, return an error
  if (!pokemon) {
    return next(
      new AppError(`Pokémon with name ${pokemon_name} not found`, 404)
    );
  }

  // Check if the user has already liked the Pokémon
  const existingFavourite = await Favourite.findOne({
    where: {
      user_id: user_id,
      pokemon_id: pokemon.id,
    },
  });

  // If the user has already liked the Pokémon, return an error
  if (existingFavourite) {
    return next(
      new AppError(
        `User with id ${user_id} has already liked the Pokémon called ${pokemon_name}`,
        400
      )
    );
  }

  // Create a new favourite record
  const favourite = await Favourite.create({
    user_id: user_id,
    pokemon_id: pokemon.id,
  });

  // If the creation fails, return an error
  if (!favourite) {
    return next(new AppError("Failed to add Pokémon to favourites", 400));
  }

  // Return the response
  return res.status(201).json({
    status: "Success",
    data: favourite,
  });
});

/**
 * Reads the favourite Pokémon of a user.
 *
 * @function readFavourite
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.params - Request parameters.
 * @param {number} req.params.id - ID of the user.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const readFavourite = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  // Find the user by ID
  const user = await User.findByPk(id, {
    attributes: [],
    include: [
      {
        model: Pokemon,
        as: "pokemons",
        attributes: ["name"],
        through: {
          attributes: [],
        },
      },
    ],
  });

  // If the user does not exist, return an error
  if (!user) {
    return next(new AppError(`User with id ${id} not found`, 404));
  }

  // If the user has no favourite Pokémon, return an error
  if (!user.pokemons || !user.pokemons.length) {
    return next(
      new AppError(`No favourite Pokémon found for user with id ${id}`, 404)
    );
  }

  // Return the response
  return res.json({
    status: "Success",
    data: user,
  });
});

/**
 * Deletes a favourite Pokémon for a user.
 *
 * @function deleteFavourite
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.body - Request body.
 * @param {number} req.body.user_id - ID of the user.
 * @param {number} req.body.pokemon_id - ID of the Pokémon.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const deleteFavourite = catchAsync(async (req, res, next) => {
  const { user_id, pokemon_id } = req.body;

  // Check if the favourite record exists
  const favourite = await Favourite.findOne({
    where: {
      user_id: user_id,
      pokemon_id: pokemon_id,
    },
  });

  // If the favourite record does not exist, return an error
  if (!favourite) {
    return next(
      new AppError(
        `Favourite with user_id ${user_id} and pokemon_id ${pokemon_id} not found`,
        404
      )
    );
  }

  // Delete the favourite record
  await favourite.destroy();

  // Return the response
  return res.json({
    status: "Success",
    message: `User with id ${user_id} no longer likes ${pokemon.name}`,
  });
});

module.exports = { createFavourite, readFavourite, deleteFavourite };
