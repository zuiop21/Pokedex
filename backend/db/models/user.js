'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const bcrypt = require("bcrypt");
const sequelize = require('../../config/database');
const User = sequelize.define("Users", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER
  },
  role: {
    type: Sequelize.STRING
  },
  email: {
    type: Sequelize.STRING
  },
  password: {
    type: Sequelize.STRING
  },
  confirmPassword: {
    type: Sequelize.VIRTUAL,
    set(value) {
      if(value==this.password) {
        const hashPassword = bcrypt.hashSync(value, 10);
        this.setDataValue("password", hashPassword);
      } else {
        throw new Error(
          'Password and confirm password must be the same'
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

module.exports = User;