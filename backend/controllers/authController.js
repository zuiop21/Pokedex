const User = require("../db/models/user");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
require("dotenv").config({ path: `${process.cwd()}/.env` });

//This method generates a JWT (JSONWebToken) for the current user
//It's expiration and secret key are defined in the .env file
const generateToken = (payload) => {
  return jwt.sign(payload, process.env.JWT_SECRET_KEY, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

//Register method
const register = async (req, res, next) => {
  const body = req.body;

  const newUser = await User.create({
    email: body.email,
    password: body.password,
    confirmPassword: body.confirmPassword,
    role: body.role,
  });

  const result = newUser.toJSON();
  delete result.password;
  delete result.deletedAt;

  result.token = generateToken({
    id: result.id,
  });

  if (!result) {
    return res.status(400).json({
      status: "Error",
      message: "Failed to create the user",
    });
  }

  return res.status(201).json({
    status: "Success",
    data: result,
  });
};

//Login method
const login = async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({
      status: "Error",
      message: "Please provide email and password",
    });
  }

  const result = await User.findOne({ where: { email: email } });

  //Check if there is a user with the given email, 
  //and if the given password matches with the encrypted one
  if (!result || !(await bcrypt.compare(password, result.password))) {
    return res.status(401).json({
      status: "Error",
      message: "Incorrect email or password",
    });
  }

  const token = generateToken({
    id: result.id
  })

  return res.json({
    status: "Success",
    token
  })
};

module.exports = {register, login };
