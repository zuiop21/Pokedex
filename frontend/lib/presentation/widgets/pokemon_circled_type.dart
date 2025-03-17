import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/processed/type.dart';

//A widget that displays a type in a circle
class PokemonCircledType extends StatelessWidget {
  final Type type;
  const PokemonCircledType({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.circle,
          size: 25,
          color: Colors.white,
        ),
        SizedBox(
          width: 25,
          height: 25,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CachedNetworkImage(
              imageUrl: type.imgUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
