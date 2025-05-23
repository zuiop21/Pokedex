const PokemonType = require("../db/models/pokemontype");
const Type = require("../db/models/type");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

/**
 * @file typeController.js
 * @description Controller for handling type-related operations.
 */

/**
 * @function createType
 * @description Creates a new type.
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const createType = catchAsync(async (req, res, next) => {
  const body = req.body;

  // Create a new type
  const newType = await Type.create({
    name: body.name,
    color: body.color,
    imgUrl: req.imgUrl,
    imgUrlOutline: req.imgUrlOutline,
  });

  // If the type creation fails, throw an error
  if (!newType) {
    return next(new AppError("Failed to create the type", 400));
  }

  const responseData = {
    ...newType.toJSON(),
    is_weakness: "no",
  };

  // Return the response
  return res.status(201).json({
    status: "Success",
    data: responseData,
  });
});

/**
 * @function readAllType
 * @description Retrieves all the types
 * @param {Object} req - Express request object containing Pokémon name in the params.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the Pokémon data.
 */
const readAllType = catchAsync(async (req, res, next) => {
  // Find all the types
  const types = await Type.findAll();

  // If no type is found, throw an error
  if (!types) {
    return next(new AppError(`There aren't any types`, 404));
  }

  // Convert each Type instance to a plain object
  const typeJSON = types.map((type) => ({
    ...type.toJSON(),
    is_weakness: "no",
  }));

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: typeJSON,
  });
});

/**
 * @function updateType
 * @description Updates an existing Type's details.
 * @param {Object} req - Express request object containing Pokémon name in the params and updated data in the body.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the updated Pokémon data.
 */
const updateType = catchAsync(async (req, res, next) => {
  const id = req.params.id;

  const { color, name } = req.body;

  // Find the Type by its name
  const type = await Type.findByPk(id);

  // If the Type is not found, throw an error
  if (!type) {
    return next(new AppError(`Type with id ${id} not found`, 404));
  }

  // Update the Type's details
  if (color !== undefined) type.color = color;
  if (name !== undefined) type.name = name;
  await type.save();

  const responseData = {
    ...type.toJSON(),
    is_weakness: "no",
  };

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: responseData,
  });
});

/**
 * @function deleteType
 * @description Deletes a type by ID.
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const deleteType = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  // Find the type by name
  const type = await Type.findByPk(id);

  // If the type does not exist, return an error
  if (!type) {
    return next(new AppError(`Type with id ${id} not found`, 404));
  }

  // Delete the type
  await type.destroy();

  // Return the response
  return res.status(204).json({
    status: "Success",
    message: `The ${type.name} type was deleted successfully`,
  });
});

module.exports = { createType, readAllType, updateType, deleteType };
