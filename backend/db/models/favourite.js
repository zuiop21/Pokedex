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
    allowNull: false,
    type: Sequelize.INTEGER,
    references: {
      model: "Users",
      key: "id"
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
    validate: {
      notNull: {
        msg: "User id cannot be null"
      },
      isNumeric: {
        msg: "User id must be a number"
      }
    }
  },
  pokemon_id: {
    allowNull: false,
    type: Sequelize.INTEGER,
      references: {
      model: "Pokemons",
      key: "id"
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
    validate: {
      notNull: {
        msg: "Pokemon id cannot be null"
      },
      isNumeric: {
        msg: "Pokemon id must be a number"
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

Favourite.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  return values;
};

module.exports = Favourite;