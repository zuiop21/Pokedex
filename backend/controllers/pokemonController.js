const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");
const Pokemon = require("../db/models/pokemon");
const PokemonType = require("../db/models/pokemontype");
const Type = require("../db/models/type");
const Evolution = require("../db/models/evolution");
const sequelize = require("../config/database");

/**
 * @file pokemonController.js
 * @description Controller for handling Pokémon-related operations.
 */

/**
 * @function createPokemon
 * @description Creates a new Pokémon and associates it with its types.
 * @param {Object} req - Express request object containing Pokémon data in the body.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the created Pokémon data.
 */
const createPokemon = catchAsync(async (req, res, next) => {
  const body = req.body;

  // Transaction creation
  const transaction = await sequelize.transaction();

  try {
    // Create a new Pokémon in the transaction
    const newPokemon = await Pokemon.create(
      {
        level: body.level,
        gender: body.gender,
        height: body.height,
        weight: body.weight,
        name: body.name,
        ability: body.ability,
        category: body.category,
        description: body.description,
        is_base_form: body.is_base_form,
        imgUrl: body.imgUrl,
        region_id: body.region_id,
      },
      { transaction }
    );

    // If the Pokémon creation fails, throw an error
    if (!newPokemon) {
      throw new AppError("Failed to create the Pokémon", 400);
    }

    //Assume that body.types is an array,
    //Like: [ { name: "Fire", is_weakness: true }, { name: "Water", is_weakness: false } ]
    const typesArray = body.types;

    //Process the types: get the type record based on the type name
    const pokemonTypeData = await Promise.all(
      typesArray.map(async (typeObj) => {
        const typeRecord = await Type.findOne({
          where: { name: typeObj.name },
          transaction,
        });

        if (!typeRecord) {
          throw new AppError(`Type ${typeObj.name} not found`, 404);
        }

        return {
          pokemon_id: newPokemon.id,
          type_id: typeRecord.id,
          is_weakness: typeObj.is_weakness,
        };
      })
    );

    //Create the association records (PokemonTypes) within the transaction with bulkCreate
    //BulkCreate is used to create multiple records at once
    await PokemonType.bulkCreate(pokemonTypeData, { transaction });

    // Transaction commit
    await transaction.commit();

    // Find the created Pokémon with its types
    const createdPokemon = await Pokemon.findOne({
      where: { id: newPokemon.id },
      include: [
        {
          model: Type,
          as: "types",
          attributes: ["name"],
          through: {
            attributes: ["is_weakness"],
          },
        },
      ],
    });

    // Return the response
    return res.status(201).json({
      status: "Success",
      data: createdPokemon.toJSON(),
    });
  } catch (error) {
    // If an error occurs, rollback the transaction
    await transaction.rollback();
    return next(error);
  }
});

/**
 * @function readPokemon
 * @description Retrieves a Pokémon by its ID along with its associated types.
 * @param {Object} req - Express request object containing Pokémon name in the params.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the Pokémon data.
 */
const readPokemon = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  // Find the Pokémon by its name with its associated types
  const pokemon = await Pokemon.findByPk(id, {
    include: [
      {
        model: Type,
        as: "types",
        attributes: ["name"],
        through: {
          attributes: ["is_weakness"],
        },
      },
    ],
  });

  // If the Pokémon is not found, throw an error
  if (!pokemon) {
    return next(new AppError(`Pokemon with id ${id} not found`, 404));
  }

  // Return the response
  return res.json({
    status: "Success",
    data: pokemon.toJSON(),
  });
});

/**
 * @function readAllPokemon
 * @description Retrieves all the Pokémons along with their associated types.
 * @param {Object} req - Express request object containing Pokémon name in the params.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the Pokémon data.
 */
const readAllPokemon = catchAsync(async (req, res, next) => {
  // Find all the pokémons
  const pokemons = await Pokemon.findAll();

  // If no Pokémon found, throw an error
  if (!pokemons) {
    return next(new AppError(`There aren't any pokémons`, 404));
  }

  // Convert each Pokémon instance to a plain object and flatten the evolution field
  const pokemonsJSON = pokemons.map((pokemon) => {
    const plainPokemon = pokemon.toJSON();

    if (plainPokemon.evolution) {
      plainPokemon.evolves_to_id = plainPokemon.evolution.evolves_to_id;
      delete plainPokemon.evolution;
    }

    return plainPokemon;
  });

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: pokemonsJSON,
  });
});

/**
 * @function updatePokemon
 * @description Updates an existing Pokémon's details.
 * @param {Object} req - Express request object containing Pokémon name in the params and updated data in the body.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response with the updated Pokémon data.
 */
const updatePokemon = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const body = req.body;

  // Find the Pokémon by its name
  const pokemon = await Pokemon.findByPk(id);

  // If the Pokémon is not found, throw an error
  if (!pokemon) {
    return next(
      new AppError(`Pokemon with name ${pokemon.name} not found`, 404)
    );
  }

  // Update the Pokémon's details
  (pokemon.level = body.level),
    (pokemon.gender = body.gender),
    (pokemon.height = body.height),
    (pokemon.weight = body.weight),
    (pokemon.name = body.name),
    (pokemon.ability = body.ability),
    (pokemon.category = body.category),
    (pokemon.description = body.description),
    (pokemon.is_base_form = body.is_base_form),
    (pokemon.region_id = body.region_id),
    (pokemon.imgUrl = body.imgUrl);
  await pokemon.save();

  // Return the response
  return res.status(200).json({
    status: "Success",
    data: pokemon.toJSON(),
  });
});

/**
 * @function deletePokemon
 * @description Deletes a Pokémon by its name.
 * @param {Object} req - Express request object containing Pokémon name in the params.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>} - Returns a JSON response confirming the deletion.
 */
const deletePokemon = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  // Find the Pokémon by its name
  const pokemon = await Pokemon.findByPk(id);

  // If the Pokémon is not found, throw an error
  if (!pokemon) {
    return next(new AppError(`Pokemon with id ${id} not found`, 404));
  }

  // Delete the Pokémon
  await pokemon.destroy();

  // Return the response
  return res.status(204).json({
    status: "Success",
    message: `${pokemon.name} deleted successfully`,
  });
});

module.exports = {
  createPokemon,
  readPokemon,
  readAllPokemon,
  updatePokemon,
  deletePokemon,
};
