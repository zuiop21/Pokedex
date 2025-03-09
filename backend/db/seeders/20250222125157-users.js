"use strict";
const bcrypt = require("bcrypt");
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("Users", [
      {
        email: "admin@example.com",
        password: bcrypt.hashSync("admin", 10),
        role: "admin",
        region_id: 1,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "user@example.com",
        password: bcrypt.hashSync("user", 10),
        role: "user",
        region_id: 1,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("Users", null, {});
  },
};
