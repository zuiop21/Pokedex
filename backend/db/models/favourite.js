'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const sequelize = require('../../config/database');

// Favourite Model: Represents the many-to-many relationship between Users and Pokémons
// This model allows users to mark Pokémons as their favourites.
// It uses a junction table structure with foreign keys linking to both Users and Pokémons.
const Favourite = sequelize.define("Favourites", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER
  },
  user_id: {
    type: Sequelize.INTEGER,
    references: {
      model: "Users",
      key: "id"
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE"
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

module.exports = Favourite;