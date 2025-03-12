// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
      id: (json['id'] as num).toInt(),
      types: (json['types'] as List<dynamic>)
          .map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      imgUrl: json['imgUrl'] as String,
      evolves_to_id: (json['evolves_to_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
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
      'evolves_to_id': instance.evolves_to_id,
    };
