import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/type.dart';

class PokemonCircledType extends StatelessWidget {
  final Type strengthsType;
  const PokemonCircledType({super.key, required this.strengthsType});

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
              imageUrl: strengthsType.imgUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
