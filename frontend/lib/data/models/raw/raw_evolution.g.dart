// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_evolution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawEvolution _$RawEvolutionFromJson(Map<String, dynamic> json) => RawEvolution(
      id: (json['id'] as num).toInt(),
      pokemon_id: (json['pokemon_id'] as num).toInt(),
      evolves_to_id: (json['evolves_to_id'] as num?)?.toInt(),
      condition: json['condition'] as String?,
    );

Map<String, dynamic> _$RawEvolutionToJson(RawEvolution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pokemon_id': instance.pokemon_id,
      'evolves_to_id': instance.evolves_to_id,
      'condition': instance.condition,
    };
