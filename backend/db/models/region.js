"use strict";
const { Model, Sequelize } = require("sequelize");
const sequelize = require("../../config/database");
const Region = sequelize.define("Regions", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER,
  },
  name: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull: { msg: "Name cannot be null" },
      notEmpty: { msg: "Name cannot be empty" },
    },
  },
  difficulty: {
    allowNull: false,
    type: Sequelize.INTEGER,
    validate: {
      notNull: { msg: "Difficulty cannot be null" },
      isNumeric: { msg: "Difficulty must be a number" },
    },
  },
  imgUrl: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull: { msg: "ImgUrl cannot be null" },
    },
  },
  createdAt: {
    allowNull: false,
    type: Sequelize.DATE,
  },
  updatedAt: {
    allowNull: false,
    type: Sequelize.DATE,
  },
  deletedAt: {
    type: Sequelize.DATE,
  },
});

// ToJSON method to remove timestamps from the model
Region.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  return values;
};

module.exports = Region;
