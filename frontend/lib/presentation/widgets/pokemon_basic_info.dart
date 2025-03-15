import 'package:flutter/material.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/presentation/widgets/pokemon_tile_types.dart';

class PokemonBasicInfo extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonBasicInfo({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pokemon.name,
              style: TextStyle(fontSize: 36),
            ),
            Text(
              "Number ${pokemon.id}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        PokemonTileTypes(
          pokemon: pokemon,
          leftPadding: 0,
        ),
        Text(pokemon.description, style: TextStyle(fontSize: 18))
      ],
    );
  }
}
