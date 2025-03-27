import 'package:collection/collection.dart';
import 'package:frontend/data/dataproviders/pokemon_service.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/data/models/raw/raw_favourite.dart';

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

  Future<RawFavourite> addFavouritePokemon(String token, int pokemonId) async {
    try {
      final rawFavourite =
          await _pokemonService.createFavourite(token, pokemonId);

      return rawFavourite;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFavouritePokemon(String token, int pokemonId) async {
    try {
      await _pokemonService.deleteFavourite(token, pokemonId);
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
      final rawTypeList = await _pokemonService.fetchRawTypes();

      final typeList = [
        for (var type in rawTypeList)
          Type.fromRaw(
            type,
          )
      ];

      final allTypesOption = Type(
        id: 0,
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
      final rawFavouriteList = await _pokemonService.fetchRawFavourites(token);

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

      final processedPokemons = [
        for (var pokemon in pokemonsWithEvo)
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
