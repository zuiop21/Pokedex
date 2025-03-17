import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/raw/raw_pokemon_type.dart';
import 'package:frontend/data/models/raw/raw_type.dart';

//Class to represent a type
class Type extends Equatable {
  const Type(
      {required this.isWeakness,
      required this.id,
      required this.pokemonId,
      required this.name,
      required this.color,
      required this.imgUrl,
      required this.imgUrlOutline});

  final WeaknessStatus isWeakness;
  final int id;
  final int pokemonId;
  final String name;
  final String color;
  final String imgUrl;
  final String imgUrlOutline;

//Method to create a Type object from a RawType and RawPokemonType object
  factory Type.fromRaw(RawType rawType, RawPokemonType rawPokemonType) {
    return Type(
        isWeakness: rawPokemonType.is_weakness,
        id: rawType.id,
        name: rawType.name,
        color: rawType.color,
        imgUrl: rawType.imgUrl,
        imgUrlOutline: rawType.imgUrlOutline,
        pokemonId: rawPokemonType.pokemon_id);
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
        pokemonId: pokemonId ?? this.pokemonId,
        name: name ?? this.name,
        color: color ?? this.color,
        imgUrl: imgUrl ?? this.imgUrl,
        imgUrlOutline: imgUrlOutline ?? this.imgUrlOutline);
  }
}
