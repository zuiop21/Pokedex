'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const sequelize = require('../../config/database');
const PokemonType = sequelize.define("PokemonTypes", {
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
  type_id: {
    type: Sequelize.INTEGER,
    references: {
      model: "Types",
      key: "id"
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE"
  },
  is_weakness: {
    type: Sequelize.BOOLEAN
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

module.exports = PokemonType;