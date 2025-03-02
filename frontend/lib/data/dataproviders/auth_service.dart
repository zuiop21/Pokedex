import 'dart:convert';

import 'package:frontend/api_config.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final String _baseUrl = ApiConfig.baseUrl;

  final http.Client httpClient;

  AuthService({http.Client? client}) : httpClient = client ?? http.Client();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey("data")) {
        return jsonData["data"];
      } else {
        throw Exception("Invalid response format: ${response.body}");
      }
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
        "confirmPassword": password,
        "role": "user"
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey("data")) {
        return jsonData["data"];
      } else {
        throw Exception("Invalid response format: ${response.body}");
      }
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
