import 'dart:convert';
import 'package:frontend/api_config.dart';
import 'package:frontend/data/models/raw/raw_user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final String _baseUrl = ApiConfig.baseUrl;
  final http.Client httpClient;

  AuthService({http.Client? client}) : httpClient = client ?? http.Client();

  Future<RawUser> _postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonData.containsKey("data")) {
        return RawUser.fromJson(jsonData["data"]);
      } else {
        throw Exception("Missing data");
      }
    } else {
      String errorMessage = jsonData['message'] ?? 'Unknown error';
      throw Exception(errorMessage);
    }
  }

  Future<RawUser> login(String email, String password) =>
      _postRequest("login", {"email": email, "password": password});

  Future<RawUser> register(String email, String password) =>
      _postRequest("register", {
        "email": email,
        "password": password,
        "confirmPassword": password,
        "role": "user"
      });
}
