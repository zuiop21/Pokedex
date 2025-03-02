import 'package:frontend/data/dataproviders/auth_service.dart';
import 'package:frontend/data/models/user.dart';

class AuthRepository {
  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();
  final AuthService _authService;

  Future<User> login(String email, String password) async {
    final user = await _authService.login(email, password);

    return User.fromJson(user);
  }

  Future<User> register(String email, String password) async {
    final user = await _authService.register(email, password);

    return User.fromJson(user);
  }
}
