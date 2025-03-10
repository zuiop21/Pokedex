// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      name: json['name'] as String,
      color: json['color'] as String,
      imgUrl: json['imgUrl'] as String,
      imgUrlOutline: json['imgUrlOutline'] as String,
      PokemonTypes:
          PokemonType.fromJson(json['PokemonTypes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'imgUrl': instance.imgUrl,
      'imgUrlOutline': instance.imgUrlOutline,
      'PokemonTypes': instance.PokemonTypes,
    };
