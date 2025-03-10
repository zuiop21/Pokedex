"use strict";
const { Model, Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../../config/database");

//TODO a pokemon can only have two main types
// PokemonType Model: Defines the many-to-many relationship between Pokémons and Types
// This model links Pokémon to their respective types and identifies weaknesses.
// It includes foreign keys referencing both the Pokemons and Types tables.
// Soft deletion is supported with the deletedAt field.
const PokemonType = sequelize.define("PokemonTypes", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER,
  },
  pokemon_id: {
    allowNull: false,
    type: Sequelize.INTEGER,
    references: {
      model: "Pokemons",
      key: "id",
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
    validate: {
      notNull: {
        msg: "Pokemon id cannot be null",
      },
      isNumeric: {
        msg: "Pokemon id must be a number",
      },
    },
  },
  type_id: {
    allowNull: false,
    type: Sequelize.INTEGER,
    references: {
      model: "Types",
      key: "id",
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
    validate: {
      notNull: {
        msg: "Type id cannot be null",
      },
      isNumeric: {
        msg: "Type id must be a number",
      },
    },
  },
  is_weakness: {
    type: DataTypes.ENUM("yes", "no", "both"),
    allowNull: false,
    validate: {
      notNull: {
        msg: "IsWeakness cannot be null",
      },
      isIn: {
        args: [["yes", "no", "both"]],
        msg: "IsWeakness must be either 'yes', 'no' or 'both'",
      },
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
PokemonType.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  return values;
};

module.exports = PokemonType;
