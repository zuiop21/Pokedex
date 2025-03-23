"use strict";
const bcrypt = require("bcrypt");
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("Users", [
      {
        email: "super@ex.com",
        password: bcrypt.hashSync("super", 10),
        role: "super",
        region_id: 1,
        name: "Szélesjogú Sándor",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "admin@ex.com",
        password: bcrypt.hashSync("admin", 10),
        role: "admin",
        region_id: 1,
        name: "Adminiszter Elek",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "user@ex.com",
        password: bcrypt.hashSync("user", 10),
        role: "user",
        region_id: 1,
        name: "User Guszter",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("Users", null, {});
  },
};
