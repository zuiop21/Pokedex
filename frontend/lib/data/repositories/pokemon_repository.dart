import 'package:frontend/data/dataproviders/pokemon_service.dart';
import 'package:frontend/data/models/pokemon.dart';
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
}
