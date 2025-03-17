import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';

import 'package:frontend/presentation/widgets/pokemon_gender_container.dart';
import 'package:frontend/presentation/widgets/pokemon_info_container.dart';

//A widget that displays some basic information of a pokemon
//Such as the weight, height, category and ability
class PokemonBodyInfo extends StatelessWidget {
  final int pokemonId;
  const PokemonBodyInfo({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final pokemon = context.read<PokemonBloc>().state.getPokemonById(pokemonId);
    return Column(
      children: [
        Expanded(
          flex: 40,
          child: Row(
            children: [
              PokemonInfoContainer(
                  padding: EdgeInsets.only(right: 5),
                  icon: Icons.line_weight,
                  data: "${pokemon!.weight} kg",
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
