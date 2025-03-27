const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const Favourite = require("../db/models/favourite");
const Pokemon = require("../db/models/pokemon");

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
 * @param {number} req.body.user_id - ID of the user.
 * @param {string} req.body.pokemon_name - Name of the Pokémon.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const createFavourite = catchAsync(async (req, res, next) => {
  const { pokemon_id } = req.params;
  const user = req.user;

  // Check if the Pokémon exists
  const pokemon = await Pokemon.findByPk(pokemon_id);

  // If the Pokémon does not exist, return an error
  if (!pokemon) {
    return next(new AppError(`Pokémon with id ${pokemon_id} not found`, 404));
  }

  // Check if the user has already liked the Pokémon
  const existingFavourite = await Favourite.findOne({
    where: {
      user_id: user.id,
      pokemon_id: pokemon_id,
    },
  });

  // If the user has already liked the Pokémon, return an error
  if (existingFavourite) {
    return next(
      new AppError(
        `User with id ${user.id} has already liked the Pokémon with id ${pokemon_id}`,
        400
      )
    );
  }

  // Create a new favourite record
  const favourite = await Favourite.create({
    user_id: user.id,
    pokemon_id: pokemon_id,
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
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const readFavourite = catchAsync(async (req, res, next) => {
  const favourites = await Favourite.findAll({
    where: {
      user_id: req.user.id,
    },
  });

  if (!favourites) {
    return next(
      new AppError(
        `User with id ${req.user.id} doesn't have any favourites`,
        404
      )
    );
  }

  const favouriteJSON = favourites.map((favourite) => favourite.toJSON());

  return res.status(200).json({
    status: "Success",
    data: favouriteJSON,
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
  const { pokemon_id } = req.params;
  const user = req.user;

  // Check if the favourite record exists
  const favourite = await Favourite.findOne({
    where: {
      user_id: user.id,
      pokemon_id: pokemon_id,
    },
  });

  // If the favourite record does not exist, return an error
  if (!favourite) {
    return next(
      new AppError(
        `User ${user.id} doesn't like pokemon with id ${pokemon_id}`,
        404
      )
    );
  }

  // Delete the favourite record
  await favourite.destroy();

  // Return the response
  return res.status(204).json({
    status: "Success",
    message: `User ${user.id} no longer likes pokemon with id${pokemon_id}`,
  });
});

module.exports = { createFavourite, readFavourite, deleteFavourite };
