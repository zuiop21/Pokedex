import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/raw/raw_type.dart';

//Class to represent a type
part 'type.g.dart';

@JsonSerializable()
class Type extends Equatable {
  const Type(
      {required this.isWeakness,
      required this.id,
      required this.name,
      required this.color,
      required this.imgUrl,
      required this.imgUrlOutline});

  @JsonKey(name: 'is_weakness')
  final WeaknessStatus isWeakness;

  final int id;
  final String name;
  final String color;
  final String imgUrl;
  final String imgUrlOutline;

//Method to create a Type object from a RawType and RawPokemonType object
  factory Type.fromRaw(RawType rawType) {
    return Type(
      isWeakness: rawType.is_weakness,
      id: rawType.id,
      name: rawType.name,
      color: rawType.color,
      imgUrl: rawType.imgUrl,
      imgUrlOutline: rawType.imgUrlOutline,
    );
  }

  @override
  List<Object?> get props =>
      [isWeakness, id, name, color, imgUrl, imgUrlOutline];
  Type copyWith(
      {WeaknessStatus? isWeakness,
      int? id,
      int? pokemonId,
      String? name,
      String? color,
      String? imgUrl,
      String? imgUrlOutline}) {
    return Type(
        isWeakness: isWeakness ?? this.isWeakness,
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        imgUrl: imgUrl ?? this.imgUrl,
        imgUrlOutline: imgUrlOutline ?? this.imgUrlOutline);
  }

  Map<String, dynamic> toJson() => _$TypeToJson(this);

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
}
