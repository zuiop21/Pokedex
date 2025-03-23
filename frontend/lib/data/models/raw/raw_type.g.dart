// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawType _$RawTypeFromJson(Map<String, dynamic> json) => RawType(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String,
      imgUrl: json['imgUrl'] as String,
      imgUrlOutline: json['imgUrlOutline'] as String,
      is_weakness: $enumDecode(_$WeaknessStatusEnumMap, json['is_weakness']),
    );

Map<String, dynamic> _$RawTypeToJson(RawType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'imgUrl': instance.imgUrl,
      'imgUrlOutline': instance.imgUrlOutline,
      'is_weakness': _$WeaknessStatusEnumMap[instance.is_weakness]!,
    };

const _$WeaknessStatusEnumMap = {
  WeaknessStatus.yes: 'yes',
  WeaknessStatus.no: 'no',
  WeaknessStatus.both: 'both',
};
