"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("Types", [
      {
        name: "Normal",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Fire",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Water",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Electric",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Grass",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Ice",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Fighting",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Poison",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Ground",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Flying",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Psychic",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Bug",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Rock",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Ghost",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Dragon",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Dark",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Steel",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Fairy",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("Types", null, {});
  },
};
