// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawUser _$RawUserFromJson(Map<String, dynamic> json) => RawUser(
      id: (json['id'] as num).toInt(),
      role: json['role'] as String,
      region_id: (json['region_id'] as num).toInt(),
      token: json['token'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$RawUserToJson(RawUser instance) => <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'region_id': instance.region_id,
      'token': instance.token,
      'name': instance.name,
      'email': instance.email,
    };
