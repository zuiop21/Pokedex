import 'package:json_annotation/json_annotation.dart';

part 'raw_user.g.dart';

//Class to represent the raw data of a user
@JsonSerializable()
class RawUser {
  final int id;
  final String role;
  final int region_id;
  final String token;
  final String name;
  final String email;

  RawUser({
    required this.id,
    required this.role,
    required this.region_id,
    required this.token,
    required this.name,
    required this.email,
  });

  factory RawUser.fromJson(Map<String, dynamic> json) =>
      _$RawUserFromJson(json);

  Map<String, dynamic> toJson() => _$RawUserToJson(this);
}
