import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_type.g.dart';

enum WeaknessStatus { yes, no, both }

@JsonSerializable()
class PokemonType extends Equatable {
  final WeaknessStatus is_weakness;

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);

  const PokemonType({required this.is_weakness});

  Map<String, dynamic> toJson() => _$PokemonTypeToJson(this);

  @override
  List<Object?> get props => [is_weakness];
}
