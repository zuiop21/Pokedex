// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawRegion _$RawRegionFromJson(Map<String, dynamic> json) => RawRegion(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      difficulty: (json['difficulty'] as num).toInt(),
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$RawRegionToJson(RawRegion instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'difficulty': instance.difficulty,
      'imgUrl': instance.imgUrl,
    };
