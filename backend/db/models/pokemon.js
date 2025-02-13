'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const sequelize = require('../../config/database');
const Pokemon = sequelize.define("Pokemons", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER
  },
  height: {
    type: Sequelize.INTEGER
  },
  weight: {
    type: Sequelize.INTEGER
  },
  ability: {
    type: Sequelize.STRING
  },
  category: {
    type: Sequelize.STRING
  },
  description: {
    type: Sequelize.STRING
  },
  gender: {
    type: Sequelize.INTEGER
  },
  region: {
    type: Sequelize.STRING
  },
  level: {
    type: Sequelize.INTEGER
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

module.exports = Pokemon
