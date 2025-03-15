const PokemonType = require("../db/models/pokemontype");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

/**
 * @function readAllPokemonType
 * @description Retrieves all the pokemontypes
 * @param {Object} req - Express request object containing Pokémon name in the params.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the Pokémon data.
 */
const readAllPokemonType = catchAsync(async (req, res, next) => {
  // Find all the types
  const types = await PokemonType.findAll();

  // If no type is found, throw an error
  if (!types) {
    return next(new AppError(`There aren't any types`, 404));
  }

  // Convert each Type instance to a plain object
  const typeJSON = types.map((type) => type.toJSON());

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: typeJSON,
  });
});

module.exports = { readAllPokemonType };
