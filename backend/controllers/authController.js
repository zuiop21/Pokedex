const User = require("../db/models/user");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
require("dotenv").config({ path: `${process.cwd()}/.env` });

/**
 * @file authController.js
 * @description Controller for handling authentication-related operations.
 */

/**
 * Generates a JWT (JSON Web Token) for the current user.
 * The token's expiration and secret key are defined in the .env file.
 *
 * @param {Object} payload - The payload to encode in the JWT.
 * @returns {string} The generated JWT.
 */
const generateToken = (payload) => {
  return jwt.sign(payload, process.env.JWT_SECRET_KEY, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

/**
 * Registers a new user.
 *
 * @function
 * @async
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 * @returns {Promise<void>}
 */
const register = catchAsync(async (req, res, next) => {
  const body = req.body;

  // Create a new user
  const newUser = await User.create({
    email: body.email,
    password: body.password,
    confirmPassword: body.confirmPassword,
    role: body.role,
  });

  if (!newUser) {
    return next(new AppError("Failed to create the user", 400));
  }

  // Generate a JWT token for the user
  const token = generateToken({ id: newUser.id });

  // Return the response with user id, role, and token
  return res.status(201).json({
    status: "Success",
    data: {
      id: newUser.id,
      role: newUser.role,
      token: token,
    },
  });
});

/**
 * Logs in an existing user.
 *
 * @function
 * @async
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 * @returns {Promise<void>}
 */
const login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(new AppError("Please provide email and password", 400));
  }

  const user = await User.findOne({ where: { email: email } });

  if (!user || !(await bcrypt.compare(password, user.password))) {
    return next(new AppError("Incorrect email or password", 401));
  }

  // Generate a JWT token for the user
  const token = generateToken({ id: user.id });

  // Return the response with user id, role, and token
  return res.json({
    status: "Success",
    data: {
      id: user.id,
      role: user.role,
      token: token,
    },
  });
});

/**
 * Authenticates a user based on the provided JWT.
 *
 * @function
 * @async
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 * @returns {Promise<void>}
 */
const authentication = catchAsync(async (req, res, next) => {
  // Get the token from headers
  let idToken = "";
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    idToken = req.headers.authorization.split(" ")[1];
  }
  if (!idToken) {
    return next(new AppError("Please login to get access", 401));
  }
  // Token verification
  const tokenDetail = jwt.verify(idToken, process.env.JWT_SECRET_KEY);
  // Get the user detail from db and add to req object
  const freshUser = await User.findByPk(tokenDetail.id);

  if (!freshUser) {
    return next(new AppError("User no longer exists", 400));
  }
  req.user = freshUser;
  return next();
});

/**
 * Restricts access to certain routes based on having admin role.
 *
 * @function
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 * @returns {Promise<void>}
 */
const restricted = (req, res, next) => {
  if (req.user.role != "admin") {
    return next(
      new AppError("You do not have permission to perform this action", 403)
    );
  }
  return next();
};

module.exports = { register, login, authentication, restricted };
