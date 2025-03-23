import 'package:frontend/data/dataproviders/auth_service.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();
  final AuthService _authService;

  Future<User> login(String email, String password) async {
    try {
      final userJson = await _authService.login(email, password);
      final user = User.fromRaw(userJson);

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', userJson.token);
      } catch (e) {
        throw Exception("SharedPreferences error: $e");
      }

      return user;
    } catch (e) {
      throw Exception("Incorrect JSON format received");
    }
  }

  Future<User> register(String email, String password) async {
    try {
      final userJson = await _authService.register(email, password);
      final user = User.fromRaw(userJson);

      //Save token to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', userJson.token);
      return user;
    } catch (e) {
      throw Exception("Incorrect JSON format recieved");
    }
  }
}
