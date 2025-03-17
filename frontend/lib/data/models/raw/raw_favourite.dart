import 'package:json_annotation/json_annotation.dart';

part 'raw_favourite.g.dart';

//Class to represent the raw data of a favourite
@JsonSerializable()
class RawFavourite {
  final int id;
  final int user_id;
  final int pokemon_id;

  factory RawFavourite.fromJson(Map<String, dynamic> json) =>
      _$RawFavouriteFromJson(json);

  const RawFavourite(
      {required this.id, required this.user_id, required this.pokemon_id});

  Map<String, dynamic> toJson() => _$RawFavouriteToJson(this);
}
