// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evolution _$EvolutionFromJson(Map<String, dynamic> json) => Evolution(
      id: (json['id'] as num).toInt(),
      pokemon_id: (json['pokemon_id'] as num).toInt(),
      evolves_to_id: (json['evolves_to_id'] as num?)?.toInt(),
      condition: json['condition'] as String?,
    );

Map<String, dynamic> _$EvolutionToJson(Evolution instance) => <String, dynamic>{
      'id': instance.id,
      'pokemon_id': instance.pokemon_id,
      'evolves_to_id': instance.evolves_to_id,
      'condition': instance.condition,
    };
