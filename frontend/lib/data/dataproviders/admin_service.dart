import 'dart:convert';
import 'dart:io';
import 'package:frontend/api_config.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/data/models/raw/raw_evolution.dart';
import 'package:frontend/data/models/raw/raw_pokemon.dart';
import 'package:frontend/data/models/raw/raw_region.dart';
import 'package:frontend/data/models/raw/raw_type.dart';
import 'package:frontend/data/models/raw/raw_user.dart';
import 'package:http/http.dart' as http;

class AdminService {
  static final String _baseUrl = ApiConfig.baseUrl;
  final http.Client httpClient;

  AdminService({http.Client? client}) : httpClient = client ?? http.Client();

  Future<RawPokemon> uploadPokemon(
      String token, File img, Pokemon pokemon) async {
    try {
      final uri = Uri.parse('$_baseUrl/pokemons');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['name'] = pokemon.name
        ..fields['level'] = pokemon.level.toString()
        ..fields['gender'] = pokemon.gender.toString()
        ..fields['region_id'] = pokemon.regionId.toString()
        ..fields['height'] = pokemon.height.toString()
        ..fields['weight'] = pokemon.weight.toString()
        ..fields['ability'] = pokemon.ability
        ..fields['description'] = pokemon.description
        ..fields['is_base_form'] = pokemon.isBaseForm.toString()
        ..fields['category'] = pokemon.category
        // Encode the types as a string and send as a single field
        ..fields['types'] =
            jsonEncode(pokemon.types.map((e) => e.toJson()).toList())
        ..files.add(await http.MultipartFile.fromPath('image', img.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonData.containsKey("data")) {
          return RawPokemon.fromJson(jsonData["data"]);
        } else {
          throw Exception("Missing data");
        }
      } else {
        String errorMessage = jsonData['message'] ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Pokémon upload failed: ${e.toString()}');
    }
  }

  Future<RawType> uploadType(String token, File img, File imgOutline,
      String name, String color) async {
    try {
      final uri = Uri.parse('$_baseUrl/types');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('image', img.path))
        ..files.add(await http.MultipartFile.fromPath(
            'imageUrlOutline', imgOutline.path))
        ..fields['name'] = name.toString()
        ..fields['color'] = color.toString();

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonData.containsKey("data")) {
          return RawType.fromJson(jsonData["data"]);
        } else {
          throw Exception("Missing data");
        }
      } else {
        String errorMessage = jsonData['message'] ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Type upload failed: ${e.toString()}');
    }
  }

  Future<RawRegion> uploadRegion(String token, File img, Region region) async {
    try {
      final uri = Uri.parse('$_baseUrl/regions');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('image', img.path))
        ..fields['name'] = region.name.toString()
        ..fields['difficulty'] = region.difficulty.toString();

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonData.containsKey("data")) {
          return RawRegion.fromJson(jsonData["data"]);
        } else {
          throw Exception("Missing data");
        }
      } else {
        String errorMessage = jsonData['message'] ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Pokémon upload failed: ${e.toString()}');
    }
  }

  Future<T> _postRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic> body, {
    String? authToken,
  }) async {
    final response = await httpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(body),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonData.containsKey("data")) {
        return fromJson(jsonData["data"]);
      } else {
        throw Exception("Missing data");
      }
    } else {
      String errorMessage = jsonData['message'] ?? 'Unknown error';
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> _patchRequest(
    String endpoint,
    Map<String, dynamic> body, {
    String? authToken,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await httpClient.patch(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.containsKey("data")) {
        return jsonData["data"];
      } else {
        throw Exception("Missing data in response.");
      }
    } else {
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      String errorMessage = errorData['message'] ?? 'Unknown error';
      throw Exception('Error: $errorMessage');
    }
  }

  Future<void> _deleteRequest(
    String endpoint, {
    String? authToken,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await httpClient.delete(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
    );

    if (response.statusCode != 204) {
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      String errorMessage = errorData['message'] ?? 'Unknown error';
      throw Exception('Error: $errorMessage');
    }
  }

  Future<List<T>> _getRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String? authToken,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await httpClient.get(
      Uri.parse('$_baseUrl/$endpoint'),
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

  Future<RawEvolution> createEvolution(
      String token, Evolution evolution) async {
    final Map<String, dynamic> body = {
      'pokemon_id': evolution.pokemonId,
      'evolves_to_id': evolution.evolvesToId,
      'condition': evolution.condition,
    };

    return await _postRequest(
      'evolutions',
      RawEvolution.fromJson,
      body,
      authToken: token,
    );
  }

  // Methods to fetch raw versions of the data
  Future<List<RawUser>> fetchRawUsers(String token) =>
      _getRequest('users', RawUser.fromJson, authToken: token);

  // Methods to update
  Future<RawUser> updateUserById(
    String token,
    int userId, {
    String? role,
    bool? isLocked,
  }) async {
    final Map<String, dynamic> body = {
      if (role != null) 'role': role,
      if (isLocked != null) 'is_locked': isLocked,
    };

    if (body.isEmpty) {
      throw Exception('No data provided for update.');
    }

    return RawUser.fromJson(await _patchRequest(
      "users/$userId",
      body,
      authToken: token,
    ));
  }

  Future<RawType> updateTypeById(
    String token,
    int typeId,
    String name, {
    String? color,
  }) async {
    final Map<String, dynamic> body = {
      if (color != null) 'color': color,
      'name': name,
    };

    if (body.isEmpty) {
      throw Exception('No data provided for update.');
    }

    return RawType.fromJson(await _patchRequest(
      "types/$typeId",
      body,
      authToken: token,
    ));
  }

  Future<RawRegion> updateRegionById(
    String token,
    Region region,
  ) async {
    final Map<String, dynamic> body = {
      "name": region.name,
      "difficulty": region.difficulty,
    };

    if (body.isEmpty) {
      throw Exception('No data provided for update.');
    }

    return RawRegion.fromJson(await _patchRequest(
      "regions/${region.id}",
      body,
      authToken: token,
    ));
  }

  Future<void> deleteTypeById(String token, int typeId) async {
    await _deleteRequest(
      "types/$typeId",
      authToken: token,
    );
  }

  Future<void> deletePokemonById(String token, int pokemonId) async {
    await _deleteRequest(
      "pokemons/$pokemonId",
      authToken: token,
    );
  }

  Future<void> deleteRegionById(String token, int regionId) async {
    await _deleteRequest(
      "regions/$regionId",
      authToken: token,
    );
  }
}
