import 'package:frontend/data/dataproviders/pokemon_service.dart';
import 'package:frontend/data/models/pokemon.dart';

class PokemonRepository {
  PokemonRepository({PokemonService? pokemonService})
      : _pokemonService = pokemonService ?? PokemonService();

  final PokemonService _pokemonService;

  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final pokemonListJson = await _pokemonService.fetchAllPokemons();
      return pokemonListJson
          .map<Pokemon>((json) => Pokemon.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
