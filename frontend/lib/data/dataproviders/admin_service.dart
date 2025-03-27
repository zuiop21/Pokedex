import 'dart:convert';
import 'package:frontend/api_config.dart';
import 'package:frontend/data/models/raw/raw_type.dart';
import 'package:frontend/data/models/raw/raw_user.dart';
import 'package:http/http.dart' as http;

class AdminService {
  static final String _baseUrl = ApiConfig.baseUrl;
  final http.Client httpClient;

  AdminService({http.Client? client}) : httpClient = client ?? http.Client();

  Future<RawType> _postRequest(
    String endpoint,
    Map<String, dynamic> body, {
    String? authToken,
  }) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(body),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

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

  Future<RawType> createType(String token, String name, String color) async {
    final Map<String, dynamic> body = {
      'name': name,
      'color': color,
      "imgUrl": "",
      "imgUrlOutline": "",
    };

    return await _postRequest('types', body, authToken: token);
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

  Future<void> deleteTypeById(String token, int typeId) async {
    await _deleteRequest(
      "types/$typeId",
      authToken: token,
    );
  }
}
