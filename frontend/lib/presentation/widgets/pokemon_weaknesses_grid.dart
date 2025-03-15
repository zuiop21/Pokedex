import 'package:flutter/material.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/presentation/widgets/pokemon_circled_type.dart';

class PokemonWeaknessesGrid extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonWeaknessesGrid({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final weaknesses = pokemon.getWeaknessTypesForPokemon();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weaknesses",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3.5,
            ),
            itemCount: weaknesses.length,
            itemBuilder: (context, index) {
              final type = weaknesses[index];

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(int.parse(type.color)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PokemonCircledType(type: type),
                    const SizedBox(width: 5),
                    Text(
                      type.name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
