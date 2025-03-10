// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonType _$PokemonTypeFromJson(Map<String, dynamic> json) => PokemonType(
      is_weakness: $enumDecode(_$WeaknessStatusEnumMap, json['is_weakness']),
    );

Map<String, dynamic> _$PokemonTypeToJson(PokemonType instance) =>
    <String, dynamic>{
      'is_weakness': _$WeaknessStatusEnumMap[instance.is_weakness]!,
    };

const _$WeaknessStatusEnumMap = {
  WeaknessStatus.yes: 'yes',
  WeaknessStatus.no: 'no',
  WeaknessStatus.both: 'both',
};
