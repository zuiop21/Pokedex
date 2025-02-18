"use strict";
const { Model, Sequelize } = require("sequelize");
const sequelize = require("../../config/database");
const Pokemon = require("./pokemon");
const AppError = require("../../utils/appError");

// Evolution Model: Defines the evolution relationship between Pokémon
// This model represents how one Pokémon evolves into another.
// It includes a double foreign key referencing the same "Pokemons" table
// to establish evolution chains. Evolution conditions are also stored here.
const Evolution = sequelize.define("Evolutions", {
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
      // Check that the original Pokémon exists
      parentExists(value) {
        return Pokemon.findByPk(value).then((pokemon) => {
          if (!pokemon) {
            throw new AppError(`Pokémon with id ${value} not found`, 404);
          }
        });
      },
      // Check if the source Pokémon (pokemon_id) does not already have an evolution relationship.
      // This prevents a Pokémon from having multiple evolutions, e.g., 1-2 if 1-3 already exists.
      evolutionExist(value) {
        return Evolution.findOne({
          where: { pokemon_id: value },
        }).then((existingEvolution) => {
          if (existingEvolution) {
            throw new AppError(
              `Pokémon with id ${value} already has an evolution`,
              400
            );
          }
        });
      },
    },
  },
  evolves_to_id: {
    allowNull: true, //Some pokemons might be fully evolved, therefore this value can be null
    type: Sequelize.INTEGER,
    references: {
      model: "Pokemons",
      key: "id",
    },
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
    validate: {
      isNumeric: {
        msg: "Evolves to id must be a number",
      },
      // Check that a Pokémon does not evolve into itself
      selfEvolution(value) {
        if (this.pokemon_id === value) {
          throw new AppError("A Pokémon cannot evolve into itself", 400);
        }
      },
      // Check that the original Pokémon exists
      parentExists(value) {
        if (value !== null && value !== undefined) {
          return Pokemon.findByPk(value).then((pokemon) => {
            if (!pokemon) {
              throw new AppError(`Pokémon with id ${value} not found`, 404);
            }
          });
        }
      },
      //Check that no other Pokémon already evolves into the same target.
      // This prevents a Pokémon from having two "parents", e.g., 1-3 if 2-3 already exists.
      evolutionExist(value) {
        if (value !== null && value !== undefined) {
          return Evolution.findOne({
            where: { evolves_to_id: value },
          }).then((existingEvolution) => {
            if (existingEvolution) {
              throw new AppError(
                `This evolved form is already assigned to another Pokémon`,
                400
              );
            }
          });
        }
      },
      // Check that no reverse evolution exists
      // If there is already a relationship where the source and target are reversed (e.g., 1-2 exists, so 2-1 is not allowed)
      reverseEvolution(value) {
        if (value !== null && value !== undefined) {
          return Evolution.findOne({
            where: {
              pokemon_id: value,
              evolves_to_id: this.pokemon_id,
            },
          }).then((existingReverseEvolution) => {
            if (existingReverseEvolution) {
              throw new Error("Reverse evolution is not allowed");
            }
          });
        }
      },

      //Check if the target Pokémon is the base form of the Pokémon
      isBase(value) {
        if (value !== null && value !== undefined) {
          return Pokemon.findOne({
            where: {
              id: value,
              is_base_form: true,
            },
          }).then((existingBase) => {
            if (existingBase) {
              throw new AppError(
                `Pokémon with id ${value} is the base form of the pokemon`,
                400
              );
            }
          });
        }
      },
    },
  },
  condition: {
    allowNull: true, //Some pokemons might be fully evolved, therefore this value can be null
    type: Sequelize.STRING,
    validate: {
      notEmpty: {
        msg: "Condition cannot be empty",
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

// ToJSON method to remove timestamps from the JSON response
Evolution.prototype.toJSON = function () {
  const values = Object.assign({}, this.get());
  delete values.createdAt;
  delete values.updatedAt;
  delete values.deletedAt;
  return values;
};

module.exports = Evolution;
