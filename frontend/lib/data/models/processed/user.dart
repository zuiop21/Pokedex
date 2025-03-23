import 'package:frontend/data/models/raw/raw_user.dart';
import 'package:json_annotation/json_annotation.dart';

//Class to represent the raw data of a user
@JsonSerializable()
class User {
  final int id;
  final String role;
  final int regionId;
  final String name;
  final String email;

  User(
      {required this.id,
      required this.role,
      required this.regionId,
      required this.name,
      required this.email});

  factory User.fromRaw(RawUser rawUser) {
    return User(
        id: rawUser.id,
        role: rawUser.role,
        regionId: rawUser.region_id,
        name: rawUser.name,
        email: rawUser.email);
  }
}
