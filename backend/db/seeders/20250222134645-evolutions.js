"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert("Evolutions", [
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
      {
        pokemon_id: 3, //  Venusaur
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
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
      {
        pokemon_id: 6, // Charizard
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
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
      {
        pokemon_id: 9, // Blastoise
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 10, // Weedle
        evolves_to_id: 11, // Kakuna
        condition: "Level 7",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 11, // Kakuna
        evolves_to_id: 12, // Beedrill
        condition: "Level 10",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 12, // Beedrill
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 13, // Pichu
        evolves_to_id: 14, // Pikachu
        condition: "Level Friendship",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 14, // Pikachu
        evolves_to_id: 15, // Raichu
        condition: "Thunder Stone",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 15, // Raichu
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },

      {
        pokemon_id: 16, // Riolu
        evolves_to_id: 17, // Lucario
        condition: "Level Friendship",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 17, // Lucario
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 18, // Rayquaza
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 19, // Cleffa
        evolves_to_id: 20, // Clefairy
        condition: "Level Friendship",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 20, // Clefairy
        evolves_to_id: 21, // Clefable
        condition: "Moonstone",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 21, // Clefable
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 22, // Diglet
        evolves_to_id: 23, // Dugtrio
        condition: "Level 26",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 23, // Dugtrio
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 24, // Onix
        evolves_to_id: 25, // Steelix
        condition: "Exchanges",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 25, // Steelix
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 26, // Mew
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 27, // Suicune
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 28, //Snivy
        evolves_to_id: 29, // Servine
        condition: "Level 17",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 29, // Servine
        evolves_to_id: 30, // Serperior
        condition: "Level 36",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 30, // Serperior
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 31, // Zorua
        evolves_to_id: 32, // Zoroark
        condition: "Level 30",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 32, // Zoroark
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 33, // Lickitung
        evolves_to_id: 34, // Lickilicky
        condition: "Level up with Rollout",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 34, // Lickilicky
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 35, // Koffing
        evolves_to_id: 36, // Weezing
        condition: "Level 35",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 36, // Weezing
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 37, // Aron
        evolves_to_id: 38, // Lairon
        condition: "Level 32",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 38, // Lairon
        evolves_to_id: 39, // Aggron
        condition: "Level 42",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 39, // Aggron
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 40, // Litwick
        evolves_to_id: 41, // Lampet
        condition: "Level 41",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 41, // Lampet
        evolves_to_id: 42, // Chandelure
        condition: "Dusk Stone",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 42, // Chandelure
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 43, // Cubchoo
        evolves_to_id: 44, // Beartic
        condition: "Level 37",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 44, // Beartic
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 45, // Pikipek
        evolves_to_id: 46, // Trumbeak
        condition: "Level 14",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 46, // Trumbeak
        evolves_to_id: 47, // Toucannon
        condition: "Level 28",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        pokemon_id: 47, // Toucannon
        evolves_to_id: null, // Final form
        condition: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete("Evolutions", null, {});
  },
};
