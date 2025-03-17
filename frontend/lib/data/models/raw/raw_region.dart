import 'package:json_annotation/json_annotation.dart';

part 'raw_region.g.dart';

//Class to represent the raw data of a region
@JsonSerializable()
class RawRegion {
  const RawRegion(
      {required this.id,
      required this.name,
      required this.difficulty,
      required this.imgUrl});

  final int id;
  final String name;
  final int difficulty;
  final String imgUrl;

  factory RawRegion.fromJson(Map<String, dynamic> json) =>
      _$RawRegionFromJson(json);

  Map<String, dynamic> toJson() => _$RawRegionToJson(this);
}
