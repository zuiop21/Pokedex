'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const sequelize = require('../../config/database');
const Evolution = sequelize.define("Evolutions", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER
  },
  pokemon_id: {
    type: Sequelize.INTEGER,
    references: {
      model: "Pokemons",
      key: "id"
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE"
  },
  evolves_to_id: {
    type: Sequelize.INTEGER,
    references: {
      model: "Pokemons",
      key: "id"
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE"
  },
  condition: {
    type: Sequelize.STRING
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

module.exports = Evolution