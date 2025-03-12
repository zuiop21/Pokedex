// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      difficulty: (json['difficulty'] as num).toInt(),
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'difficulty': instance.difficulty,
      'imgUrl': instance.imgUrl,
    };
