const catchAsync = require("../utils/catchAsync");
const Evolution = require("../db/models/evolution");
const Pokemon = require("../db/models/pokemon");
const AppError = require("../utils/appError");

//TODO if the evolves_to_id is null, then the condition should be null as well
//TODO put the validation logic into model
//TODO körkörös függöség 1-2, 2-3, 3-1 -> is_base boolean

const createEvolution = catchAsync(async (req, res, next) => {
  const { pokemon_id, evolves_to_id, condition } = req.body;

  // Check that a Pokémon does not evolve into itself
  if (pokemon_id === evolves_to_id) {
    return next(new AppError("A Pokémon cannot evolve into itself", 400));
  }

  // Ellenőrizzük az eredeti Pokémon létezését
  const pokemon = await Pokemon.findByPk(pokemon_id);
  if (!pokemon) {
    return next(new AppError(`Pokémon with id ${pokemon_id} not found`, 404));
  }

  let evolvedPokemon = null;
  // Csak akkor ellenőrizzük a fejlődött formát, ha evolves_to_id meg van adva
  if (evolves_to_id !== null && evolves_to_id !== undefined) {
    evolvedPokemon = await Pokemon.findByPk(evolves_to_id);
    if (!evolvedPokemon) {
      return next(
        new AppError(`Pokémon with id ${evolves_to_id} not found`, 404)
      );
    }
  }

  // 0. Ellenőrizzük, hogy a forrás Pokémon (pokemon_id) még nem rendelkezik evolúciós kapcsolattal.
  // Ez akadályozza, hogy egy Pokémonnak több evolúciója legyen, például 2-4, ha már létezik 2-3.
  const existingSourceEvolution = await Evolution.findOne({
    where: { pokemon_id },
  });
  if (existingSourceEvolution) {
    return next(
      new AppError(`Pokémon ${pokemon.name} already has an evolution`, 400)
    );
  }

    // 1. Check that no other Pokémon already evolves into the same target.
  // This ensures that more than one Pokémon cannot evolve into the same Pokémon.
  if (evolves_to_id !== null && evolves_to_id !== undefined) {
    const existingTargetEvolution = await Evolution.findOne({
      where: { evolves_to_id },
    });
    if (existingTargetEvolution) {
      return next(new AppError(`Pokémon ${evolvedPokemon.name} is already the evolved form for another Pokémon`, 400));
    }
  }

  // 2. Ellenőrizzük, hogy ne lehessen fordított evolúció:
  // Ha már létezik olyan kapcsolat, ahol a forrás és a cél cserélve van (pl. 1-2 létezik, ezért 2-1 nem engedélyezett)
  if (evolves_to_id !== null && evolves_to_id !== undefined) {
    const existingReverseEvolution = await Evolution.findOne({
      where: {
        pokemon_id: evolves_to_id,
        evolves_to_id: pokemon_id,
      },
    });
    if (existingReverseEvolution) {
      return next(new AppError(`Reverse evolution is not allowed`, 400));
    }
  }

  // Létrehozzuk az evolution rekordot
  const newEvolution = await Evolution.create({
    pokemon_id,
    evolves_to_id,
    condition,
  });

  if (!newEvolution) {
    return next(new AppError("Failed to create the evolution", 400));
  }

  const response = {
    id: newEvolution.id,
    pokemon: pokemon.name,
    evolves_to: evolvedPokemon ? evolvedPokemon.name : null,
    condition: newEvolution.condition,
  };

  return res.status(201).json({
    status: "Success",
    data: response,
  });
});

const readEvolution = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  const evolution = await Evolution.findByPk(id, {
    attributes: ["condition"],
    include: [
      {
        model: Pokemon,
        as: "pokemon",
        attributes: ["name"],
      },
      {
        model: Pokemon,
        as: "evolves_to",
        attributes: ["name"],
      },
    ],
  });

  if (!evolution) {
    return next(new AppError(`Evolution with id ${id} not found`, 404));
  }

  return res.json({
    status: "Success",
    data: evolution.toJSON(),
  });
});

const deleteEvolution = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const evolution = await Evolution.findByPk(id);

  if (!evolution) {
    return next(new AppError(`Evolution with id ${id} not found`, 404));
  }

  await evolution.destroy();

  return res.json({
    status: "Success",
    message: `Evolution with id ${id} deleted successfully`,
  });
});

module.exports = { createEvolution, readEvolution, deleteEvolution };
