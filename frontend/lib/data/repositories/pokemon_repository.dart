import 'package:collection/collection.dart';
import 'package:frontend/data/dataproviders/pokemon_service.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/data/models/raw/raw_pokemon_type.dart';

class PokemonRepository {
  PokemonRepository({PokemonService? pokemonService})
      : _pokemonService = pokemonService ?? PokemonService();

  final PokemonService _pokemonService;

  int? _joinPokemonWithEvolution(Pokemon pokemon, List<Evolution> evolutions) {
    return evolutions
        .firstWhereOrNull((e) => e.pokemonId == pokemon.id)
        ?.evolvesToId;
  }

  Future<List<Region>> getAllRegions() async {
    try {
      final rawRegionList = await _pokemonService.fetchRawRegions();

      final regionList = [
        for (var region in rawRegionList) Region.fromRaw(region)
      ];

      return regionList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Evolution>> getAllEvolutions() async {
    try {
      final rawEvolutionList = await _pokemonService.fetchRawEvolutions();

      final evolutionList = [
        for (var evolution in rawEvolutionList) Evolution.fromRaw(evolution)
      ];

      return evolutionList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Type>> getAllTypes() async {
    try {
      final rawPokemonTypeList = await _pokemonService.fetchRawPokemonTypes();
      final rawTypeList = await _pokemonService.fetchRawTypes();

      final typeList = [
        for (var type in rawTypeList)
          Type.fromRaw(type,
              rawPokemonTypeList.firstWhere((rpt) => rpt.type_id == type.id))
      ];

      final allTypesOption = Type(
        id: 0,
        pokemonId: 0,
        name: "All Types",
        color: "0xFF333333",
        imgUrl: "",
        imgUrlOutline: "",
        isWeakness: WeaknessStatus.both,
      );

      final updatedTypes = [allTypesOption, ...typeList];

      return updatedTypes;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Pokemon>> getAllPokemons(String token) async {
    try {
      final rawEvolutionList = await _pokemonService.fetchRawEvolutions();
      final rawPokemonList = await _pokemonService.fetchRawPokemons();
      final rawPokemonTypeList = await _pokemonService.fetchRawPokemonTypes();
      final rawTypeList = await _pokemonService.fetchRawTypes();
      final rawFavouriteList = await _pokemonService.fetchRawFavourites(token);

      final typeList = [
        for (var rpt in rawPokemonTypeList)
          Type.fromRaw(rawTypeList.firstWhere((t) => t.id == rpt.type_id), rpt)
      ];

      final evolutionList = [
        for (var evolution in rawEvolutionList) Evolution.fromRaw(evolution)
      ];

      final pokemonList = [
        for (var pokemon in rawPokemonList) Pokemon.fromRaw(pokemon)
      ];

      final pokemonsWithEvo = [
        for (var pokemon in pokemonList)
          pokemon.copyWith(
            evolvesTo: () => pokemonList.firstWhereOrNull(
              (p) => p.id == _joinPokemonWithEvolution(pokemon, evolutionList),
            ),
          )
      ];

      final typedPokemons = [
        for (var pokemon in pokemonsWithEvo)
          pokemon.copyWith(
              types: typeList.where((t) => t.pokemonId == pokemon.id).toList())
      ];

      final processedPokemons = [
        for (var pokemon in typedPokemons)
          pokemon.copyWith(
            isFavourited:
                rawFavouriteList.any((f) => f.pokemon_id == pokemon.id),
          )
      ];

      return processedPokemons;
    } catch (e) {
      rethrow;
    }
  }
}
