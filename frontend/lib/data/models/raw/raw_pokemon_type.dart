import 'package:json_annotation/json_annotation.dart';

part 'raw_pokemon_type.g.dart';

enum WeaknessStatus { yes, no, both }

//Class to represent the raw data of a pokemon type
@JsonSerializable()
class RawPokemonType {
  final int id;
  final int pokemon_id;
  final int type_id;
  final WeaknessStatus is_weakness;

  factory RawPokemonType.fromJson(Map<String, dynamic> json) =>
      _$RawPokemonTypeFromJson(json);

  const RawPokemonType({
    required this.is_weakness,
    required this.id,
    required this.pokemon_id,
    required this.type_id,
  });

  Map<String, dynamic> toJson() => _$RawPokemonTypeToJson(this);
}
