'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const bcrypt = require("bcrypt");
const sequelize = require('../../config/database');
const AppError = require('../../utils/appError');

// User Model: Represents the users in the system
// This model stores user credentials, including email and password.
// The password is hashed using bcrypt for security.
// A virtual field (confirmPassword) ensures that password confirmation matches before saving.
const User = sequelize.define("Users", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER
  },
  role: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Role cannot be null"
      },
      notEmpty : {
        msg: "Role cannot be empty"
      },
      isIn: {
        args: [['admin', 'user']],
        msg: "Role must be either 'admin' or 'user'"
      }
    },
    
  },
  email: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Email cannot be null"
      },
      notEmpty : {
       msg: "Email cannot be empty"
      },
      isEmail : {
        msg: "Invalid email"
      }
    },
  },
  password: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Password cannot be null"
      },
      notEmpty : {
       msg: "Password cannot be empty"
      },
    },
  },
  confirmPassword: {
    type: Sequelize.VIRTUAL,
    set(value) {
      if(value==this.password) {
        const hashPassword = bcrypt.hashSync(value, 10);
        this.setDataValue("password", hashPassword);
      } else {
        throw new AppError(
          'Password and confirm password must be the same', 400
        )
      }
    }
  },
  createdAt: {
    allowNull: false,
    type: Sequelize.DATE
  },
  updatedAt: {
    allowNull: false,
    type: Sequelize.DATE
  },
  deletedAt: {
    type: Sequelize.DATE
  }
});

User.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  delete values.password;
  return values;
};

module.exports = User;