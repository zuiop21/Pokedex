"use strict";
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("Regions", [
      {
        name: "Kanto",
        difficulty: 1,
        imgUrl: "http://localhost:3000/assets/regions/region1.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Johto",
        difficulty: 2,
        imgUrl: "http://localhost:3000/assets/regions/region2.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Hoenn",
        difficulty: 3,
        imgUrl: "http://localhost:3000/assets/regions/region3.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Sinnoh",
        difficulty: 4,
        imgUrl: "http://localhost:3000/assets/regions/region4.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Unova",
        difficulty: 5,
        imgUrl: "http://localhost:3000/assets/regions/region5.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Kalos",
        difficulty: 6,
        imgUrl: "http://localhost:3000/assets/regions/region6.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Alola",
        difficulty: 7,
        imgUrl: "http://localhost:3000/assets/regions/region7.png",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "Galar",
        difficulty: 8,
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
