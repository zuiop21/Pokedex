"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert("Evolutions", [
      // Bulbasaur evolúciói
      {
        pokemon_id: 1, // Bulbasaur
        evolves_to_id: 2, // Ivysaur
        condition: "Level 16",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 2, // Ivysaur
        evolves_to_id: 3, // Venusaur
        condition: "Level 32",
        createdAt: new Date(),
        updatedAt: new Date(),
      },

      // Charmander evolúciói
      {
        pokemon_id: 4, // Charmander
        evolves_to_id: 5, // Charmeleon
        condition: "Level 16",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 5, // Charmeleon
        evolves_to_id: 6, // Charizard
        condition: "Level 36",
        createdAt: new Date(),
        updatedAt: new Date(),
      },

      // Squirtle evolúciói
      {
        pokemon_id: 7, // Squirtle
        evolves_to_id: 8, // Wartortle
        condition: "Level 16",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 8, // Wartortle
        evolves_to_id: 9, // Blastoise
        condition: "Level 36",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete("Evolutions", null, {});
  },
};
