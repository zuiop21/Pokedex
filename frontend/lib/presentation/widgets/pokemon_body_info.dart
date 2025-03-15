import 'package:flutter/material.dart';
import 'package:frontend/data/models/processed/pokemon.dart';

import 'package:frontend/presentation/widgets/pokemon_gender_container.dart';
import 'package:frontend/presentation/widgets/pokemon_info_container.dart';

class PokemonBodyInfo extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonBodyInfo({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 40,
          child: Row(
            children: [
              PokemonInfoContainer(
                  padding: EdgeInsets.only(right: 5),
                  icon: Icons.line_weight,
                  data: "${pokemon.weight} kg",
                  dataName: "Weight"),
              PokemonInfoContainer(
                  padding: EdgeInsets.only(left: 5),
                  icon: Icons.height,
                  data: "${pokemon.height} m",
                  dataName: "Height"),
            ],
          ),
        ),
        Expanded(
          flex: 40,
          child: Row(
            children: [
              PokemonInfoContainer(
                  padding: EdgeInsets.only(right: 5),
                  icon: Icons.category,
                  data: pokemon.category.endsWith(" Pokémon")
                      ? pokemon.category
                          .substring(0, pokemon.category.length - 8)
                      : pokemon.category,
                  dataName: "Category"),
              PokemonInfoContainer(
                  padding: EdgeInsets.only(left: 5),
                  icon: Icons.accessibility,
                  data: pokemon.ability,
                  dataName: "Ability"),
            ],
          ),
        ),
        Expanded(
          flex: 30,
          child: PokemonGenderContainer(
            gender: pokemon.gender,
          ),
        )
      ],
    );
  }
}
