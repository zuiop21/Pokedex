import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'evolution.g.dart';

@JsonSerializable(explicitToJson: true)
class Evolution extends Equatable {
  const Evolution(
      {required this.id,
      required this.pokemon_id,
      required this.evolves_to_id,
      required this.condition});

  final int id;
  final int pokemon_id;
  final int? evolves_to_id;
  final String? condition;

  factory Evolution.fromJson(Map<String, dynamic> json) =>
      _$EvolutionFromJson(json);

  Map<String, dynamic> toJson() => _$EvolutionToJson(this);

  @override
  List<Object?> get props => [id, pokemon_id, evolves_to_id, condition];
}
