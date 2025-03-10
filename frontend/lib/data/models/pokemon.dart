import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/pokemon_type.dart';
import 'package:frontend/data/models/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon extends Equatable {
  final int id;
  final int level;
  final int gender;
  final double height;
  final double weight;
  final String name;
  final String ability;
  final String category;
  final String description;
  final bool is_base_form;
  final int region_id;
  final String imgUrl;
  final List<Type> types;

  List<Type> getStrengthTypesForPokemon() {
    final strengthTypes = types
        .where((t) =>
            t.PokemonTypes.is_weakness == WeaknessStatus.no ||
            t.PokemonTypes.is_weakness == WeaknessStatus.both)
        .toList();

    if (strengthTypes.length > 2) {
      throw Exception("A Pokémon can have at most two strength types.");
    }

    if (strengthTypes.isEmpty) {
      throw Exception("A Pokémon must have at least one strength type.");
    }

    return strengthTypes;
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  const Pokemon(
      {required this.id,
      required this.types,
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
      required this.imgUrl});

  Map<String, dynamic> toJson() => _$PokemonToJson(this);

  @override
  List<Object?> get props => [
        id,
        level,
        gender,
        height,
        weight,
        name,
        ability,
        category,
        description,
        is_base_form,
        region_id,
        imgUrl,
        types
      ];
}
