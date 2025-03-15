import 'package:json_annotation/json_annotation.dart';

part 'raw_user.g.dart';

@JsonSerializable()
class RawUser {
  final int id;
  final String role;
  final int region_id;
  final String token;

  const RawUser(
      {required this.region_id,
      required this.role,
      required this.id,
      required this.token});

  factory RawUser.fromJson(Map<String, dynamic> json) =>
      _$RawUserFromJson(json);

  Map<String, dynamic> toJson() => _$RawUserToJson(this);
}
