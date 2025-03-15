import 'package:flutter/material.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/presentation/widgets/pokemon_circled_type.dart';

class PokemonEvolutionTypes extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonEvolutionTypes({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final List<Type> strengthTypes = pokemon.getStrengthTypesForPokemon();
    return Padding(
      padding: EdgeInsets.only(bottom: 5, right: 30),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(int.parse(strengthTypes[0].color)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(child: PokemonCircledType(type: strengthTypes[0])),
          ),
          if (strengthTypes.length == 2)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(int.parse(strengthTypes[1].color)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child:
                    Center(child: PokemonCircledType(type: strengthTypes[1])),
              ),
            ),
        ],
      ),
    );
  }
}
