import 'package:frontend/data/models/raw/raw_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'raw_pokemon.g.dart';

//Class to represent the raw data of a pokemon
@JsonSerializable()
class RawPokemon {
  final int id;
  final int level;
  final double gender;
  final double height;
  final double weight;
  final String name;
  final String ability;
  final String category;
  final String description;
  final bool is_base_form;
  final int? region_id;
  final String imgUrl;
  final List<RawType> types;

  RawPokemon(
      {required this.id,
      required this.level,
      required this.gender,
      required this.height,
      required this.weight,
      required this.name,
      required this.ability,
      required this.category,
      required this.description,
      required this.is_base_form,
      required this.region_id,
      required this.types,
      required this.imgUrl});

  factory RawPokemon.fromJson(Map<String, dynamic> json) =>
      _$RawPokemonFromJson(json);

  Map<String, dynamic> toJson() => _$RawPokemonToJson(this);
}
