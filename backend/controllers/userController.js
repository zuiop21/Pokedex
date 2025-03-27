const User = require("../db/models/user");
const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Op } = require("sequelize");

/**
 * @function readAllUser
 * @description Retrieves all the user
 * @param {Object} req - Express request object containing Pokémon name in the params.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the Pokémon data.
 */
const readAllUser = catchAsync(async (req, res, next) => {
  const currentAdmin = req.user;

  // Find all the users
  const users = await User.findAll({
    where: {
      id: { [Op.ne]: currentAdmin.id }, // Exclude current admin
    },
  });

  // If no user is found, throw an error
  if (!users || users.length === 0) {
    return next(new AppError(`There aren't any users`, 404));
  }

  // Convert each User instance to a plain object
  const userJSON = users.map((user) => user.toJSON());

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: userJSON,
  });
});

/**
 * @function updateUser
 * @description Updates an existing User's details.
 * @param {Object} req - Express request object containing Pokémon name in the params and updated data in the body.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the updated Pokémon data.
 */
const updateUser = catchAsync(async (req, res, next) => {
  const id = req.user.id;

  const { role, password, is_locked, imgUrl } = req.body;

  // Find the User by its name
  const user = await User.findByPk(id);

  // If the User is not found, throw an error
  if (!user) {
    return next(new AppError(`User with id ${id} not found`, 404));
  }

  // Update the User's details
  if (password !== undefined) user.password = password; //TODO if password is given, then encrypt it
  if (imgUrl !== undefined) user.imgUrl = imgUrl;
  await user.save();

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: user.toJSON(),
  });
});

/**
 * @function updateUserById
 * @description Updates an existing User's details by ID.
 * @param {Object} req - Express request object containing Pokémon name in the params and updated data in the body.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the updated Pokémon data.
 */
const updateUserById = catchAsync(async (req, res, next) => {
  const id = req.params.id;

  const { role, password, is_locked, imgUrl } = req.body;

  // Find the User by its name
  const user = await User.findByPk(id);

  // If the User is not found, throw an error
  if (!user) {
    return next(new AppError(`User with id ${id} not found`, 404));
  }

  // Update the User's details
  if (role !== undefined) user.role = role;
  if (is_locked !== undefined) user.is_locked = is_locked;
  await user.save();

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: user.toJSON(),
  });
});

module.exports = {
  readAllUser,
  updateUser,
  updateUserById,
};
