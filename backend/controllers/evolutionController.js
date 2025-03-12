const catchAsync = require("../utils/catchAsync");
const Evolution = require("../db/models/evolution");
const Pokemon = require("../db/models/pokemon");
const AppError = require("../utils/appError");

/**
 * @file evolutionController.js
 * @description Controller for handling evolution-related operations.
 */

/**
 * Creates a new evolution record.
 *
 * @function createEvolution
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.body - The request body.
 * @param {number} req.body.pokemon_id - The ID of the Pokémon that is evolving.
 * @param {number} req.body.evolves_to_id - The ID of the Pokémon it evolves to.
 * @param {string} req.body.condition - The condition under which the evolution occurs.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 * @throws {AppError} - Throws an error if the evolution creation fails.
 */
const createEvolution = catchAsync(async (req, res, next) => {
  const { pokemon_id, evolves_to_id, condition } = req.body;

  //If the evolves_to_id is not provided, set it to null
  const finalCondition = evolves_to_id === null ? null : condition;

  // Create the evolution record
  const newEvolution = await Evolution.create({
    pokemon_id,
    evolves_to_id,
    condition: finalCondition,
  });

  // If the evolution creation fails, throw an error
  if (!newEvolution) {
    return next(new AppError("Failed to create the evolution", 400));
  }

  // Return the response
  return res.status(201).json({
    status: "Success",
    data: newEvolution.toJSON(),
  });
});

/**
 * Reads an evolution by a pokemon's ID.
 *
 * @function
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.params - Request parameters.
 * @param {string} req.params.id - Evolution ID.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the evolution data or an error message.
 */
const readEvolution = catchAsync(async (req, res, next) => {
  const { pokemon_id } = req.params;

  // Find the evolution record for a pokemon with ID
  const evolution = await Evolution.findOne({
    where: {
      pokemon_id: pokemon_id,
    },
    attributes: ["condition"],
    include: [
      {
        model: Pokemon,
        as: "pokemon",
        attributes: ["name"],
      },
      {
        model: Pokemon,
        as: "evolves_to",
        attributes: ["name"],
      },
    ],
  });

  // If the evolution record is not found, throw an error
  if (!evolution) {
    return next(
      new AppError(`Evolution with pokemon id ${pokemon_id} not found`, 404)
    );
  }

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: evolution.toJSON(),
  });
});

/**
 * @function readAllEvolutions
 * @description Retrieves all the evolutions
 * @param {Object} req - Express request object containing Pokémon name in the params.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the Pokémon data.
 */
const readAllEvolutions = catchAsync(async (req, res, next) => {
  // Find all the evolutions
  const evolutions = await Evolution.findAll();

  // If no evolution is found, throw an error
  if (!evolutions) {
    return next(new AppError(`There aren't any evolutions`, 404));
  }

  // Convert each Evolution instance to a plain object
  const evolutionJSON = evolutions.map((evolution) => evolution.toJSON());

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: evolutionJSON,
  });
});

/**
 * Deletes an evolution by a pokemon's ID.
 *
 * @function
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.params - Request parameters.
 * @param {string} req.params.id - Evolution ID.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with a success message or an error message.
 */
const deleteEvolution = catchAsync(async (req, res, next) => {
  const { pokemon_id } = req.params;

  // Find the evolution record for a pokemon with ID
  const evolution = await Evolution.findOne({
    where: {
      pokemon_id: pokemon_id,
    },
  });

  // If the evolution record is not found, throw an error
  if (!evolution) {
    return next(
      new AppError(
        `The pokemon with id ${pokemon_id} doesn't have an evolution yet`,
        404
      )
    );
  }

  // Delete the evolution record
  await evolution.destroy();

  // Return the response
  return res.status(204).json({
    status: "Success",
    message: `The evolution belonging to pokemon with id ${pokemon_id} was deleted successfully`,
  });
});

module.exports = {
  createEvolution,
  readEvolution,
  readAllEvolutions,
  deleteEvolution,
};
