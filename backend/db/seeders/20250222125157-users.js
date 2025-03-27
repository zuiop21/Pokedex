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
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "admin@ex.com",
        password: bcrypt.hashSync("admin", 10),
        role: "admin",
        region_id: 1,
        name: "Adminiszter Elek",
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "admin@example.com",
        password: bcrypt.hashSync("admin", 10),
        role: "admin",
        region_id: 1,
        name: "Ügy Elek",
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "user@ex.com",
        password: bcrypt.hashSync("user", 10),
        role: "user",
        region_id: 1,
        name: "User Guszter",
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "test@ex.com",
        password: bcrypt.hashSync("test", 10),
        role: "user",
        region_id: 1,
        name: "Teszt Elek",
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "vicc@ex.com",
        password: bcrypt.hashSync("vicc", 10),
        role: "user",
        region_id: 1,
        name: "Vicc Elek",
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "edz@ex.com",
        password: bcrypt.hashSync("edz", 10),
        role: "user",
        region_id: 1,
        name: "Edz Elek",
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        email: "remek@ex.com",
        password: bcrypt.hashSync("remek", 10),
        role: "user",
        region_id: 1,
        name: "Remek Elek",
        is_locked: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("Users", null, {});
  },
};
