import 'package:frontend/data/dataproviders/auth_service.dart';
import 'package:frontend/data/models/user.dart';

class AuthRepository {
  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();
  final AuthService _authService;

  Future<User> login(String email, String password) async {
    try {
      final userJson = await _authService.login(email, password);
      final user = User.fromJson(userJson);
      return user;
    } catch (e) {
      throw Exception("Incorrect JSON format recieved");
    }
  }

  Future<User> register(String email, String password) async {
    try {
      final userJson = await _authService.register(email, password);
      final user = User.fromJson(userJson);
      return user;
    } catch (e) {
      throw Exception("Incorrect JSON format recieved");
    }
  }
}
