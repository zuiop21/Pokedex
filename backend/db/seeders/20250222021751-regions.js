"use strict";
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("Regions", [
      {
        name: "Kanto",
        difficulty: 1,
        imgUrl: "http://localhost:3000/assets/regions/Kanto.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Johto",
        difficulty: 2,
        imgUrl: "http://localhost:3000/assets/regions/Johto.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Hoenn",
        difficulty: 3,
        imgUrl: "http://localhost:3000/assets/regions/Hoenn.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Sinnoh",
        difficulty: 4,
        imgUrl: "http://localhost:3000/assets/regions/Sinnoh.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Unova",
        difficulty: 5,
        imgUrl: "http://localhost:3000/assets/regions/Unova.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Kalos",
        difficulty: 6,
        imgUrl: "http://localhost:3000/assets/regions/Kalos.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Alola",
        difficulty: 7,
        imgUrl: "http://localhost:3000/assets/regions/Alola.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Galar",
        difficulty: 8,
        imgUrl: "http://localhost:3000/assets/regions/Galar.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("Regions", null, {});
  },
};
