'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const sequelize = require('../../config/database');

// Evolution Model: Defines the evolution relationship between Pokémon
// This model represents how one Pokémon evolves into another.
// It includes a double foreign key referencing the same "Pokemons" table 
// to establish evolution chains. Evolution conditions are also stored here.
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