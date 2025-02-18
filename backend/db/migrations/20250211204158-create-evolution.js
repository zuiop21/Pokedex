"use strict";
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable("Evolutions", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      pokemon_id: {
        allowNull: false,
        type: Sequelize.INTEGER,
        references: {
          model: "Pokemons",
          key: "id",
        },
        onUpdate: "CASCADE",
        onDelete: "CASCADE",
      },
      evolves_to_id: {
        allowNull: true, //Some pokemons might be fully evolved, therefore this value can be null
        type: Sequelize.INTEGER,
        references: {
          model: "Pokemons",
          key: "id",
        },
        onUpdate: "CASCADE",
        onDelete: "CASCADE",
      },
      condition: {
        allowNull: true, //Some pokemons might be fully evolved, therefore this value can be null
        type: Sequelize.STRING,
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      deletedAt: {
        type: Sequelize.DATE,
      },
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable("Evolutions");
  },
};
