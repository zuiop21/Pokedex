// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_pokemon_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawPokemonType _$RawPokemonTypeFromJson(Map<String, dynamic> json) =>
    RawPokemonType(
      is_weakness: $enumDecode(_$WeaknessStatusEnumMap, json['is_weakness']),
      id: (json['id'] as num).toInt(),
      pokemon_id: (json['pokemon_id'] as num).toInt(),
      type_id: (json['type_id'] as num).toInt(),
    );

Map<String, dynamic> _$RawPokemonTypeToJson(RawPokemonType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pokemon_id': instance.pokemon_id,
      'type_id': instance.type_id,
      'is_weakness': _$WeaknessStatusEnumMap[instance.is_weakness]!,
    };

const _$WeaknessStatusEnumMap = {
  WeaknessStatus.yes: 'yes',
  WeaknessStatus.no: 'no',
  WeaknessStatus.both: 'both',
};
