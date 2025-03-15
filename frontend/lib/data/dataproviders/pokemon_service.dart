import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/api_config.dart';
import 'package:frontend/data/models/raw/raw_evolution.dart';
import 'package:frontend/data/models/raw/raw_favourite.dart';
import 'package:frontend/data/models/raw/raw_pokemon.dart';
import 'package:frontend/data/models/raw/raw_pokemon_type.dart';
import 'package:frontend/data/models/raw/raw_region.dart';
import 'package:frontend/data/models/raw/raw_type.dart';

class PokemonService {
  final http.Client httpClient;

  PokemonService({http.Client? client}) : httpClient = client ?? http.Client();

  Future<List<T>> _fetchData<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson,
      {String? authToken}) async {
    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };
    final response = await httpClient.get(
      Uri.parse(
        '${ApiConfig.baseUrl}/$endpoint',
      ),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status: ${response.statusCode}. Response: ${response.body}');
    }

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'Fail') {
      throw Exception(jsonData['message'] ?? 'Unknown error occurred');
    }

    if (jsonData.containsKey('data')) {
      return (jsonData['data'] as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<List<RawEvolution>> fetchRawEvolutions() =>
      _fetchData('evolutions', RawEvolution.fromJson);

  Future<List<RawFavourite>> fetchRawFavourites(String token) =>
      _fetchData('favourites', RawFavourite.fromJson, authToken: token);

  Future<List<RawPokemon>> fetchRawPokemons() =>
      _fetchData('pokemons', RawPokemon.fromJson);

  Future<List<RawPokemonType>> fetchRawPokemonTypes() =>
      _fetchData('pokemontypes', RawPokemonType.fromJson);

  Future<List<RawRegion>> fetchRawRegions() =>
      _fetchData('regions', RawRegion.fromJson);

  Future<List<RawType>> fetchRawTypes() =>
      _fetchData('types', RawType.fromJson);
}
