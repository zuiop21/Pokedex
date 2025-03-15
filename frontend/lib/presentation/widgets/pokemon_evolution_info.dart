import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/presentation/widgets/pokemon_evolves_to_container.dart';

class PokemonEvolutionInfo extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonEvolutionInfo({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final evolutionChain =
        context.read<PokemonBloc>().state.findEvolutionChain(pokemon);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Evolutions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.lightGrey, width: 1),
            color: Colors.white,
          ),
          child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 0,
              childAspectRatio: 2.5,
            ),
            itemCount: evolutionChain.length,
            itemBuilder: (context, index) {
              return PokemonEvolvesToContainer(
                pokemon: evolutionChain[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
