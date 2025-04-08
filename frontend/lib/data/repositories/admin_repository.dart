import 'dart:io';

import 'package:frontend/data/dataproviders/admin_service.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:frontend/data/models/processed/type.dart';

class AdminRepository {
  AdminRepository({AdminService? adminService})
      : _adminService = adminService ?? AdminService();

  final AdminService _adminService;

  Future<Pokemon> uploadPokemon(
    String token,
    File img,
    Pokemon pokemon,
  ) async {
    try {
      final rawPokemon = await _adminService.uploadPokemon(token, img, pokemon);
      final processedPokemon = Pokemon.fromRaw(rawPokemon);
      return processedPokemon;
    } catch (e) {
      rethrow;
    }
  }

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

  Future<Evolution> createEvolution(
    String token,
    Evolution evolution,
  ) async {
    final rawEvolution = await _adminService.createEvolution(
      token,
      evolution,
    );
    return Evolution.fromRaw(rawEvolution);
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

  Future<void> deletePokemonById(
    String token,
    int pokemonId,
  ) async {
    await _adminService.deletePokemonById(
      token,
      pokemonId,
    );
  }
}
