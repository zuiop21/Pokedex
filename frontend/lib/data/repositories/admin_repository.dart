import 'package:frontend/data/dataproviders/admin_service.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:frontend/data/models/processed/type.dart';

class AdminRepository {
  AdminRepository({AdminService? adminService})
      : _adminService = adminService ?? AdminService();

  final AdminService _adminService;

  Future<List<User>> getAllUsers(String token) async {
    try {
      final rawUserList = await _adminService.fetchRawUsers(token);

      final userList = [for (var user in rawUserList) User.fromRaw(user)];

      return userList;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> updateUserById(
    String token,
    int userId, {
    String? role,
    bool? isLocked,
  }) async {
    try {
      final rawUser = await _adminService.updateUserById(
        token,
        userId,
        role: role,
        isLocked: isLocked,
      );
      final user = User.fromRaw(rawUser);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<Type> updateTypeById(
    String token,
    int typeId,
    String name, {
    String? color,
  }) async {
    final rawType = await _adminService.updateTypeById(
      token,
      typeId,
      name,
      color: color,
    );
    return Type.fromRaw(rawType);
  }

  Future<Type> createType(
    String token,
    String name,
    String color,
  ) async {
    final rawType = await _adminService.createType(
      token,
      name,
      color,
    );
    return Type.fromRaw(rawType);
  }

  Future<void> deleteTypeById(
    String token,
    int typeId,
  ) async {
    await _adminService.deleteTypeById(
      token,
      typeId,
    );
  }
}
