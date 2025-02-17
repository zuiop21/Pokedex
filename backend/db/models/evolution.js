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
  evolves_to_id: {
    allowNull: true, //Some pokemons might be fully evolved, therefore this value can be null 
    type: Sequelize.INTEGER,
    references: {
      model: "Pokemons",
      key: "id"
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
    validate: {
      isNumeric: {
        msg: "Evolves to id must be a number"
      }
    }
  },
  condition: {
    allowNull: true, //Some pokemons might be fully evolved, therefore this value can be null 
    type: Sequelize.STRING,
    validate: {
      notEmpty: {
        msg: "Condition cannot be empty"
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

Evolution.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  return values;
};

module.exports = Evolution