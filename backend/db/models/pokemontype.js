"use strict";
const { Model, Sequelize } = require("sequelize");
const sequelize = require("../../config/database");

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
      notNull : {
        msg: "Pokemon id cannot be null"
      },
      isNumeric : {
        msg: "Pokemon id must be a number"
      }
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
    allowNull: false,
    type: Sequelize.BOOLEAN,
    validate: {
      notNull: {
        msg: "IsWeakness cannot be null",
      },
      isIn: {
        args: [[true, false]],
        msg: "IsWeakness must be either true or false"
      }
    }
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

PokemonType.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  return values;
};

module.exports = PokemonType;
