const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");
const Pokemon = require("../db/models/pokemon");
const PokemonType = require("../db/models/pokemontype");
const Type = require("../db/models/type");
const sequelize = require("../config/database");

const createPokemon = catchAsync(async (req, res, next) => {
  const body = req.body;

  // Tranzakció indítása
  const transaction = await sequelize.transaction();

  try {
    // 1. Létrehozod a Pokémon rekordot a tranzakción belül
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
        region: body.region,
      },
      { transaction }
    );

    if (!newPokemon) {
      throw new AppError("Failed to create the Pokémon", 400);
    }

    // 2. Feltételezzük, hogy body.types egy tömb,
    // pl.: [ { name: "Fire", is_weakness: true }, { name: "Water", is_weakness: false } ]
    const typesArray = body.types;

    // 3. A típusok feldolgozása: lekérjük a típus rekordot a típus név alapján
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

    // 4. Létrehozod a kapcsoló rekordokat (PokemonTypes) a tranzakción belül
    await PokemonType.bulkCreate(pokemonTypeData, { transaction });

    // Tranzakció commit
    await transaction.commit();

    // 5. Lekérjük a létrehozott Pokémon-t a kapcsolódó típusokkal együtt
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

    // toJSON meghívása, hogy a válaszban ne szerepeljenek a nem kívánt mezők
    return res.status(201).json({
      status: "Success",
      data: createdPokemon.toJSON(),
    });
  } catch (error) {
    await transaction.rollback();
    return next(error);
  }
});

const readPokemon = catchAsync(async (req, res, next) => {
  const { name } = req.params;
  const pokemons = await Pokemon.findOne({
    where: { name: name },
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

  return res.json({
    status: "Success",
    data: pokemons.toJSON(),
  });
});

//TODO update types
const updatePokemon = catchAsync(async (req, res, next) => {
  const { name } = req.params;
  const body = req.body;

  const pokemon = await Pokemon.findOne({
    where: { name: name },
  });

  if (!pokemon) {
    return next(new AppError(`Pokemon with name ${name} not found`, 404));
  }

    (pokemon.level = body.level),
    (pokemon.gender = body.gender),
    (pokemon.height = body.height),
    (pokemon.weight = body.weight),
    (pokemon.name = body.name),
    (pokemon.ability = body.ability),
    (pokemon.category = body.category),
    (pokemon.description = body.description),
    (pokemon.region = body.region),
    await pokemon.save();

  return res.json({
    status: "Success",
    data: pokemon.toJSON(),
  });
});

const deletePokemon = catchAsync(async (req, res, next) => {
  const { name } = req.params;
  const pokemon = await Pokemon.findOne({
    where: { name: name },
  });

  if (!pokemon) {
    return next(new AppError(`Pokemon with name ${name} not found`, 404));
  }

  await pokemon.destroy();

  return res.json({
    status: "Success",
    message: "Pokemon deleted successfully",
  });
});

module.exports = { createPokemon, readPokemon, updatePokemon, deletePokemon };
