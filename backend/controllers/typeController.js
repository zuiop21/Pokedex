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
    description: body.description,
  });

  // If the type creation fails, throw an error
  if (!newType) {
    return next(new AppError("Failed to create the type", 400));
  }

  // Return the response
  return res.status(201).json({
    status: "Success",
    data: newType.toJSON(),
  });
});

/**
 * @function deleteType
 * @description Deletes a type by name.
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a promise that resolves to void.
 */
const deleteType = catchAsync(async (req, res, next) => {
  const { name } = req.params;
  // Find the type by name
  const type = await Type.findOne({
    where: {
      name: name,
    },
  });

  // If the type does not exist, return an error
  if (!type) {
    return next(new AppError(`Type with name ${name} not found`, 404));
  }

  // Delete the type
  await type.destroy();

  // Return the response
  return res.json({
    status: "Success",
    message: `Type with name ${name} deleted successfully`,
  });
});

module.exports = { createType, deleteType };
