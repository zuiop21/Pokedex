"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("PokemonTypes", [
      // Bulbasaur Evolution Line
      {
        pokemon_id: 1,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Grass
      {
        pokemon_id: 1,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Poison
      {
        pokemon_id: 1,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Flying
      {
        pokemon_id: 1,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Fire
      {
        pokemon_id: 1,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Psychic

      {
        pokemon_id: 2,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Grass
      {
        pokemon_id: 2,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Poison
      {
        pokemon_id: 2,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Flying
      {
        pokemon_id: 2,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Fire
      {
        pokemon_id: 2,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Psychic

      {
        pokemon_id: 3,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Grass
      {
        pokemon_id: 3,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Poison
      {
        pokemon_id: 3,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Flying
      {
        pokemon_id: 3,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Fire
      {
        pokemon_id: 3,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Psychic

      // Charmander's Types
      {
        pokemon_id: 4,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Fire
      {
        pokemon_id: 4,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Water
      {
        pokemon_id: 4,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rock

      {
        pokemon_id: 5,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Fire
      {
        pokemon_id: 5,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Water
      {
        pokemon_id: 5,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rock

      {
        pokemon_id: 6,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Fire
      {
        pokemon_id: 6,
        type_id: 10,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Flying
      {
        pokemon_id: 6,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Water
      {
        pokemon_id: 6,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rock
      {
        pokemon_id: 6,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Electric

      // Squirtle's Types
      {
        pokemon_id: 7,
        type_id: 3,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Water
      {
        pokemon_id: 7,
        type_id: 5,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Grass
      {
        pokemon_id: 7,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Electric

      {
        pokemon_id: 8,
        type_id: 3,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Water
      {
        pokemon_id: 8,
        type_id: 5,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Grass
      {
        pokemon_id: 8,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Electric

      {
        pokemon_id: 9,
        type_id: 3,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Water
      {
        pokemon_id: 9,
        type_id: 5,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Grass
      {
        pokemon_id: 9,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Electric
    ]);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("PokemonTypes", null, {});
  },
};
