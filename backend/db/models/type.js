'use strict';
const {
  Model, Sequelize
} = require('sequelize');
const sequelize = require('../../config/database');


// Type Model: Represents the different Pokémon types
// This model stores type names such as Fire, Water, Grass, etc.
// It is referenced in the PokemonTypes model to establish type relationships.
// Soft deletion is supported with the deletedAt field.
const Type = sequelize.define("Types" ,{
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER
  },
  name: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Name cannot be null"
      },
      notEmpty : {
       msg: "Name cannot be empty"
      },
    },
    
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

module.exports= Type;