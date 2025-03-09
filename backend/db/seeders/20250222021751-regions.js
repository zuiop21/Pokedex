"use strict";
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("Regions", [
      {
        name: "Kanto",
        generation: 1,
        imgUrl: "http://localhost:3000/assets/regions/region1.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Johto",
        generation: 2,
        imgUrl: "http://localhost:3000/assets/regions/region2.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Hoenn",
        generation: 3,
        imgUrl: "http://localhost:3000/assets/regions/region3.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Sinnoh",
        generation: 4,
        imgUrl: "http://localhost:3000/assets/regions/region4.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Unova",
        generation: 5,
        imgUrl: "http://localhost:3000/assets/regions/region5.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Kalos",
        generation: 6,
        imgUrl: "http://localhost:3000/assets/regions/region6.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Alola",
        generation: 7,
        imgUrl: "http://localhost:3000/assets/regions/region7.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Galar",
        generation: 8,
        imgUrl: "http://localhost:3000/assets/regions/region8.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("Regions", null, {});
  },
};
