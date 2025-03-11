import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/pokemon_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type.g.dart';

@JsonSerializable(explicitToJson: true)
class Type extends Equatable {
  final String name;
  final String color;
  final String imgUrl;
  final String imgUrlOutline;

  @JsonKey(includeIfNull: false)
  final PokemonType? PokemonTypes;

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  const Type({
    required this.name,
    required this.color,
    required this.imgUrl,
    required this.imgUrlOutline,
    this.PokemonTypes,
  });

  Map<String, dynamic> toJson() => _$TypeToJson(this);

  @override
  List<Object?> get props => [name, color, imgUrl, imgUrlOutline, PokemonTypes];
}
