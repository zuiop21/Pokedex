// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      region_id: (json['region_id'] as num).toInt(),
      role: json['role'] as String,
      id: (json['id'] as num).toInt(),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'region_id': instance.region_id,
      'token': instance.token,
    };
