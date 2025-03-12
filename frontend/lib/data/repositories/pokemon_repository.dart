import 'package:frontend/data/dataproviders/pokemon_service.dart';
import 'package:frontend/data/models/evolution.dart';
import 'package:frontend/data/models/pokemon.dart';
import 'package:frontend/data/models/region.dart';
import 'package:frontend/data/models/type.dart';

class PokemonRepository {
  PokemonRepository({PokemonService? pokemonService})
      : _pokemonService = pokemonService ?? PokemonService();

  final PokemonService _pokemonService;

  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final pokemonListJson = await _pokemonService.fetchData("pokemons");
      return pokemonListJson
          .map<Pokemon>((json) => Pokemon.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Type>> getAllTypes() async {
    try {
      final typeListJson = await _pokemonService.fetchData("types");
      return typeListJson.map<Type>((json) => Type.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Region>> getAllRegions() async {
    try {
      final regionListJson = await _pokemonService.fetchData("regions");
      return regionListJson
          .map<Region>((json) => Region.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Evolution>> getAllEvolutions() async {
    try {
      final evolutionListJson = await _pokemonService.fetchData("evolutions");
      return evolutionListJson
          .map<Evolution>((json) => Evolution.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
