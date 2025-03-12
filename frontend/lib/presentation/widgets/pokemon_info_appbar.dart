import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/pokemon.dart';
import 'package:frontend/data/models/type.dart';

class PokemonInfoAppbar extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonInfoAppbar({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    List<Type> strengthTypes = pokemon.getStrengthTypesForPokemon();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -MediaQuery.of(context).size.width * 0.6,
          left: -MediaQuery.of(context).size.width * 0.055,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0.75, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.1,
              height: MediaQuery.of(context).size.width * 1.1,
              decoration: BoxDecoration(
                color: Color(int.parse(strengthTypes[0].color)),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: IconButton(
            icon: Icon(Icons.favorite_border_outlined,
                color: Colors.white, size: 28),
            onPressed: () {
              //TODO
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: 135,
              height: 135,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.5, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  imageUrl: strengthTypes[0].imgUrlOutline,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Hero(
            tag: "pokemon-${pokemon.id}",
            child: CachedNetworkImage(
              width: 125,
              height: 125,
              imageUrl: pokemon.imgUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
