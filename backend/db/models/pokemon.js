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
  height: {
    allowNull: false,
    type: Sequelize.DOUBLE,
    validate: {
      notNull : {
        msg: "Height cannot be null"
      },
      isDecimal : {
        msg: "Weight must be a decimal"
      }
    },
  },
  weight: {
    allowNull: false,
    type: Sequelize.DOUBLE,
    validate: {
      notNull : {
        msg: "Weight cannot be null"
      },
      isDecimal : {
        msg: "Weight must be a decimal"
      }
    },
  },
  ability: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Ability cannot be null"
      },
      notEmpty : {
        msg: "Ability cannot be empty"
      },
    },
  },
  category: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Category cannot be null"
      },
      notEmpty : {
        msg: "Category cannot be empty"
      },
    },
  },
  description: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Description cannot be null"
      },
      notEmpty : {
        msg: "Description cannot be empty"
      },
    },
  },
  gender: {
    allowNull: false,
    type: Sequelize.INTEGER,
    validate: {
      notNull : {
        msg: "Gender cannot be null"
      },
      isNumeric : { 
        msg: "Gender must be a number"
      }
    }
  },
  region: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull : {
        msg: "Region cannot be null"
      },
      notEmpty : {
        msg: "Region cannot be empty"
      },
    },
  },
  level: {
    allowNull: false,
    type: Sequelize.INTEGER,
    validate: {
      notNull : {
        msg: "Level cannot be null"
      },
      isNumeric : {
        msg: "Level must be a number"
      }
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

module.exports = Pokemon
