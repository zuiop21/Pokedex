import 'package:json_annotation/json_annotation.dart';

part 'raw_evolution.g.dart';

//Class to represent the raw data of an evolution
@JsonSerializable()
class RawEvolution {
  const RawEvolution(
      {required this.id,
      required this.pokemon_id,
      required this.evolves_to_id,
      required this.condition});

  final int id;
  final int pokemon_id;
  final int? evolves_to_id;
  final String? condition;

  factory RawEvolution.fromJson(Map<String, dynamic> json) =>
      _$RawEvolutionFromJson(json);

  Map<String, dynamic> toJson() => _$RawEvolutionToJson(this);
}
