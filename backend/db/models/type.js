"use strict";
const { Model, Sequelize } = require("sequelize");
const sequelize = require("../../config/database");
const AppError = require("../../utils/appError");

// Type Model: Represents the different Pokémon types
// This model stores type names such as Fire, Water, Grass, etc.
// It is referenced in the PokemonTypes model to establish type relationships.
// Soft deletion is supported with the deletedAt field.
const Type = sequelize.define("Types", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: Sequelize.INTEGER,
  },
  name: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull: {
        msg: "Name cannot be null",
      },
      notEmpty: {
        msg: "Name cannot be empty",
      },
    },
  },
  color: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull: {
        msg: "Color cannot be null",
      },
      notEmpty: {
        msg: "Color cannot be empty",
      },
      color: {
        allowNull: false,
        type: Sequelize.STRING,
        validate: {
          notNull: {
            msg: "Color cannot be null",
          },
          notEmpty: {
            msg: "Color cannot be empty",
          },
          isHexadecimal(value) {
            const hexPattern = /^0xFF[a-fA-F0-9]{6}$/;
            if (!hexPattern.test(value)) {
              throw new AppError(
                "The given color must be a valid hexadecimal!",
                400
              );
            }
          },
        },
      },
    },
  },
  imgUrl: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull: {
        msg: "ImgUrl cannot be null",
      },
    },
  },
  imgUrlOutline: {
    allowNull: false,
    type: Sequelize.STRING,
    validate: {
      notNull: {
        msg: "ImgUrlOutline cannot be null",
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

// ToJson method to remove timestamps from the JSON response
Type.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  return values;
};

module.exports = Type;
