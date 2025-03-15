// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_favourite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawFavourite _$RawFavouriteFromJson(Map<String, dynamic> json) => RawFavourite(
      id: (json['id'] as num).toInt(),
      user_id: (json['user_id'] as num).toInt(),
      pokemon_id: (json['pokemon_id'] as num).toInt(),
    );

Map<String, dynamic> _$RawFavouriteToJson(RawFavourite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'pokemon_id': instance.pokemon_id,
    };
