// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawPokemon _$RawPokemonFromJson(Map<String, dynamic> json) => RawPokemon(
      id: (json['id'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      gender: (json['gender'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      name: json['name'] as String,
      ability: json['ability'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      is_base_form: json['is_base_form'] as bool,
      region_id: (json['region_id'] as num).toInt(),
      types: (json['types'] as List<dynamic>)
          .map((e) => RawType.fromJson(e as Map<String, dynamic>))
          .toList(),
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$RawPokemonToJson(RawPokemon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'name': instance.name,
      'ability': instance.ability,
      'category': instance.category,
      'description': instance.description,
      'is_base_form': instance.is_base_form,
      'region_id': instance.region_id,
      'imgUrl': instance.imgUrl,
      'types': instance.types,
    };
