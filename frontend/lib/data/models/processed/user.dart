import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/raw/raw_user.dart';
import 'package:json_annotation/json_annotation.dart';

//Class to represent the raw data of a user
@JsonSerializable()
class User extends Equatable {
  final int id;
  final String role;
  final int regionId;
  final String name;
  final String email;
  final String? imgUrl;
  final bool isLocked;

  const User(
      {required this.id,
      required this.role,
      required this.regionId,
      required this.name,
      required this.email,
      required this.isLocked,
      this.imgUrl});

  factory User.fromRaw(RawUser rawUser) {
    return User(
        id: rawUser.id,
        role: rawUser.role,
        regionId: rawUser.region_id ?? 0,
        name: rawUser.name,
        email: rawUser.email,
        isLocked: rawUser.is_locked,
        imgUrl: rawUser.imgUrl);
  }
  User copyWith(
      {int? id,
      String? role,
      int? regionId,
      String? name,
      String? email,
      ValueGetter<String?>? imgUrl,
      bool? isLocked}) {
    return User(
        id: id ?? this.id,
        role: role ?? this.role,
        regionId: regionId ?? this.regionId,
        name: name ?? this.name,
        email: email ?? this.email,
        imgUrl: imgUrl != null ? imgUrl() : this.imgUrl,
        isLocked: isLocked ?? this.isLocked);
  }

  @override
  List<Object?> get props =>
      [id, role, regionId, name, email, imgUrl, isLocked];
}
