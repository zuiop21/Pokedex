"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("PokemonTypes", [
      {
        pokemon_id: 1,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, //Bulbasaur - Grass
      {
        pokemon_id: 1,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, //Bulbasaur - Poison
      {
        pokemon_id: 1,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, //Bulbasaur - Fire
      {
        pokemon_id: 1,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, //Bulbasaur - Psychic
      {
        pokemon_id: 1,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, //Bulbasaur - Flying
      {
        pokemon_id: 1,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, //Bulbasaur - Ice

      {
        pokemon_id: 2,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Ivysaur - Grass
      {
        pokemon_id: 2,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Ivysaur - Poison
      {
        pokemon_id: 2,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Ivysaur - Fire
      {
        pokemon_id: 2,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Ivysaur - Psychic
      {
        pokemon_id: 2,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Ivysaur - Flying
      {
        pokemon_id: 2,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Ivysaur - Ice

      {
        pokemon_id: 3,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Venusaur - Grass
      {
        pokemon_id: 3,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Venusaur - Poison
      {
        pokemon_id: 3,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Venusaur - Fire
      {
        pokemon_id: 3,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Venusaur - Psychic
      {
        pokemon_id: 3,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Venusaur - Flying
      {
        pokemon_id: 3,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Venusaur - Ice

      {
        pokemon_id: 4,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmander - Fire
      {
        pokemon_id: 4,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmander - Water
      {
        pokemon_id: 4,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmander - Rock
      {
        pokemon_id: 4,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmander - Ground

      {
        pokemon_id: 5,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmeleon - Fire
      {
        pokemon_id: 5,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmeleon - Water
      {
        pokemon_id: 5,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmeleon - Rock
      {
        pokemon_id: 5,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charmeleon - Ground

      {
        pokemon_id: 6,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charizard - Fire
      {
        pokemon_id: 6,
        type_id: 10,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charizard - Flying
      {
        pokemon_id: 6,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charizard - Water
      {
        pokemon_id: 6,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charizard - Rock
      {
        pokemon_id: 6,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Charizard - Ground

      {
        pokemon_id: 7,
        type_id: 3,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Squirtle - Water
      {
        pokemon_id: 7,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Squirtle - Grass
      {
        pokemon_id: 7,
        type_id: 4,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Squirtle - Electric

      {
        pokemon_id: 8,
        type_id: 3,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Wartortle - Water
      {
        pokemon_id: 8,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Wartortle - Grass
      {
        pokemon_id: 8,
        type_id: 4,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Wartortle - Electric

      {
        pokemon_id: 9,
        type_id: 3,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Blastoise - Water
      {
        pokemon_id: 9,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Blastoise - Grass
      {
        pokemon_id: 9,
        type_id: 4,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Blastoise - Electric

      {
        pokemon_id: 10,
        type_id: 12,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weedle - Bug
      {
        pokemon_id: 10,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weedle - Poison
      {
        pokemon_id: 10,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weedle - Fire
      {
        pokemon_id: 10,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weedle - Flying
      {
        pokemon_id: 10,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weedle - Psychic
      {
        pokemon_id: 10,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weedle - Rock

      {
        pokemon_id: 11,
        type_id: 12,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Kakuna - Bug
      {
        pokemon_id: 11,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Kakuna - Poison
      {
        pokemon_id: 11,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Kakuna - Fire
      {
        pokemon_id: 11,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Kakuna - Flying
      {
        pokemon_id: 11,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Kakuna - Psychic
      {
        pokemon_id: 11,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Kakuna - Rock

      {
        pokemon_id: 12,
        type_id: 12,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beedrill - Bug
      {
        pokemon_id: 12,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beedrill - Poison
      {
        pokemon_id: 12,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beedrill - Fire
      {
        pokemon_id: 12,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beedrill - Flying
      {
        pokemon_id: 12,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beedrill - Psychic
      {
        pokemon_id: 12,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beedrill - Rock

      {
        pokemon_id: 13,
        type_id: 4,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pichu - Electric
      {
        pokemon_id: 13,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pichu - Ground

      {
        pokemon_id: 14,
        type_id: 4,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pikachu - Electric
      {
        pokemon_id: 14,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pikachu - Ground

      {
        pokemon_id: 15,
        type_id: 4,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Raichu - Electric
      {
        pokemon_id: 15,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Raichu - Ground

      {
        pokemon_id: 16,
        type_id: 7,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Riolu - Fighting
      {
        pokemon_id: 16,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Riolu - Psychic
      {
        pokemon_id: 16,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Riolu - Flying
      {
        pokemon_id: 16,
        type_id: 17,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Riolu - Fairy

      {
        pokemon_id: 17,
        type_id: 7,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lucario - Fighting
      {
        pokemon_id: 17,
        type_id: 17,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lucario - Steel
      {
        pokemon_id: 17,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lucario - Fighting
      {
        pokemon_id: 17,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lucario - Ground
      {
        pokemon_id: 17,
        type_id: 15,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lucario - Fire

      {
        pokemon_id: 18,
        type_id: 15,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rayquaza - Dragon
      {
        pokemon_id: 18,
        type_id: 10,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rayquaza - Flying
      {
        pokemon_id: 18,
        type_id: 17,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rayquaza - Ice
      {
        pokemon_id: 18,
        type_id: 15,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rayquaza - Dragon
      {
        pokemon_id: 18,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rayquaza - Fairy
      {
        pokemon_id: 18,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Rayquaza - Rock

      {
        pokemon_id: 19,
        type_id: 18,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cleffa - Fairy
      {
        pokemon_id: 19,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cleffa - Poison
      {
        pokemon_id: 19,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cleffa - Steel

      {
        pokemon_id: 20,
        type_id: 18,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Clefairy - Fairy
      {
        pokemon_id: 20,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Clefairy - Poison
      {
        pokemon_id: 20,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Clefairy - Steel

      {
        pokemon_id: 21,
        type_id: 18,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Clefable - Fairy
      {
        pokemon_id: 21,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Clefable - Poison
      {
        pokemon_id: 21,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Clefable - Steel

      {
        pokemon_id: 22,
        type_id: 9,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Diglett - Ground
      {
        pokemon_id: 22,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Diglett - Water
      {
        pokemon_id: 22,
        type_id: 5,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Diglett - Grass
      {
        pokemon_id: 22,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Diglett - Ice

      {
        pokemon_id: 23,
        type_id: 9,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Dugtrio - Ground
      {
        pokemon_id: 23,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Dugtrio - Water
      {
        pokemon_id: 23,
        type_id: 5,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Dugtrio - Grass
      {
        pokemon_id: 23,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Dugtrio - Ice

      {
        pokemon_id: 24,
        type_id: 9,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Ground
      {
        pokemon_id: 24,
        type_id: 13,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Rock
      {
        pokemon_id: 24,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Water
      {
        pokemon_id: 24,
        type_id: 5,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Grass
      {
        pokemon_id: 24,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Ice
      {
        pokemon_id: 24,
        type_id: 18,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Steel
      {
        pokemon_id: 24,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Fighting
      {
        pokemon_id: 24,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Onix - Ground

      {
        pokemon_id: 25,
        type_id: 18,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Steelix - Steel
      {
        pokemon_id: 25,
        type_id: 9,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Steelix - Ground
      {
        pokemon_id: 25,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Steelix - Fire
      {
        pokemon_id: 25,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Steelix - Ground
      {
        pokemon_id: 25,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Steelix - Water
      {
        pokemon_id: 25,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Steelix - Fighting

      {
        pokemon_id: 26,
        type_id: 11,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Mew - Psychic
      {
        pokemon_id: 26,
        type_id: 16,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Mew - Bug
      {
        pokemon_id: 26,
        type_id: 15,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Mew - Dark
      {
        pokemon_id: 26,
        type_id: 14,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Mew - Ghost

      {
        pokemon_id: 27,
        type_id: 3,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Suicune - Water
      {
        pokemon_id: 27,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Suicune - Electric
      {
        pokemon_id: 27,
        type_id: 5,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Suicune - Grass

      {
        pokemon_id: 28,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Snivy - Grass
      {
        pokemon_id: 28,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Snivy - Fire
      {
        pokemon_id: 28,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Snivy - Flying
      {
        pokemon_id: 28,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Snivy - Ice
      {
        pokemon_id: 28,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Snivy - Bug
      {
        pokemon_id: 28,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Snivy - Poison

      {
        pokemon_id: 29,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Servine - Grass
      {
        pokemon_id: 29,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Servine - Fire
      {
        pokemon_id: 29,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Servine - Flying
      {
        pokemon_id: 29,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Servine - Ice
      {
        pokemon_id: 29,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Servine - Bug
      {
        pokemon_id: 29,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Servine - Poison

      {
        pokemon_id: 30,
        type_id: 5,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Serperior - Grass
      {
        pokemon_id: 30,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Serperior - Fire
      {
        pokemon_id: 30,
        type_id: 10,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Serperior - Flying
      {
        pokemon_id: 30,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Serperior - Ice
      {
        pokemon_id: 30,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Serperior - Bug
      {
        pokemon_id: 30,
        type_id: 8,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Serperior - Poison

      {
        pokemon_id: 31,
        type_id: 16,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zorua - Dark
      {
        pokemon_id: 31,
        type_id: 17,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zorua - Fighting
      {
        pokemon_id: 31,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zorua - Bug
      {
        pokemon_id: 31,
        type_id: 18,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zorua - Fairy

      {
        pokemon_id: 32,
        type_id: 16,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zoroark - Dark
      {
        pokemon_id: 32,
        type_id: 17,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zoroark - Fighting
      {
        pokemon_id: 32,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zoroark - Bug
      {
        pokemon_id: 32,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Zoroark - Fairy

      {
        pokemon_id: 33,
        type_id: 1,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lickitung - Normal
      {
        pokemon_id: 33,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lickitung - Fighting

      {
        pokemon_id: 34,
        type_id: 1,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lickilicky - Normal
      {
        pokemon_id: 34,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lickilicky - Fighting

      {
        pokemon_id: 35,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Koffing - Poison
      {
        pokemon_id: 35,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Koffing - Psychic
      {
        pokemon_id: 35,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Koffing - Ground

      {
        pokemon_id: 36,
        type_id: 8,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weezing - Poison
      {
        pokemon_id: 36,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weezing - Psychic
      {
        pokemon_id: 36,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Weezing - Ground

      {
        pokemon_id: 37,
        type_id: 17,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aron - Steel
      {
        pokemon_id: 37,
        type_id: 13,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aron - Rock
      {
        pokemon_id: 37,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aron - Water
      {
        pokemon_id: 37,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aron - Ground
      {
        pokemon_id: 37,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aron - Fighting

      {
        pokemon_id: 38,
        type_id: 17,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lairon - Steel
      {
        pokemon_id: 38,
        type_id: 13,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lairon - Rock
      {
        pokemon_id: 38,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lairon - Water
      {
        pokemon_id: 38,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lairon - Ground
      {
        pokemon_id: 38,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lairon - Fighting

      {
        pokemon_id: 39,
        type_id: 17,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aggron - Steel
      {
        pokemon_id: 39,
        type_id: 13,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aggron - Rock
      {
        pokemon_id: 39,
        type_id: 3,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aggron - Water
      {
        pokemon_id: 39,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aggron - Ground
      {
        pokemon_id: 39,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Aggron - Fighting

      {
        pokemon_id: 40,
        type_id: 14,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Litwick - Ghost
      {
        pokemon_id: 40,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Litwick - Fire
      {
        pokemon_id: 40,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Litwick - Dark
      {
        pokemon_id: 40,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Litwick - Water
      {
        pokemon_id: 40,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Litwick - Ground
      {
        pokemon_id: 40,
        type_id: 14,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Litwick - Ghost
      {
        pokemon_id: 40,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Litwick - Rock

      {
        pokemon_id: 41,
        type_id: 14,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lampent - Ghost
      {
        pokemon_id: 41,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lampent - Fire
      {
        pokemon_id: 41,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lampent - Dark
      {
        pokemon_id: 41,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lampent - Water
      {
        pokemon_id: 41,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lampent - Ground
      {
        pokemon_id: 41,
        type_id: 14,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lampent - Ghost
      {
        pokemon_id: 41,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Lampent - Rock

      {
        pokemon_id: 42,
        type_id: 14,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Chandelure - Ghost
      {
        pokemon_id: 42,
        type_id: 2,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Chandelure - Fire
      {
        pokemon_id: 42,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Chandelure - Dark
      {
        pokemon_id: 42,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Chandelure - Water
      {
        pokemon_id: 42,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Chandelure - Ground
      {
        pokemon_id: 42,
        type_id: 14,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Chandelure - Ghost
      {
        pokemon_id: 42,
        type_id: 13,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Chandelure - Rock

      {
        pokemon_id: 43,
        type_id: 6,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cubchoo - Ice
      {
        pokemon_id: 43,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cubchoo - Fire
      {
        pokemon_id: 43,
        type_id: 17,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cubchoo - Steel
      {
        pokemon_id: 43,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cubchoo - Rock
      {
        pokemon_id: 43,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Cubchoo - Fighting

      {
        pokemon_id: 44,
        type_id: 6,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beartic - Ice
      {
        pokemon_id: 44,
        type_id: 2,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beartic - Fire
      {
        pokemon_id: 44,
        type_id: 9,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beartic - Rock
      {
        pokemon_id: 44,
        type_id: 7,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beartic - Fighting
      {
        pokemon_id: 44,
        type_id: 17,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Beartic - Steel

      {
        pokemon_id: 45,
        type_id: 1,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pikipek - Normal
      {
        pokemon_id: 45,
        type_id: 10,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pikipek - Flying
      {
        pokemon_id: 45,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pikipek - Ice
      {
        pokemon_id: 45,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pikipek - Rock
      {
        pokemon_id: 45,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Pikipek - Electric

      {
        pokemon_id: 46,
        type_id: 1,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Trumbeak - Normal
      {
        pokemon_id: 46,
        type_id: 10,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Trumbeak - Flying
      {
        pokemon_id: 46,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Trumbeak - Ice
      {
        pokemon_id: 46,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Trumbeak - Rock
      {
        pokemon_id: 46,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Trumbeak - Electric

      {
        pokemon_id: 47,
        type_id: 1,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Toucannon - Normal
      {
        pokemon_id: 47,
        type_id: 10,
        is_weakness: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Toucannon - Flying
      {
        pokemon_id: 47,
        type_id: 6,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Toucannon - Ice
      {
        pokemon_id: 47,
        type_id: 12,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Toucannon - Rock
      {
        pokemon_id: 47,
        type_id: 11,
        is_weakness: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      }, // Toucannon - Electric
    ]);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("PokemonTypes", null, {});
  },
};
