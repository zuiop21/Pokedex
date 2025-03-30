import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/raw/raw_pokemon.dart';
import 'package:frontend/data/models/processed/type.dart';

enum WeaknessStatus { yes, no, both }

//Class to represent a pokemon
class Pokemon extends Equatable {
  final int id;
  final int level;
  final double gender;
  final double height;
  final double weight;
  final String name;
  final String ability;
  final String category;
  final String description;
  final bool isBaseForm;
  final String imgUrl;
  final bool isFavourited;
  final int regionId;
  final List<Type> types;
  final Pokemon? evolvesTo;

//Getter method to get the strength types for a pokemon
  List<Type> getStrengthTypesForPokemon() {
    final strengthTypes = types
        .where((t) =>
            t.isWeakness == WeaknessStatus.both ||
            t.isWeakness == WeaknessStatus.no)
        .toList();
    if (strengthTypes.isEmpty) {
      return [
        Type(
          id: 0,
          name: "None",
          color: "0xFF999999",
          imgUrlOutline: "",
          isWeakness: WeaknessStatus.both,
          imgUrl: "",
        )
      ];
    } else {
      return strengthTypes;
    }
  }

//Getter method to get the weakness types for a pokemon
  List<Type> getWeaknessTypesForPokemon() {
    final weaknessTypes = types
        .where((t) =>
            t.isWeakness == WeaknessStatus.both ||
            t.isWeakness == WeaknessStatus.yes)
        .toList();

    if (weaknessTypes.isEmpty) {
      return [
        Type(
          id: 0,
          name: "None",
          color: "0xFF999999",
          imgUrlOutline: "",
          isWeakness: WeaknessStatus.both,
          imgUrl: "",
        )
      ];
    } else {
      return weaknessTypes;
    }
  }

  Pokemon updateTypes(Type type) {
    final List<Type> updatedTypes = types.map((t) {
      if (t.id == type.id) {
        return t.copyWith(color: type.color, name: type.name);
      }
      return t;
    }).toList();

    return copyWith(types: updatedTypes);
  }

  Pokemon deleteType(Type type) {
    final List<Type> updatedTypes =
        types.where((t) => t.id != type.id).toList();

    return copyWith(types: updatedTypes);
  }

  const Pokemon(
      {required this.id,
      required this.level,
      required this.gender,
      required this.height,
      required this.weight,
      required this.name,
      required this.ability,
      required this.category,
      required this.description,
      required this.isBaseForm,
      required this.imgUrl,
      required this.isFavourited,
      required this.regionId,
      required this.types,
      this.evolvesTo});

//Method to create a Pokemon object from a RawPokemon object
  factory Pokemon.fromRaw(RawPokemon rawPokemon) {
    return Pokemon(
        id: rawPokemon.id,
        level: rawPokemon.level,
        gender: rawPokemon.gender,
        height: rawPokemon.height,
        weight: rawPokemon.weight,
        name: rawPokemon.name,
        ability: rawPokemon.ability,
        category: rawPokemon.category,
        description: rawPokemon.description,
        isBaseForm: rawPokemon.is_base_form,
        imgUrl: rawPokemon.imgUrl,
        regionId: rawPokemon.region_id,
        types: rawPokemon.types.map((t) => Type.fromRaw(t)).toList(),
        isFavourited: false);
  }

  @override
  List<Object?> get props => [
        id,
        level,
        gender,
        height,
        weight,
        name,
        ability,
        category,
        description,
        isBaseForm,
        imgUrl,
        evolvesTo,
        isFavourited,
        regionId
      ];
  Pokemon copyWith(
      {int? id,
      int? level,
      double? gender,
      double? height,
      double? weight,
      String? name,
      String? ability,
      String? category,
      String? description,
      bool? isBaseForm,
      String? imgUrl,
      bool? isFavourited,
      int? regionId,
      List<Type>? types,
      ValueGetter<Pokemon?>? evolvesTo}) {
    return Pokemon(
        id: id ?? this.id,
        level: level ?? this.level,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        name: name ?? this.name,
        ability: ability ?? this.ability,
        category: category ?? this.category,
        description: description ?? this.description,
        isBaseForm: isBaseForm ?? this.isBaseForm,
        imgUrl: imgUrl ?? this.imgUrl,
        isFavourited: isFavourited ?? this.isFavourited,
        regionId: regionId ?? this.regionId,
        types: types ?? this.types,
        evolvesTo: evolvesTo != null ? evolvesTo() : this.evolvesTo);
  }
}
