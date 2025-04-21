"use strict";
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable("Pokemons", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      name: {
        allowNull: false,
        type: Sequelize.STRING,
        unique: true, //There should be only one "Pikachu"
      },
      height: {
        allowNull: false,
        type: Sequelize.DOUBLE,
      },
      weight: {
        allowNull: false,
        type: Sequelize.DOUBLE,
      },
      ability: {
        allowNull: false,
        type: Sequelize.STRING,
      },
      category: {
        allowNull: false,
        type: Sequelize.STRING,
      },
      description: {
        allowNull: false,
        type: Sequelize.STRING,
      },
      gender: {
        allowNull: false,
        type: Sequelize.DOUBLE,
      },
      level: {
        allowNull: false,
        type: Sequelize.INTEGER,
      },
      is_base_form: {
        allowNull: false,
        type: Sequelize.BOOLEAN,
      },
      region_id: {
        allowNull: true,
        type: Sequelize.INTEGER,
        references: {
          model: "Regions",
          key: "id",
        },
        onUpdate: "CASCADE",
        onDelete: "SET NULL",
      },
      imgUrl: {
        allowNull: false,
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
    await queryInterface.dropTable("Pokemons");
  },
};
