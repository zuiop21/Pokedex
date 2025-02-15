'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const sequelize = require('../../config/database');

// Pokemon Model: Represents the core attributes of a Pokémon
// This model stores fundamental data such as height, weight, abilities, and other characteristics.
// It also includes metadata like region, level, and category.
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
