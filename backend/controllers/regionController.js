const catchAsync = require("../utils/catchAsync");
const Region = require("../db/models/region");
const AppError = require("../utils/appError");

/**
 * @file regionController.js
 * @description Controller for handling region-related operations.
 */

/**
 * Creates a new region record.
 *
 * @function createRegion
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.body - The request body.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 * @throws {AppError} - Throws an error if the region creation fails.
 */
const createRegion = catchAsync(async (req, res, next) => {
  const body = req.body;

  // Create the region record
  const newRegion = await Region.create({
    name: body.name,
    generation: body.generation,
    imgUrl: body.imgUrl,
  });

  // If the region creation fails, throw an error
  if (!newRegion) {
    return next(new AppError("Failed to create the region", 400));
  }

  // Return the response
  return res.status(201).json({
    status: "Success",
    data: newRegion.toJSON(),
  });
});

/**
 * Reads an region by ID.
 *
 * @function
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.params - Request parameters.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the region data or an error message.
 */
const readRegion = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  // Find the region record for a pokemon with ID
  const region = await Region.findByPk(id);

  // If the region record is not found, throw an error
  if (!region) {
    return next(new AppError(`Region with id ${id} not found`, 404));
  }

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: region.toJSON(),
  });
});

/**
 * Deletes an region by ID.
 *
 * @function
 * @async
 * @param {Object} req - Express request object.
 * @param {Object} req.params - Request parameters.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with a success message or an error message.
 */
const deleteRegion = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  // Find the region record for a pokemon with ID
  const region = await Region.findByPk(id);

  // If the region record is not found, throw an error
  if (!region) {
    return next(new AppError(`The region with id ${id} doesn't exist`, 404));
  }

  // Delete the region record
  await region.destroy();

  // Return the response
  return res.status(204).json({
    status: "Success",
    message: `The region with id ${id} was deleted successfully`,
  });
});

module.exports = { createRegion, readRegion, deleteRegion };
