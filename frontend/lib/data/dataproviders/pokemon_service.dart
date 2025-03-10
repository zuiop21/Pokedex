import 'dart:convert';
import 'package:frontend/api_config.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  static final String _baseUrl = ApiConfig.baseUrl;
  final http.Client httpClient;

  PokemonService({http.Client? client}) : httpClient = client ?? http.Client();

  Future<List<dynamic>> fetchAllPokemons() async {
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/pokemons'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('data')) {
        return jsonData['data'];
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
