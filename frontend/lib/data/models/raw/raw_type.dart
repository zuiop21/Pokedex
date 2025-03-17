import 'package:json_annotation/json_annotation.dart';

part 'raw_type.g.dart';

//Class to represent the raw data of a type
@JsonSerializable()
class RawType {
  final int id;
  final String name;
  final String color;
  final String imgUrl;
  final String imgUrlOutline;

  factory RawType.fromJson(Map<String, dynamic> json) =>
      _$RawTypeFromJson(json);

  const RawType({
    required this.id,
    required this.name,
    required this.color,
    required this.imgUrl,
    required this.imgUrlOutline,
  });

  Map<String, dynamic> toJson() => _$RawTypeToJson(this);
}
