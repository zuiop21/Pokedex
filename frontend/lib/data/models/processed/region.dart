import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/raw/raw_region.dart';

//Class to represent a region
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

//Method to create a Region object from a RawRegion object
  factory Region.fromRaw(RawRegion rawRegion) {
    return Region(
        id: rawRegion.id,
        name: rawRegion.name,
        difficulty: rawRegion.difficulty,
        imgUrl: rawRegion.imgUrl);
  }

  @override
  List<Object?> get props => [id, name, difficulty, imgUrl];
  Region copyWith({int? id, String? name, int? difficulty, String? imgUrl}) {
    return Region(
        id: id ?? this.id,
        name: name ?? this.name,
        difficulty: difficulty ?? this.difficulty,
        imgUrl: imgUrl ?? this.imgUrl);
  }
}
