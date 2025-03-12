import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region.g.dart';

@JsonSerializable(explicitToJson: true)
class Region extends Equatable {
  const Region(
      {required this.id,
      required this.name,
      required this.difficulty,
      required this.imgUrl});

  final int id;
  final String name;
  final int difficulty;
  final String imgUrl;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);

  @override
  List<Object?> get props => [id, name, difficulty, imgUrl];
}
