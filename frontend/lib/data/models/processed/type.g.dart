// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      isWeakness: $enumDecode(_$WeaknessStatusEnumMap, json['is_weakness']),
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String,
      imgUrl: json['imgUrl'] as String,
      imgUrlOutline: json['imgUrlOutline'] as String,
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'is_weakness': _$WeaknessStatusEnumMap[instance.isWeakness]!,
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'imgUrl': instance.imgUrl,
      'imgUrlOutline': instance.imgUrlOutline,
    };

const _$WeaknessStatusEnumMap = {
  WeaknessStatus.yes: 'yes',
  WeaknessStatus.no: 'no',
  WeaknessStatus.both: 'both',
};
